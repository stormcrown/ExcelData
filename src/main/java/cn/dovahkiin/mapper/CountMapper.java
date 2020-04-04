package cn.dovahkiin.mapper;

import cn.dovahkiin.model.SystemConfig;
import cn.dovahkiin.model.dto.*;
import cn.dovahkiin.util.Const;
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

    List<CusOrgEffDto> selectEffectCustomerByDem(
            @Param(Const.defaultConfig)SystemConfig systemConfig,
            @Param(Const.RECORED_DATE_START)Date recoredDate_start,
            @Param(Const.RECORED_DATE_END)Date recoredDate_end,
            @Param(Const.completeDate)Date completeDate,
            @Param("incomeEndDate")Date incomeEndDate,
            @Param("payEndDate")Date payEndDate,
            @Param(Const.customerCode)String customerCode
    );
    List<LastDayCustomerEffectDto> selectallConByCusDemInSpecialDay(
            @Param("specialDay")Date specialDay,
            @Param(Const.customerCode)String customerCode
    );


    LastDayEffectDto selectLastDay(Map<String,Object> map);

    List<DayEffectDto> selectEveryDayCon(Map<String,Object> map);

}