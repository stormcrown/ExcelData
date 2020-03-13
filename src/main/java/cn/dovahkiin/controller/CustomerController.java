package cn.dovahkiin.controller;

import javax.validation.Valid;
import java.util.*;

import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.model.VideoCost;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
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
import cn.dovahkiin.model.Customer;
import cn.dovahkiin.service.ICustomerService;
import cn.dovahkiin.commons.base.BaseController;

import static cn.dovahkiin.util.Const.customerStr;

/**
 * <p>
 * 客户信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-19
 */
@Controller
@RequestMapping("/customer")
public class CustomerController extends BaseController {

    @Autowired private ICustomerService customerService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/customer/manager")
    public String manager() {
        return "customer/customerList";
    }


    private Map handle(Customer customer, Integer page, Integer rows, String sort, String order ,
                        String KeyWord, String completeDateRange){
        Map map = new HashMap(10);
//        if(ConsumptionRange!=null && ConsumptionRange.indexOf(",")>0){
//            String [] cuns = ConsumptionRange.split(",");
//            if(Double.parseDouble(cuns[0])!=0.0) map.put("consumption_min",Double.parseDouble(cuns[0]));
//            map.put("consumption_max",Double.parseDouble(cuns[1]));
//        }
        map.put(customerStr,customer);
        map.put("order",order );
        map.put("sort",sort);

        if(completeDateRange!=null && completeDateRange.indexOf("~")>0){
            String[] da = completeDateRange.split("~");
            if(da!=null && da.length==2 && da[0]!=null && da[1] !=null ){
                Date date1 = dateConverter.convert(da[0].replaceAll(" ",""));
                Date date2 = dateConverter.convert(da[1].replaceAll(" ",""));
                map.put("completeDate_start",date1);
                map.put("completeDate_end",date2);
            }
        }
        if( KeyWord!=null &&  StringUtils.hasText(KeyWord)){
            String[] words = KeyWord.trim().split(",");
            for(int i=0;i<words.length;i++){
                if(StringUtils.isNotBlank(words[i]))words[i] = "%"+words[i].replaceAll(" ","")+"%";
            }
            if(words!=null && words.length>0)map.put("KeyWord",words );
        }
        return map;
    }
    @PostMapping("/dataGrid")
    @RequiresPermissions(value = {"/customer/dataGrid" },logical = Logical.OR)
    @ResponseBody
    public PageInfo dataGrid(Customer customer, Integer page, Integer rows, String sort,String order, String KeyWord, String completeDateRange) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Customer> ew = new EntityWrapper<Customer>();
        if(customer!=null && StringUtils.hasText(customer.getCode()))ew.like("code","%"+customer.getCode().trim()+"%");
        if(customer!=null && StringUtils.hasText(customer.getName()) )ew.like("name","%"+customer.getName().trim()+"%");
        if(customer!=null && customer.getDeleteFlag()!=null  ) ew.eq("delete_flag", customer.getDeleteFlag() );
        Page<Customer> pages = getPage(page, rows, sort, order);
        Map map = handle(customer,page,rows,sort,order,KeyWord,completeDateRange);
        map.put("offset",pages.getOffset());
        map.put("limit",pages.getLimit());

        pages = customerService.selectPage(pages, map);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object dataGrid() {
        return JSON.toJSON(customerService.selectForCombobox());
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/customer/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
//        customerService.modelForEdit(model);
        if(id!=null){
            Customer customer = customerService.selectByPrimaryKey(id);
            if(customer!=null){
                customer.setId(null);
                model.addAttribute("customer", customer);
            }
        }
        return "customer/customerEdit";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/customer/add")
    @ResponseBody
    public Object add(@Valid Customer customer) {
        customer.setDeleteFlag(0);
        customer.setCreateTime(new Date());
        customer.setUpdateTime(new Date());
        int suc = customerService.insert(customer);
        if(suc==1)return renderSuccess();
        return renderError("新增失败");

    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/customer/delete")
    @ResponseBody
    public Object delete(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<String> list = new ArrayList();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                   list.add(str);
                }
            }
            if(list.size()>0){
                int suc = customerService.deleteMany(list);
                if(suc>0)return renderSuccess("删除成功！");
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
@RequiresPermissions("/customer/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<String> list = new ArrayList<>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    list.add(str);
                }
            }
            if(list.size()>0){
                int suc = customerService.rollBack(list);
                if(suc>0)return renderSuccess("恢复成功！");
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
    @RequiresPermissions("/customer/edit")
    public String editPage(Model model, Long id) {
        Customer customer = customerService.selectByPrimaryKey(id);
        model.addAttribute("customer", customer);
        model.addAttribute("method", "edit");
//        customerService.modelForEdit(model);
        return "customer/customerEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/customer/edit")
    @ResponseBody
    public Object edit(@Valid Customer customer) {
        customer.setUpdateTime(new Date());
        int b = customerService.updateByPrimaryKey(customer);
        if (b>0) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
    @GetMapping("/checkCodeVersion")
    @RequiresPermissions(value = {"/customer/edit","/customer/add" },logical = Logical.OR)
    @ResponseBody
    public Object checkCodeVersion(String code ,Long versionId,Long selfId) {
        int b = customerService.countFrCheckCodeVersion(code,versionId,selfId);
        if (b>0) {
            return renderError(b+"");
        } else {
            return renderSuccess();
        }
    }
}
