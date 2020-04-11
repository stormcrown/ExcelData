package cn.dovahkiin.controller;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import cn.dovahkiin.commons.shiro.ShiroUser;
import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.model.Supplier;
import cn.dovahkiin.service.ISupplierService;
import cn.dovahkiin.util.Const;
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
import cn.dovahkiin.model.SystemConfig;
import cn.dovahkiin.service.ISystemConfigService;
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
@RequestMapping("/systemConfig")
public class SystemConfigController extends BaseController {
    private ISystemConfigService systemConfigService;
    private ISupplierService iSupplierService;
    @GetMapping("/manager")
    @RequiresPermissions("/systemConfig/manager")
    public String manager() {
        return "systemConfig/systemConfigList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/systemConfig/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(SystemConfig systemConfig, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Page<SystemConfig> pages = getPage(page, rows, sort, order);
        ShiroUser shiroUser = getShiroUser();
        Supplier supplier = shiroUser.getSupplier();
       Long supid= supplier!=null?supplier.getId():null;
        pageInfo.setRows(systemConfigService.selectPageList(systemConfig,supid,sort,order,pages.getOffset(),pages.getLimit()));
        pageInfo.setTotal(systemConfigService.selectTotal(  systemConfig, supid));
        return pageInfo;
    }
    
//    /**
//     * 添加页面
//     * @return
//     */
//    @GetMapping("/addPage")
//    @RequiresPermissions("/systemConfig/add")
//    public String addPage(Model model,Long id) {
//        model.addAttribute("method", "add");
//        if(id!=null){
//            SystemConfig systemConfig = systemConfigService.selectById(id);
//            if(systemConfig!=null){
//                systemConfig.setId(null);
//                model.addAttribute("systemConfig", systemConfig);
//            }
//
//        }
//        return "systemConfig/systemConfigEdit";
//    }
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/systemConfig/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<SystemConfig> list = new ArrayList<SystemConfig>();
            List<Long> scIds = new ArrayList<>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ) {
                    Long id = Long.valueOf(str);
                    if(id.equals(SystemConfig.ID))return renderError("全局配置不能删除");
                    list.add(new SystemConfig(id,1));
                    scIds.add(id);
                }
            }
            if(list.size()>0){
                boolean suc = systemConfigService.updateBatchById(list);
                if(suc){
                    iSupplierService.toggleBySystemConfigIds(scIds,1);
                    return renderSuccess("删除成功！");
                }
            }
        }

        return renderError("删除失败！");

    }
    @RequiresPermissions("/systemConfig/delete")
    @PostMapping("/deleteForever")
    @RequiresRoles(Const.Administor_Role_Name)
    @ResponseBody
    public Object deleteForever(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Long> list = new ArrayList<Long>();
            List<Long> scIds = new ArrayList<>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Long id = Long.valueOf(str);
                    if(id.equals(SystemConfig.ID))return renderError("全局配置不能删除");
                    list.add(id);
                    scIds.add(id);
                }
            }
            if(list.size()>0){
                boolean suc = systemConfigService .deleteBatchIds(list);
                if(suc){
                    iSupplierService.deleteBySystemConfigIds(scIds);
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
    @RequiresPermissions("/systemConfig/rollback")
    @ResponseBody
    public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<SystemConfig> list = new ArrayList<SystemConfig>();
            List<Long> scIds = new ArrayList<>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ) {
                    list.add(new SystemConfig(Long.valueOf(str),0));
                    scIds.add(Long.valueOf(str));
                }
            }
            if(list.size()>0){
                boolean suc = systemConfigService.updateBatchById(list);
                if(suc){
                    iSupplierService.toggleBySystemConfigIds(scIds,0);
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
    @RequiresPermissions("/systemConfig/edit")
    public String editPage(Model model, Long id) {
        SystemConfig systemConfig = systemConfigService.selectByPrimaryKey(id);
        model.addAttribute("systemConfig", systemConfig);
        model.addAttribute("method", "edit");
        return "systemConfig/systemConfigEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/systemConfig/edit")
    @ResponseBody
    public Object edit(SystemConfig systemConfig) {
        systemConfig.setUpdateTime(new Date());
        systemConfig.setUpdateBy(getUserId());
        int b = systemConfigService.updateByPrimaryKey(systemConfig);
        if (b==1) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }

    @Autowired
    public void setSystemConfigService(ISystemConfigService systemConfigService) { this.systemConfigService = systemConfigService; }
    @Autowired
    public void setiSupplierService(ISupplierService iSupplierService) { this.iSupplierService = iSupplierService; }
}
