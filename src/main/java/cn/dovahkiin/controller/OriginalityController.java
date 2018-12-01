package cn.dovahkiin.controller;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.model.TrueCustomer;
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
import cn.dovahkiin.model.Originality;
import cn.dovahkiin.service.IOriginalityService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 创意师信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-19
 */
@Controller
@RequestMapping("/originality")
public class OriginalityController extends BaseController {

    @Autowired private IOriginalityService originalityService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/originality/manager")
    public String manager() {
        return "originality/originalityList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/originality/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Originality originality, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Originality> ew = new EntityWrapper<Originality>();
        if(originality!=null && StringUtils.hasText(originality.getCode()))ew.like("code","%"+originality.getCode().trim()+"%");
        if(originality!=null && StringUtils.hasText(originality.getName()) )ew.like("name","%"+originality.getName().trim()+"%");
        if(originality!=null && originality.getDeleteFlag()!=null  ) ew.eq("delete_flag", originality.getDeleteFlag() );
        Page<Originality> pages = getPage(page, rows, sort, order);
        pages = originalityService.selectPage(pages, ew);
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
        return JSON.toJSON(originalityService.selectList(ew));
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/originality/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            Originality originality = originalityService.selectById(id);
            if(originality!=null){
                originality.setId(null);
                model.addAttribute("originality", originality);
            }

        }
        return "originality/originalityEdit";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/originality/add")
    @ResponseBody
    public Object add(@Valid Originality originality) {
        return super.add(originality,originalityService);

    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/originality/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Originality> list = new ArrayList<Originality>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Originality originality = new Originality();
                    originality.setId(Long.valueOf(str));
                    originality.setDeleteFlag(1);
                    list.add(originality);
                }
            }
            if(list.size()>0){
                boolean suc = originalityService.updateBatchById(list);
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
@RequiresPermissions("/originality/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Originality> list = new ArrayList<Originality>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Originality originality = new Originality();
                    originality.setId(Long.valueOf(str));
                    originality.setDeleteFlag(0);
                    list.add(originality);
                }
            }
            if(list.size()>0){
                boolean suc = originalityService.updateBatchById(list);
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
    @RequiresPermissions("/originality/edit")
    public String editPage(Model model, Long id) {
        Originality originality = originalityService.selectById(id);
        model.addAttribute("originality", originality);
        model.addAttribute("method", "edit");
        return "originality/originalityEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/originality/edit")
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
