package cn.dovahkiin.mapper;

import cn.dovahkiin.model.Editor;
import com.baomidou.mybatisplus.mapper.BaseMapper;
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
    List<Map<String,Object>> countByOptimizer(Map<String,Object> map);
    List<Map<String,Object>> countByModel(Map<String,Object> map);

    /**
     * 查找出有效期内，消耗大于最大消耗的素材
     * */
    List<Map> effCount1(@Param("effectDays")Integer effectDays ,@Param("maxEffectCon")Double maxEffectCon,@Param("startDate") Date startDate,@Param("endDate") Date endDate);
}