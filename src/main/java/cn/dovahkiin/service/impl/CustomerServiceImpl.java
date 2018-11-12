package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.Customer;
import cn.dovahkiin.mapper.CustomerMapper;
import cn.dovahkiin.service.ICustomerService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 客户信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Service
public class CustomerServiceImpl extends ServiceImpl<CustomerMapper, Customer> implements ICustomerService {
	@Autowired
    private CustomerMapper customerMapper;

}
