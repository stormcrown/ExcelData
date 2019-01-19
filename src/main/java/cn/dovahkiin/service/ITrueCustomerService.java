package cn.dovahkiin.service;

import cn.dovahkiin.model.TrueCustomer;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 客户信息 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-11-29
 */
public interface ITrueCustomerService extends IService<TrueCustomer> {
    @Override
    boolean insert(TrueCustomer trueCustomer);
}
