package cn.dovahkiin.service.impl;

import cn.dovahkiin.mapper.CountMapper;
import cn.dovahkiin.mapper.CustomerMapper;
import cn.dovahkiin.mapper.SystemConfigMapper;
import cn.dovahkiin.model.SystemConfig;
import cn.dovahkiin.model.dto.CustomerEffectDto;
import cn.dovahkiin.model.dto.DayEffectDto;
import cn.dovahkiin.model.dto.LastDayEffectDto;
import cn.dovahkiin.service.ICountService;
import cn.dovahkiin.util.Const;
import com.alibaba.fastjson.JSON;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
    public List<CustomerEffectDto> countEffConTimeCut(Map map) {
        SystemConfig defaultConfig = systemConfigMapper.selectBySupplierId(null);
        map.put("defaultConfig",defaultConfig);

        /* 查出所有在有效期内有消耗的素材 */
        List<CustomerEffectDto> customerEffectOnes_all = countMapper.selectEffectCustomer(map);

        for(CustomerEffectDto effectDto:customerEffectOnes_all){
            map.put(Const.customerId,effectDto.getId());
            List<DayEffectDto> dayEffectDtos ;
            if(effectDto.getSumCon() > effectDto.getMaxEffectOn() ){
                /* 找出最后一天的溢出了多少 */
                LastDayEffectDto lastDayEffectDto = countMapper.selectLastDay(map);
                log.info(JSON.toJSONString(lastDayEffectDto));
                // 最后一天的溢出
                Double out = lastDayEffectDto.getSumCon() - lastDayEffectDto.getMaxEffectOn();
                map.put(Const.RECORED_DATE_Last,lastDayEffectDto.getRecoredDate());
                dayEffectDtos = countMapper.selectEveryDayCon(map);
                for(DayEffectDto dayEffectDto:dayEffectDtos){
                    // 减去最后一天的溢出
                    if(dayEffectDto.getRecoredDate().equals(lastDayEffectDto.getRecoredDate())){
                        dayEffectDto.setConsumptionEffect(dayEffectDto.getConsumptionEffect()-out);
                        log.info(dayEffectDto.getRecoredDate().toString()+   out+"\t"+dayEffectDto.getConsumptionEffect());
                        break;
                    }
                }
            }
            else {
                map.remove(Const.RECORED_DATE_Last);
                dayEffectDtos = countMapper.selectEveryDayCon(map);
            }
            effectDto.setData(dayEffectDtos);
        }
        return customerEffectOnes_all;
    }



}
