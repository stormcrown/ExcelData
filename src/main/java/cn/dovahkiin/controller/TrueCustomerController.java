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
import cn.dovahkiin.model.TrueCustomer;
import cn.dovahkiin.service.ITrueCustomerService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 客户信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-29
 */
@Controller
@RequestMapping("/trueCustomer")
public class TrueCustomerController extends BaseController {

    @Autowired private ITrueCustomerService trueCustomerService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/trueCustomer/manager")
    public String manager() {
        return "trueCustomer/trueCustomerList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/trueCustomer/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(TrueCustomer trueCustomer, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<TrueCustomer> ew = new EntityWrapper<TrueCustomer>();
        if(trueCustomer!=null && StringUtils.hasText(trueCustomer.getCode()))ew.like("code","%"+trueCustomer.getCode().trim()+"%");
        if(trueCustomer!=null && StringUtils.hasText(trueCustomer.getName()) )ew.like("name","%"+trueCustomer.getName().trim()+"%");
        if(trueCustomer!=null && trueCustomer.getDeleteFlag()!=null  ) ew.eq("delete_flag", trueCustomer.getDeleteFlag() );
        Page<TrueCustomer> pages = getPage(page, rows, sort, order);
        pages = trueCustomerService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/dataGrid" },logical = Logical.OR)
    public Object dataGrid() {
        EntityWrapper<TrueCustomer> ew = new EntityWrapper<TrueCustomer>();
        ew.eq("delete_flag", 0 );
        return JSON.toJSON(trueCustomerService.selectList(ew));
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/trueCustomer/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            TrueCustomer trueCustomer = trueCustomerService.selectById(id);
            if(trueCustomer!=null){
                trueCustomer.setId(null);
                model.addAttribute("trueCustomer", trueCustomer);
            }

        }
        return "trueCustomer/trueCustomer";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/trueCustomer/add")
    @ResponseBody
    public Object add(@Valid TrueCustomer trueCustomer) {
        return super.add(trueCustomer,trueCustomerService);

    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/trueCustomer/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<TrueCustomer> list = new ArrayList<TrueCustomer>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    TrueCustomer trueCustomer = new TrueCustomer();
                    trueCustomer.setId(Long.valueOf(str));
                    trueCustomer.setDeleteFlag(1);
                    list.add(trueCustomer);
                }
            }
            if(list.size()>0){
                boolean suc = trueCustomerService.updateBatchById(list);
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
@RequiresPermissions("/trueCustomer/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<TrueCustomer> list = new ArrayList<TrueCustomer>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    TrueCustomer trueCustomer = new TrueCustomer();
                    trueCustomer.setId(Long.valueOf(str));
                    trueCustomer.setDeleteFlag(0);
                    list.add(trueCustomer);
                }
            }
            if(list.size()>0){
                boolean suc = trueCustomerService.updateBatchById(list);
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
    @RequiresPermissions("/trueCustomer/edit")
    public String editPage(Model model, Long id) {
        TrueCustomer trueCustomer = trueCustomerService.selectById(id);
        model.addAttribute("trueCustomer", trueCustomer);
        model.addAttribute("method", "edit");
        return "trueCustomer/trueCustomer";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/trueCustomer/edit")
    @ResponseBody
    public Object edit(@Valid TrueCustomer trueCustomer) {
        trueCustomer.setUpdateTime(new Date());
        boolean b = trueCustomerService.updateById(trueCustomer);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
