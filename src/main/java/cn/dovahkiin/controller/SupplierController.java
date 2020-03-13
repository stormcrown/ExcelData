package cn.dovahkiin.controller;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import cn.dovahkiin.commons.utils.StringUtils;
import com.alibaba.fastjson.JSON;
import org.apache.shiro.authz.annotation.Logical;
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
import cn.dovahkiin.model.Supplier;
import cn.dovahkiin.service.ISupplierService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
@Controller
@RequestMapping("/supplier")
public class SupplierController extends BaseController {
    private ISupplierService supplierService;
    @Autowired
    public void setSupplierService(ISupplierService supplierService) { this.supplierService = supplierService; }

    @GetMapping("/manager")
    @RequiresPermissions("/supplier/manager")
    public String manager() {
        return "supplier/supplierList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/supplier/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Supplier supplier, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Supplier> ew = new EntityWrapper<Supplier>();
        if(supplier!=null && StringUtils.hasText(supplier.getCode()))ew.like("code","%"+supplier.getCode().trim()+"%");
        if(supplier!=null && StringUtils.hasText(supplier.getName()) )ew.like("name","%"+supplier.getName().trim()+"%");
        if(supplier!=null && supplier.getDeleteFlag()!=null  ) ew.eq("delete_flag", supplier.getDeleteFlag() );
        Page<Supplier> pages = getPage(page, rows, sort, order);
        pages = supplierService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar"  },logical = Logical.OR)
    public Object combobox(){
        EntityWrapper ew = new EntityWrapper();
        ew.eq("delete_flag", 0 );
        return JSON.toJSON(supplierService.selectList(ew));
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/supplier/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            Supplier supplier = supplierService.selectById(id);
            if(supplier!=null){
                supplier.setId(null);
                model.addAttribute("supplier", supplier);
            }
        }
        return "supplier/supplierEdit";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/supplier/add")
    @ResponseBody
    public Object add(@Valid Supplier supplier) {
        return super.add(supplier,supplierService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/supplier/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Supplier> list = new ArrayList<Supplier>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Supplier supplier = new Supplier();
                    supplier.setId(Long.valueOf(str));
                    supplier.setDeleteFlag(1);
                    list.add(supplier);
                }
            }
            if(list.size()>0){
                boolean suc = supplierService.updateBatchById(list);
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
@RequiresPermissions("/supplier/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Supplier> list = new ArrayList<Supplier>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Supplier supplier = new Supplier();
                    supplier.setId(Long.valueOf(str));
                    supplier.setDeleteFlag(0);
                    list.add(supplier);
                }
            }
            if(list.size()>0){
                boolean suc = supplierService.updateBatchById(list);
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
    @RequiresPermissions("/supplier/edit")
    public String editPage(Model model, Long id) {
        Supplier supplier = supplierService.selectById(id);
        model.addAttribute("supplier", supplier);
        model.addAttribute("method", "edit");
        return "supplier/supplierEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/supplier/edit")
    @ResponseBody
    public Object edit(@Valid Supplier supplier) {
        supplier.setUpdateTime(new Date());
        boolean b = supplierService.updateById(supplier);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
