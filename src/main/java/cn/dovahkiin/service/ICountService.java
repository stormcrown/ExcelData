package cn.dovahkiin.service;

import cn.dovahkiin.model.Editor;
import cn.dovahkiin.model.dto.CustomerEffectDto;
import com.baomidou.mybatisplus.service.IService;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 统计服务 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
public interface ICountService  {
    List<Map> count1(Map map);
    List<Map> countByModel(Map map);

    List<CustomerEffectDto> countEffConTimeCut(Map map);


//    List<Map> effCount1(Map map, Integer effectDays, Double maxEffectCon, Date startDate,Date endDate);
    /** 第一个统计  */

}
