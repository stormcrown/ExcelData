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
import cn.dovahkiin.model.Photographer;
import cn.dovahkiin.service.IPhotographerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 摄像师信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Controller
@RequestMapping("/photographer")
public class PhotographerController extends BaseController {

    @Autowired private IPhotographerService photographerService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/photographer/photographerList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Photographer photographer, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Photographer> ew = new EntityWrapper<Photographer>(photographer);
        Page<Photographer> pages = getPage(page, rows, sort, order);
        pages = photographerService.selectPage(pages, ew);
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
        return "admin/photographer/photographerAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Photographer photographer) {
        photographer.setCreateTime(new Date());
        photographer.setUpdateTime(new Date());
        photographer.setDeleteFlag(0);
        boolean b = photographerService.insert(photographer);
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
        Photographer photographer = new Photographer();
        photographer.setId(id);
        photographer.setUpdateTime(new Date());
        photographer.setDeleteFlag(1);
        boolean b = photographerService.updateById(photographer);
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
        Photographer photographer = photographerService.selectById(id);
        model.addAttribute("photographer", photographer);
        return "admin/photographer/photographerEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
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
