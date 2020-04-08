package cn.dovahkiin.service.impl;

import cn.dovahkiin.commons.utils.StringUtils;
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
import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

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
                case "consumption":end = dto1.getConsumption().compareTo(dto2.getConsumption()) ;break;
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
            map.put(Const.RECORED_DATE_Last, effectDto.getIncomeConfigEndDate());
            map.put(Const.RECORED_DATE_Last_pay, effectDto.getPayConfigEndDate());
            effectDto.setPayEndDate(effectDto.getIncomeConfigEndDate());
            effectDto.setIncomeEndDate(effectDto.getPayConfigEndDate());
            List<DayEffectDto> dayEffectDtos = null;
            /* 有溢出的 */
            if(effectDto.getSumAllEffConInc().compareTo(effectDto.getIncMaxEffectOn() )  >0|| effectDto.getSumAllEffConPay().compareTo(effectDto.getPayMaxEffectOn())   >0){
                /* 找出最后一天的溢出了多少 */
                List<DayEffectDto> dayEffectDtos_income = new Vector<DayEffectDto>();
                List<DayEffectDto> dayEffectDtos_pay = new Vector<DayEffectDto>();
                List<DayEffectDto> dayEffectDtos_pay_temp= new Vector<DayEffectDto>();
                BigDecimal out = new BigDecimal(0) ,outPay=new BigDecimal(0);
                /** import 重要 ，如果收入，支出的结束在同一天，查询数据每日消耗返回的数据 可能是同一个对象 ！！！！同一个对象 ！！！！同一个对象 ！！！！同一个对象 ！！！！  */
                // 收入
                if(effectDto.getSumAllEffConInc() .compareTo(effectDto.getIncMaxEffectOn())   >0 ){
                    effectDto.setIncomeOverflow(Boolean.TRUE);
                    map.put(maxValue,effectDto.getIncMaxEffectOn());
                    LastDayEffectDto lastDayEffectDto = countMapper.selectLastDay(map);
                    // 最后一天的溢出
                    if(lastDayEffectDto!=null && lastDayEffectDto.getSumCon()!=null &&effectDto.getIncMaxEffectOn()!=null  )out=     lastDayEffectDto.getSumCon() .subtract(effectDto.getIncMaxEffectOn())  ;
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
                if(effectDto.getSumAllEffConPay().compareTo(effectDto.getPayMaxEffectOn())  >0){
                    effectDto.setPayOverflow(Boolean.TRUE);
                    map.put(maxValue,effectDto.getPayMaxEffectOn());
                    LastDayEffectDto lastDayEffectDtoPay = countMapper.selectLastDay(map);
                    if(lastDayEffectDtoPay!=null && lastDayEffectDtoPay.getSumCon()!=null && effectDto.getPayMaxEffectOn()!=null  )outPay=lastDayEffectDtoPay.getSumCon().subtract(effectDto.getPayMaxEffectOn())  ;
                    if(lastDayEffectDtoPay!=null){
                        map.put(Const.RECORED_DATE_Last_pay, lastDayEffectDtoPay.getRecoredDate());
                        effectDto.setPayEndDate(lastDayEffectDtoPay.getRecoredDate());
                    }
                    dayEffectDtos_pay_temp.addAll(countMapper.selectEveryDayCon(map))  ;
                }
                else{
                    map.put(maxValue,effectDto.getPayMaxEffectOn());
                    map.put(Const.RECORED_DATE_Last_pay, effectDto.getPayEndDate());
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
                BigDecimal finalOutPay = new BigDecimal(0).add(outPay) ;
                dayEffectDtos_pay.parallelStream().forEach(dayEffectDto -> {
                    if(dayEffectDto.getRecoredDate().equals(effectDto.getPayEndDate())){
                        dayEffectDto.setPayConsumptionEffect(dayEffectDto.getPayConsumptionEffect().subtract(finalOutPay) );
                    }
                });
                BigDecimal finalOut =BigDecimal.ZERO.add(out) ;
                dayEffectDtos_income.parallelStream().forEach(dayEffectDto -> {
                    if(dayEffectDto.getRecoredDate().equals(effectDto.getIncomeEndDate())){
                        dayEffectDto.setConsumptionEffect(dayEffectDto.getConsumptionEffect().subtract(finalOut));
                    }
                });
                effectDto.setLastDayIncomeOver(out);
                effectDto.setLastDayPayOver(outPay);
                // 合并 同一天的收入支出有效消耗
                dayEffectDtos_pay.parallelStream().forEach(dto->{dto.setConsumptionEffect(BigDecimal.ZERO);});
                dayEffectDtos_income.parallelStream().forEach(dto->{dto.setPayConsumptionEffect(BigDecimal.ZERO);});
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
            }
            effectDto.setData(dayEffectDtos);
        }


/// ################# 部门 数据获取

        /* 每个素材的部门有效消耗数据，在有效消耗计算完成了之后再算   */
        customerEffectOnes_all.parallelStream().forEach(customerEffect->{
            customerEffect.setCusOrgEffDtos(countMapper.selectEffectCustomerByDem(defaultConfig, start, end, customerEffect.getCompleteDate(), customerEffect.getIncomeEndDate(), customerEffect.getPayEndDate(), customerEffect.getCode()));
            //
            if((start.after(customerEffect.getIncomeEndDate())  && start.after(customerEffect.getPayEndDate())) || (end.before(customerEffect.getCompleteDate())))return;

            if(customerEffect.getCusOrgEffDtos()==null || customerEffect.getCusOrgEffDtos().size()==0)return;
            // 如果都没有溢出，直接结束
            if( (customerEffect.getLastDayIncomeOver() ==null || customerEffect.getLastDayIncomeOver().compareTo(BigDecimal.ZERO) == 0)  && ( customerEffect.getLastDayPayOver() ==null || customerEffect.getLastDayPayOver().compareTo(BigDecimal.ZERO)==0 )  )return;

            // 如果只有一个部门，减去总溢出值
            if(customerEffect.getCusOrgEffDtos().size()==1){
                if( customerEffect.getLastDayIncomeOver() !=null && customerEffect.getLastDayIncomeOver().compareTo(BigDecimal.ZERO) >0  ){
                    if(customerEffect.getLastDayIncomeOver().compareTo(customerEffect.getCusOrgEffDtos().get(0).getSumEffCon())  <= 0     ) customerEffect.getCusOrgEffDtos().get(0).setSumEffCon(customerEffect.getCusOrgEffDtos().get(0).getSumEffCon().subtract(customerEffect.getLastDayIncomeOver()) );
                    else customerEffect.getCusOrgEffDtos().get(0).setSumEffCon(BigDecimal.ZERO);
                }
                if(  customerEffect.getLastDayPayOver() !=null && customerEffect.getLastDayPayOver().compareTo(BigDecimal.ZERO) > 0 ){
                    if(customerEffect.getLastDayPayOver() .compareTo(customerEffect.getCusOrgEffDtos().get(0).getSumEffPayCon()) <=0)
                        customerEffect.getCusOrgEffDtos().get(0).setSumEffPayCon(customerEffect.getCusOrgEffDtos().get(0).getSumEffPayCon().subtract(customerEffect.getLastDayPayOver()));
                    else customerEffect.getCusOrgEffDtos().get(0).setSumEffPayCon(BigDecimal.ZERO);
                }
                return;
            }
            // 查询对应的最后一天的各部门消耗
            // 收入消耗溢出
            if( customerEffect.getLastDayIncomeOver() !=null && customerEffect.getLastDayIncomeOver().compareTo(BigDecimal.ZERO)  >0 ){
                List<LastDayCustomerEffectDto> lastDayCustomerEffectDtos = countMapper.selectallConByCusDemInSpecialDay(customerEffect.getIncomeEndDate(),customerEffect.getCode());
                // 刚好结束日期那天，如果只有一个部门有消耗，那么就修正数据为最大值
                if(lastDayCustomerEffectDtos!=null &&  lastDayCustomerEffectDtos.size()==1){
                    customerEffect.getCusOrgEffDtos().parallelStream().forEach(cusOrgEffDto -> {
                        if(StringUtils.isBlank(cusOrgEffDto.getOrgCode()) || StringUtils.isBlank(lastDayCustomerEffectDtos.get(0).getOrgCode())  )return;
                        if( !cusOrgEffDto.getOrgCode().equals(lastDayCustomerEffectDtos.get(0).getOrgCode()  ) ) return;
                        if(customerEffect.getLastDayIncomeOver().compareTo(cusOrgEffDto.getSumEffCon()) <=0) cusOrgEffDto.setSumEffCon( cusOrgEffDto.getSumEffCon().subtract(customerEffect.getLastDayIncomeOver()));
                        else cusOrgEffDto.setSumEffCon(BigDecimal.ZERO);
                    });
                }else if(lastDayCustomerEffectDtos!=null &&  lastDayCustomerEffectDtos.size()>1){
                    // 刚好结束日期那天，如果有多个部门有消耗，
                    Set<String> incomeConflicOrgName =  new CopyOnWriteArraySet<>();
                    lastDayCustomerEffectDtos.parallelStream().forEach(lastDto->incomeConflicOrgName.add(lastDto.getOrgName()));
                    // 收入超
                    final BigDecimal[] incomeOver = {new BigDecimal(0).add(customerEffect.getLastDayIncomeOver())};
                    final BigDecimal[] size = {new BigDecimal(lastDayCustomerEffectDtos.size())};
                    lastDayCustomerEffectDtos.sort((lastDay1,lastDay2)-> (int) (lastDay1.getSumCon() .compareTo(lastDay2.getSumCon()) ));
                    customerEffect.getCusOrgEffDtos().sort(( cusOrg1,cusOrg2 )-> (int) (cusOrg1.getSumEffCon().compareTo(cusOrg2.getSumEffCon())));
                    for(CusOrgEffDto cusOrgEffDto:customerEffect.getCusOrgEffDtos()){
                        cusOrgEffDto.setIncomeConflictOrgNames(incomeConflicOrgName);
                        lastDayCustomerEffectDtos.forEach(lastDayCustomerEffectDto -> {
                            lastDayCustomerEffectDto.setConflictOrgNames(incomeConflicOrgName);
                            if( cusOrgEffDto.getOrgCode().equals(lastDayCustomerEffectDto.getOrgCode())     ){
                                log.info(lastDayCustomerEffectDto.getSumCon()+"\t"+ incomeOver[0].toString()+"\t"+ size[0].toString());
                               if(lastDayCustomerEffectDto.getSumCon().compareTo(incomeOver[0].divide(size[0]))   >=0 ){
                                   lastDayCustomerEffectDto.setSumCon(lastDayCustomerEffectDto.getSumCon().subtract(incomeOver[0].divide(size[0])) );
                                   cusOrgEffDto.setSumEffCon(cusOrgEffDto.getSumEffCon().subtract(incomeOver[0].divide(size[0])) ) ;
                                   incomeOver[0] = incomeOver[0].subtract( incomeOver[0].divide(size[0]))  ;
                                   size[0] = size[0].subtract(BigDecimal.ONE);
                               }
                               else{
                                   incomeOver[0]=incomeOver[0].subtract( lastDayCustomerEffectDto.getSumCon()) ;
                                   size[0] = size[0].subtract(BigDecimal.ONE);
                                   cusOrgEffDto.setSumEffCon(cusOrgEffDto.getSumEffCon().subtract(lastDayCustomerEffectDto.getSumCon()));
                                   lastDayCustomerEffectDto.setSumCon(new BigDecimal(0));
                               }
                                cusOrgEffDto.setIncomeConflict(Boolean.TRUE);
                                cusOrgEffDto.setIncomeLastDay(lastDayCustomerEffectDto);
                            }
                        });
                    }
                }
            }
            // 支出消耗溢出
            if( customerEffect.getLastDayPayOver() !=null && customerEffect.getLastDayPayOver().compareTo(BigDecimal.ZERO) > 0 ){
                List<LastDayCustomerEffectDto> lastDayCustomerEffectDtos = countMapper.selectallConByCusDemInSpecialDay(customerEffect.getPayEndDate(),customerEffect.getCode());
                // 刚好结束日期那天，如果只有一个部门有消耗，那么就修正数据
                if(lastDayCustomerEffectDtos!=null &&  lastDayCustomerEffectDtos.size()==1){
                    customerEffect.getCusOrgEffDtos().parallelStream().forEach(cusOrgEffDto -> {
                        if(StringUtils.isBlank(cusOrgEffDto.getOrgCode()) || StringUtils.isBlank(lastDayCustomerEffectDtos.get(0).getOrgCode())  )return;
                        if( !cusOrgEffDto.getOrgCode().equals(lastDayCustomerEffectDtos.get(0).getOrgCode()  ) ) return;
                        if(customerEffect.getLastDayPayOver().compareTo(cusOrgEffDto.getSumEffPayCon()) <=0) cusOrgEffDto.setSumEffPayCon( cusOrgEffDto.getSumEffPayCon() .subtract(customerEffect.getLastDayPayOver()));
                        else cusOrgEffDto.setSumEffCon(new BigDecimal(0));
                    });
                }else if(lastDayCustomerEffectDtos!=null &&  lastDayCustomerEffectDtos.size()>1){
                    Set<String> payConflicOrgName = new CopyOnWriteArraySet<>();
                    lastDayCustomerEffectDtos.parallelStream().forEach(lastDto->payConflicOrgName.add(lastDto.getOrgName()));
                    // 刚好结束日期那天，如果有多个部门有消耗，
                    final BigDecimal[] payOver = {new BigDecimal(0).add(customerEffect.getLastDayPayOver())};
                    final BigDecimal[] size = { new BigDecimal(lastDayCustomerEffectDtos.size()) };
                    lastDayCustomerEffectDtos.sort((lastDay1,lastDay2)->  lastDay1.getSumCon() .compareTo(lastDay2.getSumCon()));
                    customerEffect.getCusOrgEffDtos().sort(( cusOrg1,cusOrg2 )->  cusOrg1.getSumEffPayCon().compareTo(cusOrg2.getSumEffPayCon()));
                    for(CusOrgEffDto cusOrgEffDto:customerEffect.getCusOrgEffDtos()){
                        cusOrgEffDto.setPayConflictOrgNames(payConflicOrgName);
                        lastDayCustomerEffectDtos.forEach(lastDayCustomerEffectDto -> {
                            lastDayCustomerEffectDto.setConflictOrgNames(payConflicOrgName);
                            if( cusOrgEffDto.getOrgCode().equals(lastDayCustomerEffectDto.getOrgCode())  ) {
                                log.info(lastDayCustomerEffectDto.getSumCon()+"\t"+ payOver[0].toPlainString()+"\t"+size[0].toPlainString());
                                if(lastDayCustomerEffectDto.getSumCon() .compareTo(payOver[0].divide(size[0])) >=0){
                                    lastDayCustomerEffectDto.setSumCon(lastDayCustomerEffectDto.getSumCon().subtract(payOver[0].divide(size[0])));
                                    cusOrgEffDto.setSumEffPayCon(cusOrgEffDto.getSumEffPayCon().subtract(payOver[0].divide(size[0]))) ;
                                    payOver[0] = payOver[0].subtract( payOver[0].divide(size[0]));
                                    size[0] = size[0].subtract(BigDecimal.ONE);
                                }
                                else{
                                    payOver[0] = payOver[0].subtract( lastDayCustomerEffectDto.getSumCon() );
                                    size[0] = size[0].subtract(BigDecimal.ONE);
                                    cusOrgEffDto.setSumEffPayCon(cusOrgEffDto.getSumEffPayCon().subtract(lastDayCustomerEffectDto.getSumCon()));
                                    lastDayCustomerEffectDto.setSumCon(BigDecimal.ZERO);
                                }
                                cusOrgEffDto.setPayConflict(Boolean.TRUE);
                                cusOrgEffDto.setPayLastDay(lastDayCustomerEffectDto);
                            }
                        });
                    }
                }
            }

        });


        Map<String, OrgEffDto> orgEffDtos = new ConcurrentHashMap<>();

        customerEffectOnes_all.forEach(ones->{

            if(ones==null||ones.getCusOrgEffDtos()==null || ones.getCusOrgEffDtos().size()==0)return;
            ones.getCusOrgEffDtos().forEach(cusDtos->{
                OrgEffDto orgEffDto = orgEffDtos.get(cusDtos.getOrgCode());
                if(orgEffDto==null){
                    orgEffDto = new OrgEffDto();
                    orgEffDto.init(cusDtos.getOrgCode(),cusDtos.getOrgName());
                }
                orgEffDto.updateData(cusDtos);
                orgEffDtos.put(orgEffDto.getOrgCode(),orgEffDto);
            });
        });

/// ################# 部门

        /*并行 处理收入&支出，每个素材可单独并行处理*/
        customerEffectOnes_all.parallelStream().forEach((dto -> {
            /*每日数据可单独处理，不影响*/
            AtomicBoolean addPrice = new AtomicBoolean(false);
            dto.getData().parallelStream().forEach(dayEffectDto -> {
                if(dayEffectDto.getPayConsumptionEffect()==null)dayEffectDto.setPayConsumptionEffect(BigDecimal.ZERO);
                if(dayEffectDto.getConsumptionEffect()==null)dayEffectDto.setConsumptionEffect(BigDecimal.ZERO);
                 dayEffectDto.setIncome( dayEffectDto.getConsumptionEffect() .multiply(dto.getIncomeRadio()).divide(new BigDecimal(100)));
                 dayEffectDto.setPay(dayEffectDto.getPayConsumptionEffect().multiply(dto.getPayRadio()).divide(new BigDecimal(100)));
                 if(dto.getCompleteDate().equals(dayEffectDto.getRecoredDate()) ){
                     if(dto.getBasePrice() !=null ) dayEffectDto.setIncome(dto.getBasePrice().add(dayEffectDto.getIncome())   );
                     if(dto.getBasePay()!=null)dayEffectDto.setPay(dto.getBasePay().add(dayEffectDto.getPay())  );
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
            if(dto.getSumIncome()==null)dto.setSumIncome(BigDecimal.ZERO);
            if(dto.getSumPay()==null)dto.setSumPay(BigDecimal.ZERO);
            AtomicReference<BigDecimal> sumIncome = new AtomicReference<>(BigDecimal.ZERO);
            AtomicReference<BigDecimal> sumPay = new AtomicReference<>(BigDecimal.ZERO);
            AtomicReference<BigDecimal> sumIncomeEff = new AtomicReference<>(BigDecimal.ZERO);
            AtomicReference<BigDecimal> sumPayEff = new AtomicReference<>(BigDecimal.ZERO);
            dto.getData().parallelStream().forEach(dayEffectDto ->{
                sumIncome.updateAndGet(v -> v .add (dayEffectDto.getIncome()  ==null?BigDecimal.ZERO: dayEffectDto.getIncome())   );
                sumPay.updateAndGet(v -> v .add (dayEffectDto.getPay()==null?BigDecimal.ZERO:dayEffectDto.getPay()));
                sumIncomeEff.updateAndGet(v->v.add(dayEffectDto.getConsumptionEffect()==null?BigDecimal.ZERO:dayEffectDto.getConsumptionEffect()) );
                sumPayEff.updateAndGet(v->v.add(dayEffectDto.getPayConsumptionEffect()==null?BigDecimal.ZERO:dayEffectDto.getPayConsumptionEffect()));
            } );
            dto.setSumEffCon(sumIncomeEff.get());
            dto.setSumEffPayCon(sumPayEff.get());
            dto.setSumIncome(sumIncome.get());
            dto.setSumPay(sumPay.get());
        });

//        countDto.setAllPrimaryData(customerEffectOnes_all);
        /* 串行处理求和 */
        AtomicReference<BigDecimal> totalSumAllEffConInc = new AtomicReference<>(BigDecimal.ZERO);
        AtomicReference<BigDecimal> totalSumAllEffConPay = new AtomicReference<>(BigDecimal.ZERO);
        AtomicReference<BigDecimal> tatalSumAllCon  = new AtomicReference<>(BigDecimal.ZERO);
        /* 收入消耗求和 */
        AtomicReference<BigDecimal> totalSumCon = new AtomicReference<>(BigDecimal.ZERO);
        /* 支出消耗求和 */
        AtomicReference<BigDecimal> totalSumPayCon = new AtomicReference<>(BigDecimal.ZERO);
        /*总素材数量*/
        AtomicInteger totalCus= new AtomicInteger();
        /*总收入&支出求和*/
        AtomicReference<BigDecimal> totalSumIncome= new AtomicReference<>(BigDecimal.ZERO);
        AtomicReference<BigDecimal> totalSumPay= new AtomicReference<>(BigDecimal.ZERO);
        /*注意线程安全*/
        Map<Long ,DayEffectDto> dayEffectDtoMap = new ConcurrentHashMap<>();
        customerEffectOnes_all.forEach(dto -> {
            totalCus.getAndIncrement();
            totalSumAllEffConInc.updateAndGet(v -> v .add(dto.getSumAllEffConInc()) );
            totalSumAllEffConPay.updateAndGet(v -> v .add(dto.getSumAllEffConPay()) );
            tatalSumAllCon.updateAndGet(v -> v .add(dto.getSumAllCon()) );
            dto.getData().forEach(dayEffectDto -> {
                totalSumIncome.updateAndGet(v -> v .add(dayEffectDto.getIncome()) );
                totalSumPay.updateAndGet(v -> v .add(dayEffectDto.getPay()) );
                totalSumCon.updateAndGet(v -> v .add(dayEffectDto.getConsumptionEffect()) );
                totalSumPayCon.updateAndGet(v -> v.add(dayEffectDto.getPayConsumptionEffect()) );
                DayEffectDto effectDto=dayEffectDtoMap.get(dayEffectDto.getRecoredDate().getTime());
                if(effectDto==null) effectDto = new DayEffectDto(dayEffectDto.getRecoredDate());
                effectDto.setConsumptionEffect(effectDto.getConsumptionEffect() .add( dayEffectDto.getConsumptionEffect()) );
                effectDto.setPayConsumptionEffect(effectDto.getPayConsumptionEffect().add(dayEffectDto.getPayConsumptionEffect()) );
                effectDto.setIncome(effectDto.getIncome() .add(dayEffectDto.getIncome()) );
                effectDto.setPay(effectDto.getPay().add(dayEffectDto.getPay()) );
                effectDto.setCode(dto.getCode());
                dayEffectDtoMap.put(effectDto.getRecoredDate().getTime(),effectDto);
            });
        });
        List<DayEffectDto> dayEffectDtoList = new ArrayList<>(dayEffectDtoMap.size());
        dayEffectDtoList.addAll(dayEffectDtoMap.values());
        return new EffectCountDto(customerEffectOnes_all,dayEffectDtoList,new ArrayList<>(orgEffDtos.values())  ,totalSumAllEffConInc.get(),totalSumAllEffConPay.get(),totalSumCon.get(),totalSumCon.get(),totalSumPayCon.get(),totalCus.get(),totalSumIncome.get(),totalSumPay.get());
    }

    @Override
    public Workbook handleEffConTimeToExcel(EffectCountDto effectCountDto,String sort,String order) {
        Workbook workbook= new XSSFWorkbook();
        if(effectCountDto==null || effectCountDto.getAllPrimaryData()==null || effectCountDto.getAllPrimaryData().size()==0)return workbook;
        NumberFormat nf = NumberFormat.getNumberInstance();
        nf.setMaximumFractionDigits(2);
        Sheet sheetCus = workbook.createSheet("素材");
        String [] headCus = new String[]{ "编号","名称","部门名称","供应商名称","收入封顶消耗", "支出封顶消耗", "收入生命周期内总消耗", "支出生命周期内总消耗", "查询区间内总消耗" ,"收入有效消耗", "支出有效消耗", "收入","支出", "固定收入","固定支出","收入比率(%)","支出比率(%)","成片日期","收入生命周期至（配置）","支出生命周期至（配置）","收入有效期至（实际）","支出有效期至（实际）" };
        Row headRowCus = sheetCus.createRow(0);
        for(int i=0;i<headCus.length;i++){
            Cell cell = headRowCus.createCell(i);
            cell.setCellValue(headCus[i]);
            sheetCus.setColumnWidth(i, 4000);
        }
        sheetCus.setColumnWidth(0, 12000);
        sheetCus.setColumnWidth(12, 6000);
        sheetCus.setColumnWidth(15, 6000);
        sheetCus.setColumnWidth(16, 6000);
        sheetCus.setColumnWidth(17, 6000);

        List<CustomerEffectDto> customerEffectDtos=effectCountDto.getAllPrimaryData();

        customerEffectDtos.sort((dto1,dto2)->{
            int end = 0;
            if(sort==null)return end;
            //TODO 只做了三个排序
            switch (sort){
                case "sumAllEffConInc":end = dto1.getSumAllEffConInc().compareTo(dto2.getSumAllEffConInc());break;
                case "sumAllCon":end = dto1.getSumAllCon().compareTo(dto2.getSumAllCon());break;
                case "sumEffCon":end = dto1.getSumEffCon().compareTo(dto2.getSumEffCon()) ;break;
                case "sumEffPayCon":end = dto1.getSumEffPayCon().compareTo(dto2.getSumEffPayCon()) ;break;
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
        // 不用用流
        for(int m=0;m<customerEffectDtos.size();m++){
            CustomerEffectDto dto = customerEffectDtos.get(m);
            if(dto==null)continue;
            Row row= sheetCus.createRow(m+1);
            for(int i=0;i<headCus.length;i++){
                Cell cell = row.createCell(i);
                if(i==0) cell.setCellValue(dto.getCode());
                else if(i==1) cell.setCellValue(dto.getName());
                if(i==2) {
                    StringBuffer orgNames = new StringBuffer();
                    if(dto.getCusOrgEffDtos()!=null && dto.getCusOrgEffDtos().size()>0){
                        dto.getCusOrgEffDtos().forEach(cusOrgEffDto ->orgNames.append( cusOrgEffDto.getOrgName()) );
                    }
                    cell.setCellValue(orgNames.toString());
                }
                else if(i==3) cell.setCellValue(dto.getSupplierName());
                else if(i==4) cell.setCellValue(dto.getIncMaxEffectOn().toPlainString());
                else if(i==5) cell.setCellValue(dto.getPayMaxEffectOn().toPlainString());
                else if(i==6) cell.setCellValue(nf.format(dto.getSumAllEffConInc()) );
                else if(i==7) cell.setCellValue(nf.format(dto.getSumAllEffConPay()) );
                else if(i==8) cell.setCellValue(nf.format(dto.getSumAllCon()) );
                else if(i==9) cell.setCellValue(nf.format(dto.getSumEffCon()) );
                else if(i==10) cell.setCellValue(nf.format(dto.getSumEffPayCon()) );
                else if(i==11) cell.setCellValue(nf.format(dto.getSumIncome()) );
                else if(i==12) cell.setCellValue(nf.format(dto.getSumPay()));
                else if(i==13){
                    if(dto.getPriceLevelName()!=null) cell.setCellValue( dto.getPriceLevelName()+" ￥ "+  dto.getBasePrice());
                }
                else if(i==14){
                    if(dto.getPayLevelName()!=null) cell.setCellValue( dto.getPayLevelName()+" ￥ "+  dto.getBasePay());
                }
                else if(i==15) cell.setCellValue(dto.getIncomeRadio().toPlainString());
                else if(i==16) cell.setCellValue(dto.getPayRadio().toPlainString());
                else if(i==17){
                    cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                    cell.setCellValue(dto.getCompleteDate());
                }
                else if(i==18){
                    cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                    cell.setCellValue(dto.getIncomeConfigEndDate());
                }
                else if(i==19){
                    cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                    cell.setCellValue(dto.getPayConfigEndDate());
                }
                else if(i==20){
                    cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                    cell.setCellValue(dto.getIncomeEndDate());
                }
                else if(i==21){
                    cell.setCellStyle(ExcelConst.getDateCellStyle(sheetCus));
                    cell.setCellValue(dto.getPayEndDate());
                }
        }
        }
        Sheet sheetOrg = workbook.createSheet("部门");
        String [] headOrgs = new String[]{ "部门名称","部门编号","全素材生命周期内收入消耗","全素材生命周期内支出消耗","查询区间内总消耗"," 查询区间内收入有效消耗","查询区间内支出有效消耗","收入冲突素材","支出冲突素材"  };
        Row headRowOrg = sheetOrg.createRow(0);
        for(int i=0;i<headOrgs.length;i++){
            Cell cell = headRowOrg.createCell(i);
            cell.setCellValue(headOrgs[i]);
            sheetOrg.setColumnWidth(i, 4000);
        }
        sheetOrg.setColumnWidth(7, 6000);
        List<OrgEffDto> cusOrgEffDtoList = effectCountDto.getOrgEffDtos();

        for(int m=0; m<cusOrgEffDtoList.size();m++ ){
            OrgEffDto orgEffDto = cusOrgEffDtoList.get(m);
            if(orgEffDto==null)continue;
            Row row= sheetOrg.createRow(m+1);
            for(int i=0;i<headOrgs.length;i++){
                Cell cell = row.createCell(i);
                if(i==0) cell.setCellValue(orgEffDto.getOrgName());
                else if(i==1) cell.setCellValue(orgEffDto.getOrgCode());
                else if(i==2)cell.setCellValue( nf.format(orgEffDto.getTotalSumAllEffConInc()) );
                else if(i==3)cell.setCellValue(nf.format(orgEffDto.getTotalSumAllEffConPay()));
                else if(i==4)cell.setCellValue(nf.format(orgEffDto.getTotalSumAllCon()));
                else if(i==5)cell.setCellValue(nf.format(orgEffDto.getTotalSumAllEffConInc()));
                else if(i==6)cell.setCellValue(nf.format(orgEffDto.getTotalSumAllEffConPay()));
                else if(i==7){
                    StringBuffer cusCode = new StringBuffer();
                    if(orgEffDto.getCusOrgEffDtoList()!=null && orgEffDto.getCusOrgEffDtoList().size()>0 ){
                        orgEffDto.getCusOrgEffDtoList().forEach(  cusOrgEffDto -> {
                            if(cusOrgEffDto.isIncomeConflict()  && cusOrgEffDto.getIncomeLastDay()!=null) cusCode.append("素材编号：") .append(  cusOrgEffDto.getIncomeLastDay().getCusCode()  ).append("日期 ").append(Const.simDF.format(cusOrgEffDto.getIncomeLastDay().getRecordDate())).append("；\r\n");
                        } );
                    }
                    cell.setCellValue(cusCode.toString());
                }
                else if(i==8){
                    StringBuffer cusCode = new StringBuffer();
                    if(orgEffDto.getCusOrgEffDtoList()!=null && orgEffDto.getCusOrgEffDtoList().size()>0 ){
                        orgEffDto.getCusOrgEffDtoList().forEach(  cusOrgEffDto -> {
                            if(cusOrgEffDto.isPayConflict()  && cusOrgEffDto.getPayLastDay()!=null) cusCode.append("素材编号：") .append(  cusOrgEffDto.getPayLastDay().getCusCode()  ).append("日期：").append(Const.simDF.format(cusOrgEffDto.getPayLastDay().getRecordDate())).append("；\r\n");
                        } );
                    }
                    cell.setCellValue(cusCode.toString());
                }
            }
        }


        return workbook;
    }


    @Override
    public List<CusCheckConfig> checkCusConfig() {
        return countMapper.checkCusConfig().parallelStream().filter( cusCheckConfig-> cusCheckConfig.getConfigs().size()>1  ).collect(Collectors.toList());
    }
}
