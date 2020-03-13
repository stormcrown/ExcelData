package cn.dovahkiin.mapper;

import cn.dovahkiin.model.Supplier;
import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
public interface SupplierMapper extends BaseMapper<Supplier> {
    int deleteByPrimaryKey(Long id);

    int insertSelective(Supplier record);

    Supplier selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Supplier record);

    int updateByPrimaryKey(Supplier record);
}