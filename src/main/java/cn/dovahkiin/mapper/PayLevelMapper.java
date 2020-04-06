package cn.dovahkiin.mapper;


import cn.dovahkiin.model.PayLevel;
import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author lzt
 * @since 2020-03-27
 */
public interface PayLevelMapper extends BaseMapper<PayLevel> {
    int deleteByPrimaryKey(Long id);

    PayLevel selectByPrimaryKey(Long id);

    int updateByPrimaryKey(PayLevel record);
}