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
import cn.dovahkiin.model.PriceLevel;
import cn.dovahkiin.service.IPriceLevelService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/priceLevel")
public class PriceLevelController extends BaseController {

    private IPriceLevelService priceLevelService;
    @Autowired
    public void setIPriceLevelService(IPriceLevelService priceLevelService) {
        this.priceLevelService = priceLevelService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/priceLevel/manager")
    public String manager() {
        return "priceLevel/priceLevelList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/priceLevel/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(PriceLevel priceLevel, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(priceLevel,priceLevelService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(priceLevelService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/priceLevel/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,priceLevelService,PriceLevel.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/priceLevel/add")
    @ResponseBody
    public Object add(@Valid PriceLevel priceLevel) {
        if(priceLevel==null) return renderError("新增失败！");
        Long userId = getUserId();
        priceLevel.setUpdateBy(userId);
        priceLevel.setCreateBy(userId);
        return super.add(priceLevel,priceLevelService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/priceLevel/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,PriceLevel.class,priceLevelService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/priceLevel/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,priceLevelService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/priceLevel/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,PriceLevel.class,priceLevelService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/priceLevel/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,PriceLevel.class,priceLevelService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/priceLevel/edit")
    @ResponseBody
    public Object edit(@Valid PriceLevel priceLevel) {
        if(priceLevel==null) return renderError("更新失败！");
        Long userId = getUserId();
        priceLevel.setUpdateBy(userId);
        return super.edit(priceLevel,priceLevelService);
    }
}
