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
import cn.dovahkiin.model.Optimizer;
import cn.dovahkiin.service.IOptimizerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 优化师信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-19
 */
@Controller
@RequestMapping("/optimizer")
public class OptimizerController extends BaseController {

    @Autowired private IOptimizerService optimizerService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/optimizer/manager")
    public String manager() {
        return "optimizer/optimizerList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/optimizer/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Optimizer optimizer, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Optimizer> ew = new EntityWrapper<Optimizer>();
        if(optimizer!=null && StringUtils.hasText(optimizer.getCode()))ew.like("code","%"+optimizer.getCode().trim()+"%");
        if(optimizer!=null && StringUtils.hasText(optimizer.getName()) )ew.like("name","%"+optimizer.getName().trim()+"%");
        if(optimizer!=null && optimizer.getDeleteFlag()!=null  ) ew.eq("delete_flag", optimizer.getDeleteFlag() );
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
    @RequiresPermissions("/optimizer/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            Optimizer optimizer = optimizerService.selectById(id);
            if(optimizer!=null){
                optimizer.setId(null);
                model.addAttribute("optimizer", optimizer);
            }

        }
        return "optimizer/optimizerEdit";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/optimizer/add")
    @ResponseBody
    public Object add(@Valid Optimizer optimizer) {
        return super.add(optimizer,optimizerService);

    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/optimizer/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Optimizer> list = new ArrayList<Optimizer>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Optimizer optimizer = new Optimizer();
                    optimizer.setId(Long.valueOf(str));
                    optimizer.setDeleteFlag(1);
                    list.add(optimizer);
                }
            }
            if(list.size()>0){
                boolean suc = optimizerService.updateBatchById(list);
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
@RequiresPermissions("/optimizer/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Optimizer> list = new ArrayList<Optimizer>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Optimizer optimizer = new Optimizer();
                    optimizer.setId(Long.valueOf(str));
                    optimizer.setDeleteFlag(0);
                    list.add(optimizer);
                }
            }
            if(list.size()>0){
                boolean suc = optimizerService.updateBatchById(list);
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
    @RequiresPermissions("/optimizer/edit")
    public String editPage(Model model, Long id) {
        Optimizer optimizer = optimizerService.selectById(id);
        model.addAttribute("optimizer", optimizer);
        model.addAttribute("method", "edit");
        return "optimizer/optimizerEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/optimizer/edit")
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
