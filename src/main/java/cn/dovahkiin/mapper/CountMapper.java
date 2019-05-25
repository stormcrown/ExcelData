package cn.dovahkiin.mapper;

import cn.dovahkiin.model.Editor;
import com.baomidou.mybatisplus.mapper.BaseMapper;

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
public interface CountMapper  {
    List<Map> count1(Map map);
    List<Map> countByOptimizer(Map map);
    List<Map> countByCustomer(Map map);
}