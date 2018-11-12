package cn.dovahkiin.controller;

import javax.validation.Valid;

import java.util.List;
import java.util.Date;
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
 * @since 2018-11-04
 */
@Controller
@RequestMapping("/productType")
public class ProductTypeController extends BaseController {

    @Autowired private IProductTypeService productTypeService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/productType/productTypeList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(ProductType productType, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<ProductType> ew = new EntityWrapper<ProductType>(productType);
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
    public String addPage() {
        return "admin/productType/productTypeAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid ProductType productType) {
        productType.setCreateTime(new Date());
        productType.setUpdateTime(new Date());
        productType.setDeleteFlag(0);
        boolean b = productTypeService.insert(productType);
        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    
    /**
     * 删除
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        ProductType productType = new ProductType();
        productType.setId(id);
        productType.setUpdateTime(new Date());
        productType.setDeleteFlag(1);
        boolean b = productTypeService.updateById(productType);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
        ProductType productType = productTypeService.selectById(id);
        model.addAttribute("productType", productType);
        return "admin/productType/productTypeEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
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
