package cn.dovahkiin.mapper;

import cn.dovahkiin.model.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
  * 剪辑师信息 Mapper 接口
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Mapper
public interface CountMapper  {
    List<Map<String,Object>> count1(Map<String,Object> map);
    List<ModelCountDto> countByModel(Map<String,Object> map);

    List<CustomerEffectDto> selectEffectCustomer(Map<String,Object> map);

    List<CusOrgEffDto> selectEffectCustomerByDem(Map<String,Object> map);

    LastDayEffectDto selectLastDay(Map<String,Object> map);

    List<DayEffectDto> selectEveryDayCon(Map<String,Object> map);

}