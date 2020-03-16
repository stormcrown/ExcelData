package cn.dovahkiin.test.base;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.commons.shiro.ShiroUser;
import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.mapper.VideoCostMapper;
import cn.dovahkiin.model.Customer;
import cn.dovahkiin.model.VideoCost;
import cn.dovahkiin.service.*;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.FileInputStream;
import java.io.InputStream;
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
    @Autowired
    protected DateConverter dateConverter;
    @Test
    public void seleectAll(){
        List<Customer> customerList = customerService.selectUnDeleted(null);
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
    @Test
    public void saveFileData()throws Exception{
        InputStream inputStream = new FileInputStream("E:/Develop/导入数据模板.xlsx");
        List<ArrayList<Object>> arrayLists = simpleEasyExcelUtil.readComon(inputStream);
        logger.info(JSON.toJSONString(arrayLists));
        Set<String> sets = new HashSet<>();
        ShiroUser user = new ShiroUser(-1L,"testUser","五",sets,null);

        int m = iVideoCostService.handleExcelFile(arrayLists,null,user);
        logger.info(m);

    }
}
