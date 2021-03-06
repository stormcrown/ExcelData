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
import cn.dovahkiin.model.PayLevel;
import cn.dovahkiin.service.IPayLevelService;
import cn.dovahkiin.commons.base.BaseController;

import java.util.Date;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/payLevel")
public class PayLevelController extends BaseController {

    private IPayLevelService payLevelService;
    @Autowired
    public void setIPayLevelService(IPayLevelService payLevelService) {
        this.payLevelService = payLevelService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/payLevel/manager")
    public String manager() {
        return "payLevel/payLevelList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/payLevel/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(PayLevel payLevel, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(payLevel,payLevelService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(payLevelService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/payLevel/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,payLevelService,PayLevel.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/payLevel/add")
    @ResponseBody
    public Object add(@Valid PayLevel payLevel) {
        if(payLevel==null)return renderError("数据为空");
        payLevel.setUpdateBy(getUserId());
        payLevel.setCreateBy(getUserId());
        return super.add(payLevel,payLevelService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/payLevel/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,PayLevel.class,payLevelService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/payLevel/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,payLevelService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/payLevel/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,PayLevel.class,payLevelService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/payLevel/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,PayLevel.class,payLevelService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/payLevel/edit")
    @ResponseBody
    public Object edit(@Valid PayLevel payLevel) {
        payLevel.setUpdateBy(getUserId());
        return super.edit(payLevel,payLevelService);
    }
}
