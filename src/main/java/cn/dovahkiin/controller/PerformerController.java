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
import cn.dovahkiin.model.Performer;
import cn.dovahkiin.service.IPerformerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 演员信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-19
 */
@Controller
@RequestMapping("/performer")
public class PerformerController extends BaseController {

    @Autowired private IPerformerService performerService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/performer/manager")
    public String manager() {
        return "performer/performerList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/performer/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Performer performer, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Performer> ew = new EntityWrapper<Performer>();
        if(performer!=null && StringUtils.hasText(performer.getCode()))ew.like("code","%"+performer.getCode().trim()+"%");
        if(performer!=null && StringUtils.hasText(performer.getName()) )ew.like("name","%"+performer.getName().trim()+"%");
        if(performer!=null && performer.getDeleteFlag()!=null  ) ew.eq("delete_flag", performer.getDeleteFlag() );
        Page<Performer> pages = getPage(page, rows, sort, order);
        pages = performerService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object dataGrid() {
        EntityWrapper ew = new EntityWrapper();
        ew.eq("delete_flag", 0 );
        return JSON.toJSON(performerService.selectList(ew));
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/performer/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            Performer performer = performerService.selectById(id);
            if(performer!=null){
                performer.setId(null);
                model.addAttribute("performer", performer);
            }

        }
        return "performer/performerEdit";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/performer/add")
    @ResponseBody
    public Object add(@Valid Performer performer) {
        return super.add(performer,performerService);

    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/performer/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Performer> list = new ArrayList<Performer>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Performer performer = new Performer();
                    performer.setId(Long.valueOf(str));
                    performer.setDeleteFlag(1);
                    list.add(performer);
                }
            }
            if(list.size()>0){
                boolean suc = performerService.updateBatchById(list);
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
@RequiresPermissions("/performer/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Performer> list = new ArrayList<Performer>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Performer performer = new Performer();
                    performer.setId(Long.valueOf(str));
                    performer.setDeleteFlag(0);
                    list.add(performer);
                }
            }
            if(list.size()>0){
                boolean suc = performerService.updateBatchById(list);
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
    @RequiresPermissions("/performer/edit")
    public String editPage(Model model, Long id) {
        Performer performer = performerService.selectById(id);
        model.addAttribute("performer", performer);
        model.addAttribute("method", "edit");
        return "performer/performerEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/performer/edit")
    @ResponseBody
    public Object edit(@Valid Performer performer) {
        performer.setUpdateTime(new Date());
        boolean b = performerService.updateById(performer);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
