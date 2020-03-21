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
import com.alibaba.fastjson.JSON;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

        /* 查出所有在有效期内有消耗的素材 */
        List<CustomerEffectDto> customerEffectOnes_all = countMapper.selectEffectCustomer(map);
        /*获得所有数据*/
        for(CustomerEffectDto effectDto:customerEffectOnes_all){
            map.put(Const.customerId,effectDto.getId());
            map.put(Const.RECORED_DATE_Last, effectDto.getEndDate());
            List<DayEffectDto> dayEffectDtos ;
            /* 有溢出的 */
            if(effectDto.getSumCon() > effectDto.getMaxEffectOn() ){
                /* 找出最后一天的溢出了多少 */
                LastDayEffectDto lastDayEffectDto = countMapper.selectLastDay(map);
                // 最后一天的溢出
                Double out = lastDayEffectDto.getSumCon() - lastDayEffectDto.getMaxEffectOn();
                map.put(Const.RECORED_DATE_Last,lastDayEffectDto.getRecoredDate());
                dayEffectDtos = countMapper.selectEveryDayCon(map);
                for(DayEffectDto dayEffectDto:dayEffectDtos){
                    // 减去最后一天的溢出
                    if(dayEffectDto.getRecoredDate().equals(lastDayEffectDto.getRecoredDate())){
                        dayEffectDto.setConsumptionEffect(dayEffectDto.getConsumptionEffect()-out);
                        break;
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
                 /*TODO 目前没有固定支出的功能*/
                 if(dto.getCompleteDate().equals(dayEffectDto.getRecoredDate())){
                     dayEffectDto.setIncome(dto.getBasePrice() );
                     addPrice.set(true);
                 }
            });
            if(!addPrice.get()){
                // 没有成片日期那天的数据，新增一个
                /* 收入统计加上固定价格 */
                DayEffectDto dayEffectDto = new DayEffectDto(dto.getId(),dto.getCompleteDate(),dto.getBasePrice());
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
                sumIncome.updateAndGet(v -> v + dayEffectDto.getIncome());
                sumPay.updateAndGet(v -> v + dayEffectDto.getPay());
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



}
