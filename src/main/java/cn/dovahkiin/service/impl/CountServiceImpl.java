package cn.dovahkiin.service.impl;

import cn.dovahkiin.mapper.CountMapper;
import cn.dovahkiin.mapper.CustomerMapper;
import cn.dovahkiin.mapper.SystemConfigMapper;
import cn.dovahkiin.model.SystemConfig;
import cn.dovahkiin.model.dto.CustomerEffectDto;
import cn.dovahkiin.model.dto.DayEffectDto;
import cn.dovahkiin.model.dto.EffectCountDto;
import cn.dovahkiin.model.dto.LastDayEffectDto;
import cn.dovahkiin.service.ICountService;
import cn.dovahkiin.util.Const;
import cn.dovahkiin.util.excel.ExcelConst;
import com.alibaba.fastjson.JSON;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.NumberFormat;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

/**
 * <p>
 * 统计服务
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Service
public class CountServiceImpl implements ICountService {
    private static final org.slf4j.Logger log = LoggerFactory.getLogger(CountServiceImpl.class);
    private CountMapper countMapper;
    private CustomerMapper customerMapper;
    private SystemConfigMapper systemConfigMapper;
    @Autowired
    public void setCountMapper(CountMapper countMapper) { this.countMapper = countMapper; }
    @Autowired
    public void setCustomerMapper(CustomerMapper customerMapper) { this.customerMapper = customerMapper; }
    @Autowired
    public void setSystemConfigMapper(SystemConfigMapper systemConfigMapper) {
        this.systemConfigMapper = systemConfigMapper;
    }

    @Override
    public List<Map> count1(Map map) {
        return countMapper.count1(map);
    }
    @Override
    public List<Map> countByModel(Map map) {
        return countMapper.countByModel(map);
    }

    @Override
    public EffectCountDto countEffConTimeCut(Map map) {
        EffectCountDto countDto = new EffectCountDto();
        SystemConfig defaultConfig = systemConfigMapper.selectBySupplierId(null);
        map.put("defaultConfig",defaultConfig);
        Date end =  (Date)map.get(Const.RECORED_DATE_END);
        /* 查出所有在有效期内有消耗的素材 */
        List<CustomerEffectDto> customerEffectOnes_all = countMapper.selectEffectCustomer(map);
        /*获得所有数据*/
        for(CustomerEffectDto effectDto:customerEffectOnes_all){
            map.put(Const.customerCode,effectDto.getCode());
            map.put(Const.RECORED_DATE_Last, effectDto.getEndDate());
            List<DayEffectDto> dayEffectDtos ;
            /* 有溢出的 */
            if(effectDto.getSumCon() > effectDto.getMaxEffectOn()   ){
                /* 找出最后一天的溢出了多少 */
                LastDayEffectDto lastDayEffectDto = countMapper.selectLastDay(map);

                // 最后一天的溢出
                Double out = 0d;
                if(lastDayEffectDto!=null && lastDayEffectDto.getSumCon()!=null && lastDayEffectDto.getMaxEffectOn()!=null  )out=lastDayEffectDto.getSumCon() - lastDayEffectDto.getMaxEffectOn();
                if(lastDayEffectDto!=null){
                    map.put(Const.RECORED_DATE_Last, lastDayEffectDto.getRecoredDate());
                    effectDto.setEndDate(lastDayEffectDto.getRecoredDate());
                }
                dayEffectDtos = countMapper.selectEveryDayCon(map);
                if(lastDayEffectDto!=null){
                    for(DayEffectDto dayEffectDto:dayEffectDtos){
                        // 减去最后一天的溢出
                        if(dayEffectDto.getRecoredDate().equals(lastDayEffectDto.getRecoredDate())){
                            dayEffectDto.setConsumptionEffect(dayEffectDto.getConsumptionEffect()-out);
                            break;
                        }
                    }
                }
            }
            else {
                /* 没溢出的 */
                dayEffectDtos = countMapper.selectEveryDayCon(map);
            }

            effectDto.setData(dayEffectDtos);
        }


        /*并行 处理收入&支出，每个素材可单独并行处理*/
        customerEffectOnes_all.parallelStream().forEach((dto -> {
            if(dto.getSumCon()>dto.getMaxEffectOn())dto.setSumCon(dto.getMaxEffectOn());
            /*每日数据可单独处理，不影响*/
            AtomicBoolean addPrice = new AtomicBoolean(false);
            dto.getData().parallelStream().forEach(dayEffectDto -> {
                 dayEffectDto.setIncome( dayEffectDto.getConsumptionEffect() * dto.getIncomeRadio()/100d);
                 dayEffectDto.setPay(dayEffectDto.getConsumptionEffect() * dto.getPayRadio()/100d);
                 if(dto.getCompleteDate().equals(dayEffectDto.getRecoredDate()) ){
                     if(dto.getBasePrice() !=null ) dayEffectDto.setIncome(dto.getBasePrice() +dayEffectDto.getIncome()  );else dayEffectDto.setIncome(0d );
                     if(dto.getBasePay()!=null)dayEffectDto.setPay(dto.getBasePay() +dayEffectDto.getPay() );else dayEffectDto.setPay(0d);
                     addPrice.set(true);
                 }
            });
            if(!addPrice.get()){
                // 没有成片日期那天的数据，新增一个
                /* 收入统计加上固定价格 */
                DayEffectDto dayEffectDto = new DayEffectDto(dto.getCode(),dto.getCompleteDate(),dto.getBasePrice(),dto.getBasePay());
                dto.addData(dayEffectDto);
            }
        }));
        /*统计素材的收入和&支出和*/
        customerEffectOnes_all.parallelStream().forEach(dto->{
            if(dto.getSumIncome()==null)dto.setSumIncome(0d);
            if(dto.getSumPay()==null)dto.setSumPay(0d);
            AtomicReference<Double> sumIncome = new AtomicReference<>(0d);
            AtomicReference<Double> sumPay = new AtomicReference<>(0d);
            dto.getData().forEach(dayEffectDto ->{
                sumIncome.updateAndGet(v -> v + (dayEffectDto.getIncome()==null?0d: dayEffectDto.getIncome())   );
                sumPay.updateAndGet(v -> v + (dayEffectDto.getPay()==null?0d:dayEffectDto.getPay()));
            } );
            dto.setSumIncome(sumIncome.get());
            dto.setSumPay(sumPay.get());
        });

        countDto.setAllPrimaryData(customerEffectOnes_all);
        /* 串行处理求和 */
        AtomicReference<Double> totalSumCon = new AtomicReference<>(0d);
        /*总素材数量*/
        AtomicInteger totalCus= new AtomicInteger();
        /*总收入&支出求和*/
        AtomicReference<Double> totalSumIncome= new AtomicReference<>(0d);
        AtomicReference<Double> totalSumPay= new AtomicReference<>(0d);
        /*注意线程安全*/
        Map<Long ,DayEffectDto> dayEffectDtoMap = new ConcurrentHashMap<>();
        customerEffectOnes_all.forEach(dto -> {
            totalCus.getAndIncrement();
            dto.getData().forEach(dayEffectDto -> {
                totalSumIncome.updateAndGet(v -> v + dayEffectDto.getIncome());
                totalSumPay.updateAndGet(v -> v + dayEffectDto.getPay());
                totalSumCon.updateAndGet(v -> v + dayEffectDto.getConsumptionEffect());
                DayEffectDto effectDto=dayEffectDtoMap.get(dayEffectDto.getRecoredDate().getTime());
                if(effectDto==null) effectDto = new DayEffectDto(dayEffectDto.getRecoredDate());
                effectDto.setConsumptionEffect(effectDto.getConsumptionEffect() + dayEffectDto.getConsumptionEffect());
                effectDto.setIncome(effectDto.getIncome() + dayEffectDto.getIncome());
                effectDto.setPay(effectDto.getPay() + dayEffectDto.getPay());
                effectDto.setCode(dto.getCode());
                dayEffectDtoMap.put(effectDto.getRecoredDate().getTime(),effectDto);
            });
        });

        List<DayEffectDto> dayEffectDtoList = new ArrayList<>(dayEffectDtoMap.size());
        dayEffectDtoList.addAll(dayEffectDtoMap.values());
        countDto.setTotalDailSumCon(dayEffectDtoList);
        countDto.setTotalSumIncome(totalSumIncome.get());
        countDto.setTotalSumPay(totalSumPay.get());
        countDto.setTotalCus(totalCus.get());
        countDto.setTotalSumCon(totalSumCon.get());

        return countDto;
    }

    @Override
    public Workbook handleEffConTimeToExcel(EffectCountDto effectCountDto) {
        Workbook workbook= new XSSFWorkbook();
        if(effectCountDto==null || effectCountDto.getAllPrimaryData()==null || effectCountDto.getAllPrimaryData().size()==0)return workbook;
        NumberFormat nf = NumberFormat.getNumberInstance();
        nf.setMaximumFractionDigits(3);
        Sheet sheetCus = workbook.createSheet("素材");
        String [] headCus = new String[]{ "名称","编号","封顶消耗","有效消耗", "收入","支出", "固定收入","固定支出","收入比率(%)","支出比率(%)","成片日期","有效期至（实际）" };
        Row headRowCus = sheetCus.createRow(0);
        for(int i=0;i<headCus.length;i++){
            Cell cell = headRowCus.createCell(i);
            cell.setCellValue(headCus[i]);
            sheetCus.setColumnWidth(i, 4000);
        }
        sheetCus.setColumnWidth(0, 12000);
        sheetCus.setColumnWidth(10, 6000);
        sheetCus.setColumnWidth(11, 6000);

        List<CustomerEffectDto> customerEffectDtos=effectCountDto.getAllPrimaryData();
        AtomicInteger index= new AtomicInteger(0);
        customerEffectDtos.forEach(dto->{
            if(dto==null)return;
            int m = index.get();
            index.getAndIncrement();
            Row row= sheetCus.createRow(m+1);
            for(int i=0;i<headCus.length;i++){
                Cell cell = row.createCell(i);
                switch (i){
                    case 0:cell.setCellValue(dto.getName());break;
                    case 1:cell.setCellValue(dto.getCode());break;
                    case 2:cell.setCellValue(dto.getMaxEffectOn());break;
                    case 3:cell.setCellValue(dto.getSumCon());break;
                    case 4:cell.setCellValue(dto.getSumIncome());break;
                    case 5:cell.setCellValue(dto.getSumPay());break;
                    case 6: if(dto.getPriceLevelName()!=null) cell.setCellValue( dto.getPriceLevelName()+" ￥ "+  dto.getBasePrice());
                    break;
                    case 7: if(dto.getPayLevelName()!=null) cell.setCellValue( dto.getPayLevelName()+" ￥ "+  dto.getBasePay());
                    break;
                    case 8:cell.setCellValue(dto.getIncomeRadio());break;
                    case 9:cell.setCellValue(dto.getPayRadio());break;
                    case 10:
                        cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                        cell.setCellValue(dto.getCompleteDate());
                        break;
                    case 11:
                        cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                        cell.setCellValue(dto.getEndDate());
                        break;
                }
            }
        });

/*
        for(int m=0;m<customerEffectDtos.size();m++){
            Row row= sheetCus.createRow(m+1);
            CustomerEffectDto customerEffectDto = customerEffectDtos.get(m);
            for(int i=0;i<headCus.length;i++){
                Cell cell = row.createCell(i);
                switch (i){
                    case 0:cell.setCellValue(customerEffectDto.getName());break;
                    case 1:cell.setCellValue(customerEffectDto.getCode());break;
                }
            }
        }
*/
        return workbook;
    }
}
