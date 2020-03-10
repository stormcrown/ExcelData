package cn.dovahkiin.service.impl;

import cn.dovahkiin.mapper.CountMapper;
import cn.dovahkiin.mapper.CustomerMapper;
import cn.dovahkiin.mapper.EditorMapper;
import cn.dovahkiin.model.Customer;
import cn.dovahkiin.model.Editor;
import cn.dovahkiin.service.ICountService;
import cn.dovahkiin.service.IEditorService;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 统计服务
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Service
public class CountServiceImpl implements ICountService {
    private static final org.slf4j.Logger log = LoggerFactory.getLogger(CountServiceImpl.class);
    private CountMapper countMapper;
    private CustomerMapper customerMapper;
    @Autowired
    public void setCountMapper(CountMapper countMapper) { this.countMapper = countMapper; }
    @Autowired
    public void setCustomerMapper(CustomerMapper customerMapper) { this.customerMapper = customerMapper; }

    @Override
    public List<Map> count1(Map map) {
        return countMapper.count1(map);
    }

    @Override
    public List<Map> countByOptimizer(Map map) {
        return countMapper.countByOptimizer(map);
    }

    @Override
    public List<Map> countByCustomer(Map map) {
        return countMapper.countByCustomer(map);
    }


//    @Override
//    public List<Map> effCount1(Map map,Integer effectDays, Double maxEffectCon) {
//        /* 查出所有在有效期内有消耗的素材 */
//        List<Customer> customers = customerMapper.selectSimpleListByVideoCost(map);
//        /* 查询所有 */
//        List<Map> largerCus = countMapper.effCount1(effectDays,maxEffectCon);
//
//        return null;
//    }


}
