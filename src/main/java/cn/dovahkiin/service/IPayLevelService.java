package cn.dovahkiin.service;

import cn.dovahkiin.model.PayLevel;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author lzt
 * @since 2020-03-27
 */
public interface IPayLevelService extends IService<PayLevel> {
    int updateByPrimaryKey(PayLevel record);
}
