package cn.dovahkiin.controller;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import cn.dovahkiin.commons.utils.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
import cn.dovahkiin.model.ProductType;
import cn.dovahkiin.service.IProductTypeService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 产品类型信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-18
 */
@Controller
@RequestMapping("/productType")
public class ProductTypeController extends BaseController {

    @Autowired private IProductTypeService productTypeService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/productType/manager")
    public String manager() {
        return "productType/productTypeList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/productType/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(ProductType productType, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<ProductType> ew = new EntityWrapper<ProductType>();
        if(productType!=null && StringUtils.hasText(productType.getCode()))ew.like("code","%"+productType.getCode().trim()+"%");
        if(productType!=null && StringUtils.hasText(productType.getName()) )ew.like("name","%"+productType.getName().trim()+"%");
        if(productType!=null && productType.getDeleteFlag()!=null  ) ew.eq("delete_flag", productType.getDeleteFlag() );
        Page<ProductType> pages = getPage(page, rows, sort, order);
        pages = productTypeService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/productType/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            ProductType productType = productTypeService.selectById(id);
            if(productType!=null){
                productType.setId(null);
                productType.setCode(null);
                model.addAttribute("productType", productType);
            }

        }
        return "productType/productTypeEdit";
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
        if(ids!=null){
            String[] idss = ids.split(",");
            List<ProductType> list = new ArrayList<ProductType>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    ProductType productType = new ProductType();
                    productType.setId(Long.valueOf(str));
                    productType.setDeleteFlag(1);
                    list.add(productType);
                }
            }
            if(list.size()>0){
                boolean suc = productTypeService.updateBatchById(list);
                if(suc)return renderSuccess("删除成功！");
            }
        }

        return renderError("删除失败！");

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
        if(ids!=null){
            String[] idss = ids.split(",");
            List<ProductType> list = new ArrayList<ProductType>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    ProductType productType = new ProductType();
                    productType.setId(Long.valueOf(str));
                    productType.setDeleteFlag(0);
                    list.add(productType);
                }
            }
            if(list.size()>0){
                boolean suc = productTypeService.updateBatchById(list);
                if(suc)return renderSuccess("恢复成功！");
            }
        }
            return renderError("恢复失败！");
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
        ProductType productType = productTypeService.selectById(id);
        model.addAttribute("productType", productType);
        model.addAttribute("method", "edit");
        return "productType/productTypeEdit";
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
        productType.setUpdateTime(new Date());
        boolean b = productTypeService.updateById(productType);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
