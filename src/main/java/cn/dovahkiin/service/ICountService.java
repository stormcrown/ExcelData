package cn.dovahkiin.service;

import cn.dovahkiin.model.Editor;
import com.baomidou.mybatisplus.service.IService;

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
    List<Map> countByOptimizer(Map map);
    List<Map> countByCustomer(Map map);
}
