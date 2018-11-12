package cn.dovahkiin.test.base;

import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.mapper.VideoCostMapper;
import cn.dovahkiin.model.Customer;
import cn.dovahkiin.model.VideoCost;
import cn.dovahkiin.service.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;

public class ServiceTest extends BaseTest{
    @Autowired private ICustomerService customerService;
    @Autowired private IEditorService editorService;
    @Autowired private IIndustryService iIndustryService;
    @Autowired private IOptimizerService iOptimizerService;
    @Autowired private IOrganizationService iOrganizationService;
    @Autowired private IOriginalityService iOriginalityService;
    @Autowired private IPerformerService performerService;
    @Autowired private IPhotographerService iPhotographerService;
    @Autowired private IProductTypeService iProductTypeService;
    @Autowired private IVideoCostService iVideoCostService;
    @Test
    public void seleectAll(){
//        Customer customer0 = new Customer();
//        customer0.setDeleteFlag(0);
        EntityWrapper un_delete = new EntityWrapper();
        un_delete.eq("delete_flag",0);
        List<Customer> customerList = customerService.selectList(un_delete);
        for(Customer customer: customerList)logger.info("Customer = " +customer.toString());

    }
    @Test
    public void saver(){
        Customer customer = new Customer();
        customer.setName("醋味");
        customer.setCode("Code");
        customer.setCreateTime(new Date());
        customerService.insert(customer);
        logger.info(customer);

    }
}
