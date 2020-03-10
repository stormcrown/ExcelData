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

    @Autowired private ISystemConfigService systemConfigService;
    
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
        EntityWrapper<SystemConfig> ew = new EntityWrapper<SystemConfig>();
        Page<SystemConfig> pages = getPage(page, rows, sort, order);
        pages = systemConfigService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
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
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/systemConfig/edit")
    public String editPage(Model model, Long id) {
        SystemConfig systemConfig = systemConfigService.selectById(id);
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
    public Object edit(@Valid SystemConfig systemConfig) {
        systemConfig.setUpdateTime(new Date());
        systemConfig.setUpdateBy(getUserId());
        boolean b = systemConfigService.updateById(systemConfig);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
