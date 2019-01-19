package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.TrueCustomer;
import cn.dovahkiin.mapper.TrueCustomerMapper;
import cn.dovahkiin.service.ITrueCustomerService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 客户信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-29
 */
@Service
public class TrueCustomerServiceImpl extends ServiceImpl<TrueCustomerMapper, TrueCustomer> implements ITrueCustomerService {
    @Override
    @Transactional(propagation=Propagation.REQUIRES_NEW)
    public boolean insert(TrueCustomer trueCustomer){
        return super.insert(trueCustomer);
    }
}
