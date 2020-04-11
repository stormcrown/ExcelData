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
import cn.dovahkiin.model.ProductType;
import cn.dovahkiin.service.IProductTypeService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 产品类型信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/productType")
public class ProductTypeController extends BaseController {

    private IProductTypeService productTypeService;
    @Autowired
    public void setIProductTypeService(IProductTypeService productTypeService) {
        this.productTypeService = productTypeService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/productType/manager")
    public String manager() {
        return "productType/productTypeList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/productType/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(ProductType productType, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(productType,productTypeService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(productTypeService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/productType/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,productTypeService,ProductType.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/productType/add")
    @ResponseBody
    public Object add(@Valid ProductType productType) {
        return super.add(productType,productTypeService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/productType/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,ProductType.class,productTypeService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/productType/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,productTypeService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/productType/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,ProductType.class,productTypeService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/productType/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,ProductType.class,productTypeService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/productType/edit")
    @ResponseBody
    public Object edit(@Valid ProductType productType) {
        return super.edit(productType,productTypeService);
    }
}
