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
import cn.dovahkiin.model.Industry;
import cn.dovahkiin.service.IIndustryService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 行业信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-04
 */
@Controller
@RequestMapping("/industry")
public class IndustryController extends BaseController {

    @Autowired private IIndustryService industryService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/industry/industryList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Industry industry, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Industry> ew = new EntityWrapper<Industry>(industry);
        Page<Industry> pages = getPage(page, rows, sort, order);
        pages = industryService.selectPage(pages, ew);
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
        return "admin/industry/industryAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Industry industry) {
        industry.setCreateTime(new Date());
        industry.setUpdateTime(new Date());
        industry.setDeleteFlag(0);
        boolean b = industryService.insert(industry);
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
        Industry industry = new Industry();
        industry.setId(id);
        industry.setUpdateTime(new Date());
        industry.setDeleteFlag(1);
        boolean b = industryService.updateById(industry);
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
        Industry industry = industryService.selectById(id);
        model.addAttribute("industry", industry);
        return "admin/industry/industryEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid Industry industry) {
        industry.setUpdateTime(new Date());
        boolean b = industryService.updateById(industry);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
