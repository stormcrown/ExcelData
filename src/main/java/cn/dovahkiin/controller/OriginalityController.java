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
import cn.dovahkiin.model.Originality;
import cn.dovahkiin.service.IOriginalityService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 创意师信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Controller
@RequestMapping("/originality")
public class OriginalityController extends BaseController {

    @Autowired private IOriginalityService originalityService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/originality/originalityList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Originality originality, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Originality> ew = new EntityWrapper<Originality>(originality);
        Page<Originality> pages = getPage(page, rows, sort, order);
        pages = originalityService.selectPage(pages, ew);
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
        return "admin/originality/originalityAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Originality originality) {
        originality.setCreateTime(new Date());
        originality.setUpdateTime(new Date());
        originality.setDeleteFlag(0);
        boolean b = originalityService.insert(originality);
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
        Originality originality = new Originality();
        originality.setId(id);
        originality.setUpdateTime(new Date());
        originality.setDeleteFlag(1);
        boolean b = originalityService.updateById(originality);
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
        Originality originality = originalityService.selectById(id);
        model.addAttribute("originality", originality);
        return "admin/originality/originalityEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Originality originality) {
        originality.setUpdateTime(new Date());
        boolean b = originalityService.updateById(originality);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
