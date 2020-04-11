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
import cn.dovahkiin.model.Photographer;
import cn.dovahkiin.service.IPhotographerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 摄像师信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/photographer")
public class PhotographerController extends BaseController {

    private IPhotographerService photographerService;
    @Autowired
    public void setIPhotographerService(IPhotographerService photographerService) {
        this.photographerService = photographerService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/photographer/manager")
    public String manager() {
        return "photographer/photographerList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/photographer/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Photographer photographer, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(photographer,photographerService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(photographerService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/photographer/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,photographerService,Photographer.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/photographer/add")
    @ResponseBody
    public Object add(@Valid Photographer photographer) {
        return super.add(photographer,photographerService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/photographer/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,Photographer.class,photographerService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/photographer/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,photographerService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/photographer/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,Photographer.class,photographerService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/photographer/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,Photographer.class,photographerService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/photographer/edit")
    @ResponseBody
    public Object edit(@Valid Photographer photographer) {
        return super.edit(photographer,photographerService);
    }
}
