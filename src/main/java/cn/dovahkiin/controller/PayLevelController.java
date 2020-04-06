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
import cn.dovahkiin.model.PayLevel;
import cn.dovahkiin.service.IPayLevelService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-03-27
 */
@Controller
@RequestMapping("/payLevel")
public class PayLevelController extends BaseController {
    private IPayLevelService payLevelService;
    @Autowired
    public void setPayLevelService(IPayLevelService payLevelService) {
        this.payLevelService = payLevelService;
    }

    @GetMapping("/manager")
    @RequiresPermissions("/payLevel/manager")
    public String manager() {
        return "payLevel/payLevelList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/payLevel/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(PayLevel payLevel, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<PayLevel> ew = new EntityWrapper<PayLevel>();
        if(payLevel!=null && StringUtils.hasText(payLevel.getCode()))ew.like("code","%"+payLevel.getCode().trim()+"%");
        if(payLevel!=null && StringUtils.hasText(payLevel.getName()) )ew.like("name","%"+payLevel.getName().trim()+"%");
        if(payLevel!=null && payLevel.getDeleteFlag()!=null  ) ew.eq("delete_flag", payLevel.getDeleteFlag() );
        Page<PayLevel> pages = getPage(page, rows, sort, order);
        pages = payLevelService.selectPage(pages, ew);
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
        return JSON.toJSON(payLevelService.selectList(ew));
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/payLevel/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            PayLevel payLevel = payLevelService.selectById(id);
            if(payLevel!=null){
                payLevel.setId(null);
                model.addAttribute("payLevel", payLevel);
            }

        }
        return "payLevel/payLevelEdit";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/payLevel/add")
    @ResponseBody
    public Object add(@Valid PayLevel payLevel) {
        if(payLevel==null)return renderError("数据为空");
        payLevel.setUpdateBy(getUserId());
        payLevel.setCreateBy(getUserId());
        return super.add(payLevel,payLevelService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/payLevel/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<PayLevel> list = new ArrayList<PayLevel>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    PayLevel payLevel = new PayLevel();
                    payLevel.setId(Long.valueOf(str));
                    payLevel.setDeleteFlag(1);
                    list.add(payLevel);
                }
            }
            if(list.size()>0){
                boolean suc = payLevelService.updateBatchById(list);
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
@RequiresPermissions("/payLevel/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<PayLevel> list = new ArrayList<PayLevel>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    PayLevel payLevel = new PayLevel();
                    payLevel.setId(Long.valueOf(str));
                    payLevel.setDeleteFlag(0);
                    list.add(payLevel);
                }
            }
            if(list.size()>0){
                boolean suc = payLevelService.updateBatchById(list);
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
    @RequiresPermissions("/payLevel/edit")
    public String editPage(Model model, Long id) {
        PayLevel payLevel = payLevelService.selectById(id);
        model.addAttribute("payLevel", payLevel);
        model.addAttribute("method", "edit");
        return "payLevel/payLevelEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/payLevel/edit")
    @ResponseBody
    public Object edit(@Valid PayLevel payLevel) {
        payLevel.setUpdateTime(new Date());
        payLevel.setUpdateBy(getUserId());
        int b = payLevelService.updateByPrimaryKey(payLevel);
        if (b==1) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
