package cn.dovahkiin.service;

import cn.dovahkiin.model.PriceLevel;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
public interface IPriceLevelService extends IService<PriceLevel> {
    int updateByPrimaryKey(PriceLevel record);
}
