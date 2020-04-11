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
import cn.dovahkiin.model.Optimizer;
import cn.dovahkiin.service.IOptimizerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 优化师信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/optimizer")
public class OptimizerController extends BaseController {

    private IOptimizerService optimizerService;
    @Autowired
    public void setIOptimizerService(IOptimizerService optimizerService) {
        this.optimizerService = optimizerService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/optimizer/manager")
    public String manager() {
        return "optimizer/optimizerList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/optimizer/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Optimizer optimizer, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(optimizer,optimizerService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(optimizerService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/optimizer/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,optimizerService,Optimizer.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/optimizer/add")
    @ResponseBody
    public Object add(@Valid Optimizer optimizer) {
        return super.add(optimizer,optimizerService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/optimizer/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,Optimizer.class,optimizerService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/optimizer/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,optimizerService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/optimizer/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,Optimizer.class,optimizerService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/optimizer/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,Optimizer.class,optimizerService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/optimizer/edit")
    @ResponseBody
    public Object edit(@Valid Optimizer optimizer) {
        return super.edit(optimizer,optimizerService);
    }
}
