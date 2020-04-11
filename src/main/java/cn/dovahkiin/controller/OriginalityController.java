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
import cn.dovahkiin.model.Originality;
import cn.dovahkiin.service.IOriginalityService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 创意师信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/originality")
public class OriginalityController extends BaseController {

    private IOriginalityService originalityService;
    @Autowired
    public void setIOriginalityService(IOriginalityService originalityService) {
        this.originalityService = originalityService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/originality/manager")
    public String manager() {
        return "originality/originalityList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/originality/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Originality originality, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(originality,originalityService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(originalityService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/originality/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,originalityService,Originality.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/originality/add")
    @ResponseBody
    public Object add(@Valid Originality originality) {
        return super.add(originality,originalityService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/originality/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,Originality.class,originalityService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/originality/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,originalityService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/originality/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,Originality.class,originalityService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/originality/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,Originality.class,originalityService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/originality/edit")
    @ResponseBody
    public Object edit(@Valid Originality originality) {
        return super.edit(originality,originalityService);
    }
}
