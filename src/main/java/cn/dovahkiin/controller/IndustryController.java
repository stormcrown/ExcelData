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
import cn.dovahkiin.model.Industry;
import cn.dovahkiin.service.IIndustryService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 行业信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/industry")
public class IndustryController extends BaseController {

    private IIndustryService industryService;
    @Autowired
    public void setIIndustryService(IIndustryService industryService) {
        this.industryService = industryService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/industry/manager")
    public String manager() {
        return "industry/industryList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/industry/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Industry industry, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(industry,industryService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(industryService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/industry/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,industryService,Industry.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/industry/add")
    @ResponseBody
    public Object add(@Valid Industry industry) {
        return super.add(industry,industryService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/industry/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,Industry.class,industryService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/industry/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,industryService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/industry/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,Industry.class,industryService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/industry/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,Industry.class,industryService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/industry/edit")
    @ResponseBody
    public Object edit(@Valid Industry industry) {
        return super.edit(industry,industryService);
    }
}
