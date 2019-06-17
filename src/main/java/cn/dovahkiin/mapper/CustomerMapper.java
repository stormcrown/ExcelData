package cn.dovahkiin.mapper;

import cn.dovahkiin.model.Customer;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

/**
 * <p>
  * 客户信息 Mapper 接口
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
public interface CustomerMapper  {
    int deleteByPrimaryKey(Long id);
    int insert(Customer record);
    int insertSelective(Customer record);
    Customer selectByCode(String code);
    List<Customer> selectList(Map map);
    List<Customer> selectSimpleList(Map map);
    int selectTotal(Map map);
    int updateByPrimaryKeySelective(Customer record);
    int updateByPrimaryKey(Customer record);
    int deleteMany(String[] ids);
    int rollBack(String[] ids);
    int deleteFlagIsOne();
}