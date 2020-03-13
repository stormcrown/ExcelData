package cn.dovahkiin.mapper;

import cn.dovahkiin.model.PriceLevel;
import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
public interface PriceLevelMapper extends BaseMapper<PriceLevel> {
    int deleteByPrimaryKey(Long id);

    int insertSelective(PriceLevel record);

    PriceLevel selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(PriceLevel record);

    int updateByPrimaryKey(PriceLevel record);
}