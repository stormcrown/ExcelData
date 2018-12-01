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
import cn.dovahkiin.model.Photographer;
import cn.dovahkiin.service.IPhotographerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 摄像师信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-19
 */
@Controller
@RequestMapping("/photographer")
public class PhotographerController extends BaseController {

    @Autowired private IPhotographerService photographerService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/photographer/manager")
    public String manager() {
        return "photographer/photographerList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/photographer/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Photographer photographer, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Photographer> ew = new EntityWrapper<Photographer>();
        if(photographer!=null && StringUtils.hasText(photographer.getCode()))ew.like("code","%"+photographer.getCode().trim()+"%");
        if(photographer!=null && StringUtils.hasText(photographer.getName()) )ew.like("name","%"+photographer.getName().trim()+"%");
        if(photographer!=null && photographer.getDeleteFlag()!=null  ) ew.eq("delete_flag", photographer.getDeleteFlag() );
        Page<Photographer> pages = getPage(page, rows, sort, order);
        pages = photographerService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/dataGrid" },logical = Logical.OR)
    public Object dataGrid() {
        EntityWrapper ew = new EntityWrapper();
        ew.eq("delete_flag", 0 );
        return JSON.toJSON(photographerService.selectList(ew));
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/photographer/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            Photographer photographer = photographerService.selectById(id);
            if(photographer!=null){
                photographer.setId(null);
                model.addAttribute("photographer", photographer);
            }

        }
        return "photographer/photographerEdit";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/photographer/add")
    @ResponseBody
    public Object add(@Valid Photographer photographer) {
        return super.add(photographer,photographerService);

    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/photographer/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Photographer> list = new ArrayList<Photographer>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Photographer photographer = new Photographer();
                    photographer.setId(Long.valueOf(str));
                    photographer.setDeleteFlag(1);
                    list.add(photographer);
                }
            }
            if(list.size()>0){
                boolean suc = photographerService.updateBatchById(list);
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
@RequiresPermissions("/photographer/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Photographer> list = new ArrayList<Photographer>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Photographer photographer = new Photographer();
                    photographer.setId(Long.valueOf(str));
                    photographer.setDeleteFlag(0);
                    list.add(photographer);
                }
            }
            if(list.size()>0){
                boolean suc = photographerService.updateBatchById(list);
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
    @RequiresPermissions("/photographer/edit")
    public String editPage(Model model, Long id) {
        Photographer photographer = photographerService.selectById(id);
        model.addAttribute("photographer", photographer);
        model.addAttribute("method", "edit");
        return "photographer/photographerEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/photographer/edit")
    @ResponseBody
    public Object edit(@Valid Photographer photographer) {
        photographer.setUpdateTime(new Date());
        boolean b = photographerService.updateById(photographer);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
