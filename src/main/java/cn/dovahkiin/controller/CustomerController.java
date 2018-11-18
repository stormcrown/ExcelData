package cn.dovahkiin.controller;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import cn.dovahkiin.commons.utils.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.model.Customer;
import cn.dovahkiin.service.ICustomerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 客户信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-18
 */
@Controller
@RequestMapping("/customer")
public class CustomerController extends BaseController {

    @Autowired private ICustomerService customerService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/customer/manager")
    public String manager() {
        return "customer/customerList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/customer/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Customer customer, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Customer> ew = new EntityWrapper<Customer>();
        if(customer!=null && StringUtils.hasText(customer.getCode()))ew.like("code","%"+customer.getCode().trim()+"%");
        if(customer!=null && StringUtils.hasText(customer.getName()) )ew.like("name","%"+customer.getName().trim()+"%");
        if(customer!=null && customer.getDeleteFlag()!=null  ) ew.eq("delete_flag", customer.getDeleteFlag() );
        Page<Customer> pages = getPage(page, rows, sort, order);
        pages = customerService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/customer/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            Customer customer = customerService.selectById(id);
            if(customer!=null){
                customer.setId(null);
                customer.setCode(null);
                model.addAttribute("customer", customer);
            }

        }
        return "customer/customerEdit";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/customer/add")
    @ResponseBody
    public Object add(@Valid Customer customer) {
        return super.add(customer,customerService);

    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/customer/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Customer> list = new ArrayList<Customer>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Customer customer = new Customer();
                    customer.setId(Long.valueOf(str));
                    customer.setDeleteFlag(1);
                    list.add(customer);
                }
            }
            if(list.size()>0){
                boolean suc = customerService.updateBatchById(list);
                if(suc)return renderSuccess("删除成功！");
            }
        }

        return renderError("删除失败！");

    }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/customer/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Customer> list = new ArrayList<Customer>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Customer customer = new Customer();
                    customer.setId(Long.valueOf(str));
                    customer.setDeleteFlag(0);
                    list.add(customer);
                }
            }
            if(list.size()>0){
                boolean suc = customerService.updateBatchById(list);
                if(suc)return renderSuccess("恢复成功！");
            }
        }
            return renderError("恢复失败！");
        }
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/customer/edit")
    public String editPage(Model model, Long id) {
        Customer customer = customerService.selectById(id);
        model.addAttribute("customer", customer);
        model.addAttribute("method", "edit");
        return "customer/customerEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/customer/edit")
    @ResponseBody
    public Object edit(@Valid Customer customer) {
        customer.setUpdateTime(new Date());
        boolean b = customerService.updateById(customer);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
