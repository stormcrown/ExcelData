package cn.dovahkiin.controller;

import javax.validation.Valid;
import cn.dovahkiin.util.Const;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.model.TrueCustomer;
import cn.dovahkiin.service.ITrueCustomerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 客户信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/trueCustomer")
public class TrueCustomerController extends BaseController {

    private ITrueCustomerService trueCustomerService;
    @Autowired
    public void setITrueCustomerService(ITrueCustomerService trueCustomerService) {
        this.trueCustomerService = trueCustomerService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/trueCustomer/manager")
    public String manager() {
        return "trueCustomer/trueCustomerList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/trueCustomer/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(TrueCustomer trueCustomer, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(trueCustomer,trueCustomerService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(trueCustomerService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/trueCustomer/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,trueCustomerService,TrueCustomer.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/trueCustomer/add")
    @ResponseBody
    public Object add(@Valid TrueCustomer trueCustomer) {
        return super.add(trueCustomer,trueCustomerService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/trueCustomer/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,TrueCustomer.class,trueCustomerService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/trueCustomer/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,trueCustomerService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/trueCustomer/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,TrueCustomer.class,trueCustomerService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/trueCustomer/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,TrueCustomer.class,trueCustomerService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/trueCustomer/edit")
    @ResponseBody
    public Object edit(@Valid TrueCustomer trueCustomer) {
        return super.edit(trueCustomer,trueCustomerService);
    }
}
