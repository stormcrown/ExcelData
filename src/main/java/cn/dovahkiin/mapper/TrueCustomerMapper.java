package cn.dovahkiin.mapper;

import cn.dovahkiin.model.TrueCustomer;
import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
  * 客户信息 Mapper 接口
 * </p>
 *
 * @author lzt
 * @since 2018-11-29
 */
public interface TrueCustomerMapper extends BaseMapper<TrueCustomer> {
    int deleteByPrimaryKey(Long id);

    int insertSelective(TrueCustomer record);

    TrueCustomer selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TrueCustomer record);

    int updateByPrimaryKey(TrueCustomer record);
}