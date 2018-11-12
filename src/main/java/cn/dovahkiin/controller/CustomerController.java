package cn.dovahkiin.controller;

import javax.validation.Valid;

import java.util.List;
import java.util.Date;
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
 * @since 2018-11-03
 */
@Controller
@RequestMapping("/customer")
public class CustomerController extends BaseController {

    @Autowired private ICustomerService customerService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/customer/customerList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Customer customer, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Customer> ew = new EntityWrapper<Customer>(customer);
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
    public String addPage() {
        return "admin/customer/customerAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Customer customer) {
        customer.setCreateTime(new Date());
        customer.setUpdateTime(new Date());
        customer.setDeleteFlag(0);
        boolean b = customerService.insert(customer);
        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    
    /**
     * 删除
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        Customer customer = new Customer();
        customer.setId(id);
        customer.setUpdateTime(new Date());
        customer.setDeleteFlag(1);
        boolean b = customerService.updateById(customer);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
        Customer customer = customerService.selectById(id);
        model.addAttribute("customer", customer);
        return "admin/customer/customerEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
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
