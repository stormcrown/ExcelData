package cn.dovahkiin.controller;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import cn.dovahkiin.commons.shiro.ShiroUser;
import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.service.ISystemConfigService;
import cn.dovahkiin.util.Const;
import com.alibaba.fastjson.JSON;
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
    private ISystemConfigService iSystemConfigService;
    @Autowired public void setSupplierService(ISupplierService supplierService) { this.supplierService = supplierService; }
    @Autowired public void setiSystemConfigService(ISystemConfigService iSystemConfigService) { this.iSystemConfigService = iSystemConfigService; }

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
        ShiroUser shiroUser = getShiroUser();
        EntityWrapper ew = new EntityWrapper();
        ew.eq("delete_flag", 0 );
        if(shiroUser.getSupplier()!=null)ew.eq("id",shiroUser.getSupplier().getId());
        return JSON.toJSON(supplierService.selectList(ew));
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/supplier/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,supplierService,Supplier.class);
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
        if(supplier==null) return renderError("失败");
        if(StringUtils.isBlank(supplier.getCode())) supplier.CreateCode();
        supplier.setDeleteFlag(0);
        supplier.setUpdateTime(new Date());
        supplier.setCreateTime(new Date());

        supplierService.insertWithConfig(supplier,getUserId());
        return renderSuccess();
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
            List<Long> supperIds = new ArrayList<>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    list.add(new Supplier(Long.valueOf(str),1));
                    supperIds.add(Long.valueOf(str));
                }
            }
            if(list.size()>0){
                boolean suc = supplierService.updateBatchById(list);
                if(suc){
                    iSystemConfigService.toggleBySupplierIds(supperIds,1,getUserId()  );
                    return renderSuccess("删除成功！");
                }
            }
        }
        return renderError("删除失败！");
    }

    @RequiresPermissions("/supplier/delete")
    @PostMapping("/deleteForever")
    @RequiresRoles(Const.Administor_Role_Name)
    @ResponseBody
    public Object deleteForever(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Long> list = new ArrayList<Long>();
            List<Long> supperIds = new ArrayList<>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    list.add(Long.valueOf(str));
                    supperIds.add(Long.valueOf(str));
                }
            }
            if(list.size()>0){
                boolean suc = supplierService.deleteBatchIds(list);
                if(suc){
                    iSystemConfigService.deleteBySupplierIds(supperIds);
                    return renderSuccess("删除成功！");
                }
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
            List<Long> supperIds = new ArrayList<>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    list.add(new Supplier(Long.valueOf(str),0));
                    supperIds.add(Long.valueOf(str));
                }
            }
            if(list.size()>0){

                boolean suc = supplierService.updateBatchById(list);
                if(suc){
                    iSystemConfigService.toggleBySupplierIds(supperIds,0,getUserId()  );
                    return renderSuccess("恢复成功！");
                }
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
