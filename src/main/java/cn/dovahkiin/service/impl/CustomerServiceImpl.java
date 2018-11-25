package cn.dovahkiin.service.impl;

import cn.dovahkiin.commons.utils.JsonUtils;
import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.model.*;
import cn.dovahkiin.mapper.CustomerMapper;
import cn.dovahkiin.service.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.*;

/**
 * <p>
 * 客户信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Service
public class CustomerServiceImpl implements ICustomerService {
	@Autowired
    private CustomerMapper customerMapper;

    // 调用服务，即使失败数据也不会回滚
    @Autowired private ICustomerService customerService;
    @Autowired private IEditorService editorService;
    @Autowired private IIndustryService iIndustryService;
    @Autowired private IOptimizerService iOptimizerService;
    @Autowired private IOrganizationService iOrganizationService;
    @Autowired private IOriginalityService iOriginalityService;
    @Autowired private IPerformerService performerService;
    @Autowired private IPhotographerService iPhotographerService;
    @Autowired private IProductTypeService iProductTypeService;
    @Autowired private IVideoTypeService videoTypeService;

    @Override
    public int deleteByPrimaryKey(Long id) {
        return customerMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Customer> selectUnDeleted() {
        Map map = new HashMap();
        Customer customer = new Customer();
        customer.setDeleteFlag(0);
        map.put("customer",customer);
        return customerMapper.selectList(map);
    }

    @Override
    public List<Customer> selectList(Map map) {
        return customerMapper.selectList(map);
    }

    @Override
    public Page<Customer> selectPage(Page<Customer> pages, Map<String, Object> map) {
        List<Customer>  customers = customerMapper.selectList(map);
        int total = customerMapper.selectTotal(map);
        pages.setRecords(customers);
        pages.setTotal(total);
        return pages;
    }

    @Override
    public int insertSelective(Customer record) {
        return customerMapper.insertSelective(record);
    }

    @Override
    public Customer selectByPrimaryKey(Long id) {
        Map map = new HashMap();
        Customer customer = new Customer();
        customer.setId(id);
        map.put("customer",customer);
        List<Customer> list = customerMapper.selectList(map);
        if(list!=null && list.size()==1)return list.get(0);
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(Customer record) {
        return customerMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Customer record) {
        return customerMapper.updateByPrimaryKey(record);
    }

    @Override
    public int insert(Customer record) {
        return customerMapper.insert(record);
    }

    @Override
    public int deleteMany(List<String> ids) {
        return customerMapper.deleteMany(checkIdList(ids));
    }

    @Override
    public int rollBack(List<String> ids) {
        return customerMapper.rollBack(checkIdList(ids));
    }
    private String[] checkIdList(List<String> ids){
        Set<String> set = new HashSet<String>();
        for(String id:ids)if(StringUtils.hasText(id) )set.add(id);
        String[] n_ids = new String[set.size()];
        return  set.toArray(n_ids);
    }

    @Override
    public Model modelForEdit(Model model) {
        EntityWrapper un_delete = new EntityWrapper();
        un_delete.eq("delete_flag",0);
//        List<Customer> customers = customerService.selectUnDeleted();
//        model.addAttribute("customers",customers);
        List<Editor> editors = editorService.selectList(un_delete);
        model.addAttribute("editors",JsonUtils.toJson(editors));
        List<Industry> industries = iIndustryService.selectList(un_delete);
        model.addAttribute("industries",JsonUtils.toJson(industries));
        List<Originality> originalities = iOriginalityService.selectList(un_delete);
        model.addAttribute("originalities",JsonUtils.toJson(originalities));
        List<Performer> performers = performerService.selectList(un_delete);
        model.addAttribute("performers",JsonUtils.toJson(performers));
        List<Photographer> photographers = iPhotographerService.selectList(un_delete);
        model.addAttribute("photographers",JsonUtils.toJson(photographers));
        List<ProductType> productTypes = iProductTypeService.selectList(un_delete);
        model.addAttribute("productTypes",JsonUtils.toJson(productTypes));
        List<VideoType> videoTypes = videoTypeService.selectList(un_delete);
        model.addAttribute("videoTypes",JsonUtils.toJson(videoTypes));
        return model;
    }
}