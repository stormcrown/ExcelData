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
import cn.dovahkiin.model.Performer;
import cn.dovahkiin.service.IPerformerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 演员信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Controller
@RequestMapping("/performer")
public class PerformerController extends BaseController {

    @Autowired private IPerformerService performerService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/performer/performerList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Performer performer, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Performer> ew = new EntityWrapper<Performer>(performer);
        Page<Performer> pages = getPage(page, rows, sort, order);
        pages = performerService.selectPage(pages, ew);
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
        return "admin/performer/performerAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Performer performer) {
        performer.setCreateTime(new Date());
        performer.setUpdateTime(new Date());
        performer.setDeleteFlag(0);
        boolean b = performerService.insert(performer);
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
        Performer performer = new Performer();
        performer.setId(id);
        performer.setUpdateTime(new Date());
        performer.setDeleteFlag(1);
        boolean b = performerService.updateById(performer);
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
        Performer performer = performerService.selectById(id);
        model.addAttribute("performer", performer);
        return "admin/performer/performerEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
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
