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
import cn.dovahkiin.model.PriceLevel;
import cn.dovahkiin.service.IPriceLevelService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
@Controller
@RequestMapping("/priceLevel")
public class PriceLevelController extends BaseController {

    @Autowired private IPriceLevelService priceLevelService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/priceLevel/manager")
    public String manager() {
        return "priceLevel/priceLevelList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/priceLevel/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(PriceLevel priceLevel, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<PriceLevel> ew = new EntityWrapper<PriceLevel>();
        if(priceLevel!=null && StringUtils.hasText(priceLevel.getCode()))ew.like("code","%"+priceLevel.getCode().trim()+"%");
        if(priceLevel!=null && StringUtils.hasText(priceLevel.getName()) )ew.like("name","%"+priceLevel.getName().trim()+"%");
        if(priceLevel!=null && priceLevel.getDeleteFlag()!=null  ) ew.eq("delete_flag", priceLevel.getDeleteFlag() );
        Page<PriceLevel> pages = getPage(page, rows, sort, order);
        pages = priceLevelService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar"  },logical = Logical.OR)
    public Object combobox(){
        EntityWrapper ew = new EntityWrapper();
        ew.eq("delete_flag", 0 );
        return JSON.toJSON(priceLevelService.selectList(ew));
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/priceLevel/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            PriceLevel priceLevel = priceLevelService.selectById(id);
            if(priceLevel!=null){
                priceLevel.setId(null);
                model.addAttribute("priceLevel", priceLevel);
            }

        }
        return "priceLevel/priceLevelEdit";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/priceLevel/add")
    @ResponseBody
    public Object add(@Valid PriceLevel priceLevel) {
        if(priceLevel==null) return renderError("新增失败！");
        Long userId = getUserId();
        priceLevel.setUpdateBy(userId);
        priceLevel.setCreateBy(userId);
        return super.add(priceLevel,priceLevelService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/priceLevel/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<PriceLevel> list = new ArrayList<PriceLevel>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    PriceLevel priceLevel = new PriceLevel();
                    priceLevel.setId(Long.valueOf(str));
                    priceLevel.setDeleteFlag(1);
                    list.add(priceLevel);
                }
            }
            if(list.size()>0){
                boolean suc = priceLevelService.updateBatchById(list);
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
@RequiresPermissions("/priceLevel/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<PriceLevel> list = new ArrayList<PriceLevel>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    PriceLevel priceLevel = new PriceLevel();
                    priceLevel.setId(Long.valueOf(str));
                    priceLevel.setDeleteFlag(0);
                    list.add(priceLevel);
                }
            }
            if(list.size()>0){
                boolean suc = priceLevelService.updateBatchById(list);
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
    @RequiresPermissions("/priceLevel/edit")
    public String editPage(Model model, Long id) {
        PriceLevel priceLevel = priceLevelService.selectById(id);
        model.addAttribute("priceLevel", priceLevel);
        model.addAttribute("method", "edit");
        return "priceLevel/priceLevelEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/priceLevel/edit")
    @ResponseBody
    public Object edit(@Valid PriceLevel priceLevel) {
        if(priceLevel==null) return renderError("更新失败！");
        Long userId = getUserId();
        priceLevel.setUpdateBy(userId);
        priceLevel.setUpdateTime(new Date());
        boolean b = priceLevelService.updateById(priceLevel);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
