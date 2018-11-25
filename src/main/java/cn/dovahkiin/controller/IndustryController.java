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
import cn.dovahkiin.model.Industry;
import cn.dovahkiin.service.IIndustryService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 行业信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-19
 */
@Controller
@RequestMapping("/industry")
public class IndustryController extends BaseController {

    @Autowired private IIndustryService industryService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/industry/manager")
    public String manager() {
        return "industry/industryList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/industry/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Industry industry, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Industry> ew = new EntityWrapper<Industry>();
        if(industry!=null && StringUtils.hasText(industry.getCode()))ew.like("code","%"+industry.getCode().trim()+"%");
        if(industry!=null && StringUtils.hasText(industry.getName()) )ew.like("name","%"+industry.getName().trim()+"%");
        if(industry!=null && industry.getDeleteFlag()!=null  ) ew.eq("delete_flag", industry.getDeleteFlag() );
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
    @RequiresPermissions("/industry/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            Industry industry = industryService.selectById(id);
            if(industry!=null){
                industry.setId(null);
                model.addAttribute("industry", industry);
            }

        }
        return "industry/industryEdit";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/industry/add")
    @ResponseBody
    public Object add(@Valid Industry industry) {
        return super.add(industry,industryService);

    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/industry/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Industry> list = new ArrayList<Industry>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Industry industry = new Industry();
                    industry.setId(Long.valueOf(str));
                    industry.setDeleteFlag(1);
                    list.add(industry);
                }
            }
            if(list.size()>0){
                boolean suc = industryService.updateBatchById(list);
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
@RequiresPermissions("/industry/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Industry> list = new ArrayList<Industry>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Industry industry = new Industry();
                    industry.setId(Long.valueOf(str));
                    industry.setDeleteFlag(0);
                    list.add(industry);
                }
            }
            if(list.size()>0){
                boolean suc = industryService.updateBatchById(list);
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
    @RequiresPermissions("/industry/edit")
    public String editPage(Model model, Long id) {
        Industry industry = industryService.selectById(id);
        model.addAttribute("industry", industry);
        model.addAttribute("method", "edit");
        return "industry/industryEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/industry/edit")
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
