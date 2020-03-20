package cn.dovahkiin.test.base;

import cn.dovahkiin.mapper.CountMapper;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author 骆长涛 28595
 * @DateTime 2018/11/20 11:32
 * @description
 */
public class CustomerDaoTest extends BaseTest {
    public static final Log logger = LogFactory.getLog(CustomerDaoTest.class);
    @Autowired
    private CountMapper countMapper;

    @Test
    public void testSelect(){

//        List<CustomerEffectOne> customerEffectOneList = countMapper.selectEffectCustomer();
    }
}
