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
import cn.dovahkiin.model.Optimizer;
import cn.dovahkiin.service.IOptimizerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 优化师信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Controller
@RequestMapping("/optimizer")
public class OptimizerController extends BaseController {

    @Autowired private IOptimizerService optimizerService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/optimizer/optimizerList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Optimizer optimizer, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Optimizer> ew = new EntityWrapper<Optimizer>(optimizer);
        Page<Optimizer> pages = getPage(page, rows, sort, order);
        pages = optimizerService.selectPage(pages, ew);
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
        return "admin/optimizer/optimizerAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Optimizer optimizer) {
        optimizer.setCreateTime(new Date());
        optimizer.setUpdateTime(new Date());
        optimizer.setDeleteFlag(0);
        boolean b = optimizerService.insert(optimizer);
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
        Optimizer optimizer = new Optimizer();
        optimizer.setId(id);
        optimizer.setUpdateTime(new Date());
        optimizer.setDeleteFlag(1);
        boolean b = optimizerService.updateById(optimizer);
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
        Optimizer optimizer = optimizerService.selectById(id);
        model.addAttribute("optimizer", optimizer);
        return "admin/optimizer/optimizerEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Optimizer optimizer) {
        optimizer.setUpdateTime(new Date());
        boolean b = optimizerService.updateById(optimizer);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
