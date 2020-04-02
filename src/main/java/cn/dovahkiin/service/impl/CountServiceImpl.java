package cn.dovahkiin.service.impl;

import cn.dovahkiin.mapper.CountMapper;
import cn.dovahkiin.mapper.CustomerMapper;
import cn.dovahkiin.mapper.SystemConfigMapper;
import cn.dovahkiin.model.SystemConfig;
import cn.dovahkiin.model.dto.*;
import cn.dovahkiin.service.ICountService;
import cn.dovahkiin.util.Const;
import cn.dovahkiin.util.excel.ExcelConst;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.InvocationTargetException;
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
    public List<ModelCountDto> countByModel(Map map) {
        return countMapper.countByModel(map);
    }

    @Override
    public Workbook handleModelCountToExcel(List<ModelCountDto> modelCountDtoList, String sort, String order) {
        Workbook workbook= new XSSFWorkbook();
        if(modelCountDtoList==null || modelCountDtoList.size()==0)return workbook;
        NumberFormat nf = NumberFormat.getNumberInstance();
        nf.setMaximumFractionDigits(2);
        Sheet sheetCus = workbook.createSheet("分组统计");
        String [] headCus = new String[]{ "名称","编号","消耗", "记录数"};
        Row headRowCus = sheetCus.createRow(0);
        for(int i=0;i<headCus.length;i++){
            Cell cell = headRowCus.createCell(i);
            cell.setCellValue(headCus[i]);
            sheetCus.setColumnWidth(i, 4000);
        }
        sheetCus.setColumnWidth(1, 12000);

        modelCountDtoList.sort((dto1,dto2)->{
            int end = 0;
            if(sort==null)return end;
            switch (sort){
                case "consumption":end = (int) ((dto1.getConsumption() - dto2.getConsumption())*1000D);break;
                case "code":
                    if(dto1.getCode()!=null && dto2.getCode()!=null) end = dto1.getCode().compareTo(dto2.getCode());
                    break;
                case "name":
                    if(dto1.getName()!=null && dto2.getName()!=null) end = dto1.getName().compareTo(dto2.getName());
                    break;
                case "total":
                    end = dto1.getTotal()-dto2.getTotal();
            }
            if("desc".equals(order))end = -end;
            return end;
        });
        for(int i=0;i<modelCountDtoList.size();i++){
            Row row = sheetCus.createRow(i+1);
            ModelCountDto modelCountDto = modelCountDtoList.get(i);
            if(modelCountDto==null)continue;
            for(int j=0;j<headCus.length;j++){
                Cell cell = row .createCell(j);
                if(j==0)cell.setCellValue(modelCountDto.getName());
                else if(j==1)cell.setCellValue(modelCountDto.getCode());
                else if(j==2)cell.setCellValue(nf.format(modelCountDto.getConsumption()));
                else if(j==3)cell.setCellValue(modelCountDto.getTotal());
            }
        }
        return workbook;
    }

    @Override
    public EffectCountDto countEffConTimeCut(Map map) {
//        EffectCountDto countDto = new EffectCountDto();
        SystemConfig defaultConfig = systemConfigMapper.selectBySupplierId(null);
        map.put("defaultConfig",defaultConfig);
        String maxValue = "maxValue";
        Date end =  (Date)map.get(Const.RECORED_DATE_END);
        Date start =  (Date)map.get(Const.RECORED_DATE_START);
        /* 查出所有在有效期内有消耗的素材 */
        List<CustomerEffectDto> customerEffectOnes_all = countMapper.selectEffectCustomer(map);
        /*获得所有数据*/
        for(CustomerEffectDto effectDto:customerEffectOnes_all){
            map.put(Const.completeDateLimit,effectDto.getCompleteDate());
            map.put(Const.customerCode,effectDto.getCode());
            map.put(Const.RECORED_DATE_Last, effectDto.getEndDate());
            effectDto.setPayEndDate(effectDto.getEndDate());
            effectDto.setIncomeEndDate(effectDto.getEndDate());
            List<DayEffectDto> dayEffectDtos = null;
            /* 有溢出的 */
            if(effectDto.getSumAllEffCon() > effectDto.getMaxEffectOn() || effectDto.getSumAllEffCon()>effectDto.getPayMaxEffectOn()  ){
                /* 找出最后一天的溢出了多少 */

                List<DayEffectDto> dayEffectDtos_income = new Vector<DayEffectDto>();
                List<DayEffectDto> dayEffectDtos_pay = new Vector<DayEffectDto>();
                List<DayEffectDto> dayEffectDtos_pay_temp= new Vector<DayEffectDto>();
                Double out = 0d,outPay=0d;
                /** import 重要 ，如果收入，支出的结束在同一天，查询数据每日消耗返回的数据 可能是同一个对象 ！！！！同一个对象 ！！！！同一个对象 ！！！！同一个对象 ！！！！  */
                // 收入
                if(effectDto.getSumAllEffCon() > effectDto.getMaxEffectOn() ){
                    map.put(maxValue,effectDto.getMaxEffectOn());
                    LastDayEffectDto lastDayEffectDto = countMapper.selectLastDay(map);
                    // 最后一天的溢出
                    if(lastDayEffectDto!=null && lastDayEffectDto.getSumCon()!=null &&effectDto.getMaxEffectOn()!=null  )out=lastDayEffectDto.getSumCon() - effectDto.getMaxEffectOn();
                    if(lastDayEffectDto!=null){
                        map.put(Const.RECORED_DATE_Last, lastDayEffectDto.getRecoredDate());
                        effectDto.setIncomeEndDate(lastDayEffectDto.getRecoredDate());
                    }
                    dayEffectDtos_income .addAll(countMapper.selectEveryDayCon(map)) ;
                }else{
                    map.put(Const.RECORED_DATE_Last, effectDto.getIncomeEndDate());
                    dayEffectDtos_income .addAll(countMapper.selectEveryDayCon(map)) ;
                }
                map.remove(maxValue);
                //支出
                if(effectDto.getSumAllEffCon()>effectDto.getPayMaxEffectOn() ){
                    map.put(maxValue,effectDto.getPayMaxEffectOn());
                    LastDayEffectDto lastDayEffectDtoPay = countMapper.selectLastDay(map);
                    if(lastDayEffectDtoPay!=null && lastDayEffectDtoPay.getSumCon()!=null && effectDto.getPayMaxEffectOn()!=null  )outPay=lastDayEffectDtoPay.getSumCon() - effectDto.getPayMaxEffectOn();
                    if(lastDayEffectDtoPay!=null){
                        map.put(Const.RECORED_DATE_Last, lastDayEffectDtoPay.getRecoredDate());
                        effectDto.setPayEndDate(lastDayEffectDtoPay.getRecoredDate());
                    }
                    dayEffectDtos_pay_temp.addAll(countMapper.selectEveryDayCon(map))  ;
                }
                else{
                    map.put(maxValue,effectDto.getPayMaxEffectOn());
                    map.put(Const.RECORED_DATE_Last, effectDto.getPayEndDate());
                    dayEffectDtos_pay_temp .addAll(countMapper.selectEveryDayCon(map)) ;
                }
                map.remove(maxValue);

                dayEffectDtos_pay_temp.parallelStream().forEach(dayEffectDto -> {
                        DayEffectDto DTO = new DayEffectDto();
                    try {
                        BeanUtils.copyProperties(DTO,dayEffectDto);
                        dayEffectDtos_pay .add( DTO ) ;
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    } catch (InvocationTargetException e) {
                        e.printStackTrace();
                    }
                });
                Double finalOutPay = outPay;
                dayEffectDtos_pay.parallelStream().forEach(dayEffectDto -> {
                    if(dayEffectDto.getRecoredDate().equals(effectDto.getPayEndDate())){
                        dayEffectDto.setConsumptionEffect(dayEffectDto.getConsumptionEffect() - finalOutPay);
                    }
                });
                Double finalOut = out;
                dayEffectDtos_income.parallelStream().forEach(dayEffectDto -> {
                    if(dayEffectDto.getRecoredDate().equals(effectDto.getIncomeEndDate())){
                        dayEffectDto.setConsumptionEffect(dayEffectDto.getConsumptionEffect() - finalOut);
                    }
                });


                // 合并 同一天的收入支出有效消耗
                dayEffectDtos_pay.forEach(DayEffectDto::toPay);
                dayEffectDtos_pay.parallelStream().forEach(dto->{dto.setConsumptionEffect(0d);});
                dayEffectDtos_income.parallelStream().forEach(dto->{dto.setPayConsumptionEffect(0d);});
                Map<Date,DayEffectDto> all=new HashMap<>();
                for(int i=0;i<dayEffectDtos_income.size();i++){
                    if(dayEffectDtos_income.get(i)==null  || dayEffectDtos_income.get(i).getRecoredDate()==null )continue;
                    all.put(dayEffectDtos_income.get(i).getRecoredDate(),dayEffectDtos_income.get(i));
                }
                for(int i=0;i<dayEffectDtos_pay.size();i++){
                    if(dayEffectDtos_pay.get(i)==null  || dayEffectDtos_pay.get(i).getRecoredDate()==null )continue;
                    DayEffectDto dayEffectDto = all.get(dayEffectDtos_pay.get(i).getRecoredDate());
                    if(dayEffectDto==null)dayEffectDto = dayEffectDtos_pay.get(i);
                    dayEffectDto.setPayConsumptionEffect(dayEffectDtos_pay.get(i).getPayConsumptionEffect());
                    all.put(dayEffectDtos_pay.get(i).getRecoredDate(),dayEffectDto);
                }

                dayEffectDtos = new ArrayList<>(all.values());

            }
            else {
                /* 没溢出的 */
                dayEffectDtos = countMapper.selectEveryDayCon(map);
                dayEffectDtos.parallelStream().forEach(DayEffectDto::toPay);
            }
            effectDto.setData(dayEffectDtos);
        }


        /*并行 处理收入&支出，每个素材可单独并行处理*/
        customerEffectOnes_all.parallelStream().forEach((dto -> {
            /*每日数据可单独处理，不影响*/
            AtomicBoolean addPrice = new AtomicBoolean(false);
            dto.getData().parallelStream().forEach(dayEffectDto -> {
                if(dayEffectDto.getPayConsumptionEffect()==null)dayEffectDto.setPayConsumptionEffect(0d);
                if(dayEffectDto.getConsumptionEffect()==null)dayEffectDto.setConsumptionEffect(0d);
                 dayEffectDto.setIncome( dayEffectDto.getConsumptionEffect() * dto.getIncomeRadio()/100d);
                 dayEffectDto.setPay(dayEffectDto.getPayConsumptionEffect() * dto.getPayRadio()/100d);
                 if(dto.getCompleteDate().equals(dayEffectDto.getRecoredDate()) ){
                     if(dto.getBasePrice() !=null ) dayEffectDto.setIncome(dto.getBasePrice() +dayEffectDto.getIncome()  );
                     if(dto.getBasePay()!=null)dayEffectDto.setPay(dto.getBasePay() +dayEffectDto.getPay() );
                     addPrice.set(true);
                 }
            });
            // 没有成片日期那天的数据，新增一个
            /* 收入统计加上固定价格 */
            if(!addPrice.get()  &&  (  dto.getCompleteDate().equals(start) ||  dto.getCompleteDate().equals(end)  || (  dto.getCompleteDate().after(start) && dto.getCompleteDate().before(end)    )   )  ){
                dto.addData(new DayEffectDto(dto.getCode(),dto.getCompleteDate(),dto.getBasePrice(),dto.getBasePay()));
            }
        }));
        /*统计素材的收入和&支出和*/
        customerEffectOnes_all.parallelStream().forEach(dto->{
            if(dto.getSumIncome()==null)dto.setSumIncome(0d);
            if(dto.getSumPay()==null)dto.setSumPay(0d);
            AtomicReference<Double> sumIncome = new AtomicReference<>(0d);
            AtomicReference<Double> sumPay = new AtomicReference<>(0d);
            AtomicReference<Double> sumIncomeEff = new AtomicReference<>(0d);
            AtomicReference<Double> sumPayEff = new AtomicReference<>(0d);
            dto.getData().parallelStream().forEach(dayEffectDto ->{
                sumIncome.updateAndGet(v -> v + (dayEffectDto.getIncome()==null?0d: dayEffectDto.getIncome())   );
                sumPay.updateAndGet(v -> v + (dayEffectDto.getPay()==null?0d:dayEffectDto.getPay()));
                sumIncomeEff.updateAndGet(v->v+(dayEffectDto.getConsumptionEffect()==null?0d:dayEffectDto.getConsumptionEffect()) );
                sumPayEff.updateAndGet(v->v+(dayEffectDto.getPayConsumptionEffect()==null?0d:dayEffectDto.getPayConsumptionEffect()));
            } );
            dto.setSumEffCon(sumIncomeEff.get());
            dto.setSumEffPayCon(sumPayEff.get());
            dto.setSumIncome(sumIncome.get());
            dto.setSumPay(sumPay.get());
        });

//        countDto.setAllPrimaryData(customerEffectOnes_all);
        /* 串行处理求和 */
        AtomicReference<Double> totalCon = new AtomicReference<>(0d);
        AtomicReference<Double> totalSumCon = new AtomicReference<>(0d);
        AtomicReference<Double> totalSumPayCon = new AtomicReference<>(0d);
        /*总素材数量*/
        AtomicInteger totalCus= new AtomicInteger();
        /*总收入&支出求和*/
        AtomicReference<Double> totalSumIncome= new AtomicReference<>(0d);
        AtomicReference<Double> totalSumPay= new AtomicReference<>(0d);
        /*注意线程安全*/
        Map<Long ,DayEffectDto> dayEffectDtoMap = new ConcurrentHashMap<>();
        customerEffectOnes_all.forEach(dto -> {
            totalCus.getAndIncrement();
            totalCon.updateAndGet(v -> v + dto.getSumAllEffCon());
            dto.getData().forEach(dayEffectDto -> {
                totalSumIncome.updateAndGet(v -> v + dayEffectDto.getIncome());
                totalSumPay.updateAndGet(v -> v + dayEffectDto.getPay());
                totalSumCon.updateAndGet(v -> v + dayEffectDto.getConsumptionEffect());
                totalSumPayCon.updateAndGet(v -> v + dayEffectDto.getPayConsumptionEffect());

                DayEffectDto effectDto=dayEffectDtoMap.get(dayEffectDto.getRecoredDate().getTime());
                if(effectDto==null) effectDto = new DayEffectDto(dayEffectDto.getRecoredDate());
                effectDto.setConsumptionEffect(effectDto.getConsumptionEffect() + dayEffectDto.getConsumptionEffect());
                effectDto.setPayConsumptionEffect(effectDto.getPayConsumptionEffect() + dayEffectDto.getPayConsumptionEffect());
                effectDto.setIncome(effectDto.getIncome() + dayEffectDto.getIncome());
                effectDto.setPay(effectDto.getPay() + dayEffectDto.getPay());
                effectDto.setCode(dto.getCode());
                dayEffectDtoMap.put(effectDto.getRecoredDate().getTime(),effectDto);
            });
        });

        List<DayEffectDto> dayEffectDtoList = new ArrayList<>(dayEffectDtoMap.size());
        dayEffectDtoList.addAll(dayEffectDtoMap.values());
        return new EffectCountDto(customerEffectOnes_all,dayEffectDtoList,totalSumCon.get(),totalSumPayCon.get(),totalCus.get(),totalSumIncome.get(),totalSumPay.get());
    }

    @Override
    public Workbook handleEffConTimeToExcel(EffectCountDto effectCountDto,String sort,String order) {
        Workbook workbook= new XSSFWorkbook();
        if(effectCountDto==null || effectCountDto.getAllPrimaryData()==null || effectCountDto.getAllPrimaryData().size()==0)return workbook;
        NumberFormat nf = NumberFormat.getNumberInstance();
        nf.setMaximumFractionDigits(2);
        Sheet sheetCus = workbook.createSheet("素材");
        String [] headCus = new String[]{ "编号","名称","收入封顶消耗", "支出封顶消耗", "生命周期内总消耗", "查询区间内总消耗" ,"收入有效消耗", "支出有效消耗", "收入","支出", "固定收入","固定支出","收入比率(%)","支出比率(%)","成片日期","生命周期至（配置）","收入有效期至（实际）","支出有效期至（实际）" };
        Row headRowCus = sheetCus.createRow(0);
        for(int i=0;i<headCus.length;i++){
            Cell cell = headRowCus.createCell(i);
            cell.setCellValue(headCus[i]);
            sheetCus.setColumnWidth(i, 4000);
        }
        sheetCus.setColumnWidth(0, 12000);
        sheetCus.setColumnWidth(10, 6000);
        sheetCus.setColumnWidth(13, 6000);
        sheetCus.setColumnWidth(14, 6000);
        sheetCus.setColumnWidth(15, 6000);

        List<CustomerEffectDto> customerEffectDtos=effectCountDto.getAllPrimaryData();

        customerEffectDtos.sort((dto1,dto2)->{
            int end = 0;
            if(sort==null)return end;
            //TODO 只做了三个排序
            switch (sort){
                case "sumAllEffCon":end = (int) ((dto1.getSumAllEffCon() - dto2.getSumAllEffCon())*1000D);break;
                case "sumAllCon":end = (int) ((dto1.getSumAllCon() - dto2.getSumAllCon())*1000D);break;
                case "sumEffCon":end = (int) ((dto1.getSumEffCon() - dto2.getSumEffCon())*1000D);break;
                case "sumEffPayCon":end = (int) ((dto1.getSumEffPayCon() - dto2.getSumEffPayCon())*1000D);break;
                case "code":
                    if(dto1.getCode()!=null && dto2.getCode()!=null) end = dto1.getCode().compareTo(dto2.getCode());
                    break;
                case "name":
                    if(dto1.getName()!=null && dto2.getName()!=null) end = dto1.getName().compareTo(dto2.getName());
                    break;
            }
            if("desc".equals(order))end = -end;
            return end;
        });

        for(int m=0;m<customerEffectDtos.size();m++){
            CustomerEffectDto dto = customerEffectDtos.get(m);
            if(dto==null)continue;
            Row row= sheetCus.createRow(m+1);
            for(int i=0;i<headCus.length;i++){
                Cell cell = row.createCell(i);
                if(i==0) cell.setCellValue(dto.getCode());
                else if(i==1) cell.setCellValue(dto.getName());
                else if(i==2) cell.setCellValue(dto.getMaxEffectOn());
                else if(i==3) cell.setCellValue(dto.getPayMaxEffectOn());
                else if(i==4) cell.setCellValue(nf.format(dto.getSumAllEffCon()) );
                else if(i==5) cell.setCellValue(nf.format(dto.getSumAllCon()) );
                else if(i==6) cell.setCellValue(nf.format(dto.getSumEffCon()) );
                else if(i==7) cell.setCellValue(nf.format(dto.getSumEffPayCon()) );
                else if(i==8) cell.setCellValue(nf.format(dto.getSumIncome()) );
                else if(i==9) cell.setCellValue(nf.format(dto.getSumPay()));
                else if(i==10){
                    if(dto.getPriceLevelName()!=null) cell.setCellValue( dto.getPriceLevelName()+" ￥ "+  dto.getBasePrice());
                }
                else if(i==11){
                    if(dto.getPayLevelName()!=null) cell.setCellValue( dto.getPayLevelName()+" ￥ "+  dto.getBasePay());
                }
                else if(i==12) cell.setCellValue(dto.getIncomeRadio());
                else if(i==13) cell.setCellValue(dto.getPayRadio());
                else if(i==14){
                    cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                    cell.setCellValue(dto.getCompleteDate());
                }
                else if(i==15){
                    cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                    cell.setCellValue(dto.getEndDate());
                }
                else if(i==16){
                    cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                    cell.setCellValue(dto.getIncomeEndDate());
                }
                else if(i==17){
                    cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                    cell.setCellValue(dto.getPayEndDate());
                }
        }
        }
        return workbook;
    }
}
