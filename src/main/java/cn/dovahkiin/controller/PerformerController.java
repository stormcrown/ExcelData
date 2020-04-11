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
import cn.dovahkiin.model.Performer;
import cn.dovahkiin.service.IPerformerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 演员信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/performer")
public class PerformerController extends BaseController {

    private IPerformerService performerService;
    @Autowired
    public void setIPerformerService(IPerformerService performerService) {
        this.performerService = performerService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/performer/manager")
    public String manager() {
        return "performer/performerList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/performer/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Performer performer, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(performer,performerService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(performerService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/performer/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,performerService,Performer.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/performer/add")
    @ResponseBody
    public Object add(@Valid Performer performer) {
        return super.add(performer,performerService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/performer/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,Performer.class,performerService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/performer/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,performerService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/performer/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,Performer.class,performerService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/performer/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,Performer.class,performerService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/performer/edit")
    @ResponseBody
    public Object edit(@Valid Performer performer) {
        return super.edit(performer,performerService);
    }
}
