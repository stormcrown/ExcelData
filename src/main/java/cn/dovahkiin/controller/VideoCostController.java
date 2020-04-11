package cn.dovahkiin.controller;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import java.io.*;
import java.util.*;


import cn.dovahkiin.commons.shiro.ShiroUser;
import cn.dovahkiin.commons.utils.JsonUtils;
import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.model.*;
import cn.dovahkiin.service.*;
import cn.dovahkiin.util.Const;
import cn.dovahkiin.util.excel.CommonReadListenter;
import com.alibaba.excel.ExcelReader;
import com.alibaba.excel.support.ExcelTypeEnum;
import com.alibaba.fastjson.JSONObject;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.commons.base.BaseController;
import org.springframework.web.multipart.MultipartFile;

/**
 * <p>
 * 视频成片消耗 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-10-15
 */
@Controller
@RequestMapping("/videoCost")
public class VideoCostController extends BaseController {
    private IVideoCostService videoCostService;
    private ICustomerService customerService;
    private IOrganizationService iOrganizationService;
    private IOptimizerService iOptimizerService;
    @Autowired
    public void setVideoCostService(IVideoCostService videoCostService) {
        this.videoCostService = videoCostService;
    }
    @Autowired
    public void setCustomerService(ICustomerService customerService) {
        this.customerService = customerService;
    }
    @Autowired
    public void setiOrganizationService(IOrganizationService iOrganizationService) {
        this.iOrganizationService = iOrganizationService;
    }
    @Autowired
    public void setiOptimizerService(IOptimizerService iOptimizerService) {
        this.iOptimizerService = iOptimizerService;
    }

    @GetMapping("/manager")
    @RequiresPermissions("/videoCost/manager")
    public String manager(Model model) {
        double max = videoCostService.selectMaxConsumption(getShiroUser());
        if(max==0)max = 100;
        model.addAttribute("MaxConsumption",max);
        return "videoCost/videoCostList";
    }

    private Map handle(VideoCost videoCost,Integer page,Integer rows,String sort,String order ,
                       String  ConsumptionRange, String KeyWord, String recoredDateRange, String completeDateRange,String keyWordType,Double consumption_min,Double consumption_max){
        Map map = new HashMap(10);
        ShiroUser user = getShiroUser();
        Set<String> roles = user.getRoles();

        if(!roles.contains(Const.Administor_Role_Name)  && !roles.contains(Const.optimizerAdministorCN)  )map.put("userId",user.getId());
        if(roles.contains(Const.optimizerCN) && !roles.contains(Const.optimizerAdministorCN)  && !roles.contains(Const.Administor_Role_Name)  )map.put(Const.optimizerStr,user.getName());
        if(user.getSupplier()!=null){
            if(videoCost==null)videoCost = new VideoCost();
            if(videoCost.getCustomer()==null)videoCost.setCustomer(new Customer());
            videoCost.getCustomer().setSupplier(user.getSupplier());
        }
        if(StringUtils.hasText(keyWordType)){
            String[] keyTypes = keyWordType.split(",");
            for(String str :keyTypes){
               if(StringUtils.hasText(str)) map.put(str,str);
            }
        }else{
            map.put("all","all");
        }
        map.put("order",order );
        map.put("sort",sort);
        map.put("consumption_min",consumption_min);
        map.put("consumption_max",consumption_max);
        if(recoredDateRange!=null && recoredDateRange.indexOf("~")>0){
            String[] da = recoredDateRange.split("~");
            if(da!=null && da.length==2 && da[0]!=null && da[1] !=null ){
                Date date1 = dateConverter.convert(da[0].replaceAll(" ",""));
                Date date2 = dateConverter.convert(da[1].replaceAll(" ",""));
                map.put("recoredDate_start",date1);
                map.put("recoredDate_end",date2);
            }
        }
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
        map.put(Const.videoCostStr,videoCost);
        return map;
    }
    @PostMapping("/dataGrid")
    @ResponseBody
    @RequiresPermissions("/videoCost/dataGrid")
    public PageInfo dataGrid(VideoCost videoCost,@NotNull Integer page,@NotNull Integer rows,@NotNull String sort,@NotNull String order ,
                             String  ConsumptionRange, String KeyWord, String recoredDateRange, String completeDateRange,String keyWordType,Double consumption_min,Double consumption_max
    ) {
        Map map = handle(videoCost,page,rows,sort,order ,ConsumptionRange,KeyWord,recoredDateRange,completeDateRange,keyWordType,consumption_min,consumption_max);
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Page<VideoCost> pages = getPage(page, rows, sort, order);
        map.put("offset",pages.getOffset());
        map.put("limit",pages.getLimit());

        pages= videoCostService.selectWithCount(pages,map);
        JSONObject jsonObject = new JSONObject();
        jsonObject.putAll(videoCostService.selectDataForListPage(map));
        pageInfo.setOtherMsg(jsonObject);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }

    private Model modelForEdit(Model model) {
        EntityWrapper un_delete = new EntityWrapper();
        List<Organization> organizations = iOrganizationService.selectList(un_delete);
        model.addAttribute("organizations", organizations);
        un_delete.eq("delete_flag", 0);
        List<Customer> customers = customerService.selectUnDeleted(getShiroUser().getSupplier());
        model.addAttribute("customers", customers);
        List<Optimizer> optimizers = iOptimizerService.selectList(un_delete);
        model.addAttribute("optimizers", JsonUtils.toJson(optimizers));
        return model;
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/videoCost/add")
    public String addPage(Model model,Long id ) {
        if(id!=null){
            VideoCost videoCost = videoCostService.selectByPrimaryKey(id);
            if(videoCost!=null)videoCost.setId(null);
            model.addAttribute("videoCost", videoCost);
        }
        model.addAttribute("method", "add");
        modelForEdit(model);
        return "videoCost/videoCost";
    }
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/videoCost/edit")
    public String editPage(Model model, Long id) {
        VideoCost videoCost = videoCostService.selectByPrimaryKey(id);
        model.addAttribute("videoCost", videoCost);
        model.addAttribute("method", "edit");
        modelForEdit(model);
        return "videoCost/videoCost";
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/importExcelPage")
    @RequiresPermissions("/videoCost/importExcel")
    public String importExcelPage(Model model) {
        ShiroUser userVo = getShiroUser();
        if(userVo.getSupplier()!=null) model.addAttribute(Const.supplierName,userVo.getSupplier().getName());
        return "videoCost/videoCostImportExcel";
    }
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    @RequiresPermissions("/videoCost/add")
    public Object add(@Valid VideoCost videoCost) {
        videoCost.setCreateTime(new Date());
        videoCost.setUpdateTime(new Date());
        videoCost.setDeleteFlag(0);
        videoCost.setCreatedBy(getUserId());
        videoCost.setUpdatedBy(getUserId());
        List<VideoCost> videoCosts = new ArrayList<>();
        videoCosts.add(videoCost);
        int b = videoCostService.insertMany(videoCosts);
        if (b==1) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    @GetMapping("/countByDay")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/add","/videoCost/importExcel" } ,logical = Logical.OR)
    public Object countByDay(Date recoredDate,Long customerId) {
        return videoCostService.selectCount(recoredDate,customerId,getShiroUser());
    }
    /**
     * 添加
     * @param
     * @return
     */
    @PostMapping("/importExcel")
    @ResponseBody
    @RequiresPermissions("/videoCost/importExcel")
    public Object importExcel(Date recoredDate, @RequestParam(name="excels") MultipartFile excels) {
        ShiroUser shiroUser = getShiroUser();
        if(!importOnce(shiroUser) )throw new RuntimeException("你今天已经导入过一次了！");
        int m=0;
        boolean b = true;
        try {
            InputStream inputStream = excels.getInputStream();
            CommonReadListenter listenter = new CommonReadListenter();
            ExcelReader reader = new ExcelReader(inputStream, ExcelTypeEnum.XLSX, listenter, true);
            reader.read();
            List<ArrayList<Object>> list = listenter.data;
            m = videoCostService.handleExcelFile(list,recoredDate, getShiroUser());
            if(m==0)reduceOnce(shiroUser);
        }catch (IOException e){
            e.printStackTrace();
            b= false;
            reduceOnce(shiroUser);
        }catch (RuntimeException e){
            reduceOnce(shiroUser);
            throw e;
        }
        if (b ) {
            return renderSuccess("添加成功！"+m+"行数据被导入");
        } else {
            return renderError("添加失败！");
        }
    }
    /**
     * 添加
     * @param
     * @return
     */
    @PostMapping("/exportExcel")
    @ResponseBody
    @RequiresPermissions("/videoCost/exportExcel")
    public Object exportExcel(VideoCost videoCost,@NotNull Integer page,@NotNull Integer rows,@NotNull String sort,@NotNull String order ,
                              String  ConsumptionRange, String KeyWord, String recoredDateRange, String completeDateRange,HttpServletResponse response,String keyWordType,Double consumption_min,Double consumption_max) {
        Map map = handle(videoCost,page,rows,sort,order ,ConsumptionRange,KeyWord,recoredDateRange,completeDateRange,keyWordType,consumption_min,consumption_max);
        map.put("offset",0);
        map.put("limit",100000);
        try {
            response.setContentType("application/x-msdownload;");
            response.setHeader("Content-disposition", "attachment; filename=" + new String(("市场部视频数据统计表"+StringUtils.getDateCode()+".xlsx").getBytes("utf-8"), "ISO8859-1"));
//            response.setHeader("Content-Length", String.valueOf(10000));
            OutputStream outputStream = response.getOutputStream();
            Workbook workbook= new XSSFWorkbook();
            videoCostService.exportData(map,workbook);
            workbook.write(outputStream);
            outputStream.flush();
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return renderSuccess();
    }
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    @RequiresPermissions("/videoCost/delete")
    public Object delete(String ids) {
        if(ids!=null){
            String[] strings = ids.split(",");
            List<String> idss = new ArrayList<>();
            for(String str:strings){
                if(StringUtils.hasText(str) &&StringUtils.isInteger(str) )idss.add(str);
            }
           int suc= videoCostService.deleteMany(idss.toArray(new String[idss.size()]));
           if(suc>0)return renderSuccess("删除成功！");
        }
         return renderError("删除失败！");

    }
    @PostMapping("/deleteForever")
    @ResponseBody
    @RequiresPermissions("/videoCost/delete")
    @RequiresRoles(Const.Administor_Role_Name )
    public Object deleteForever(String ids){
        if(ids!=null){
            String[] strings = ids.split(",");
            List<String> idss = new ArrayList<>();
            for(String str:strings){
                if(StringUtils.hasText(str) &&StringUtils.isInteger(str) )idss.add(str);
            }
            int suc= videoCostService.deleteManyForever(idss.toArray(new String[idss.size()]));

            if(suc>0)return renderSuccess("删除成功！");
        }
        return renderError("删除失败！");
    }
    

    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    @RequiresPermissions("/videoCost/edit")
    public Object edit(@Valid VideoCost videoCost) {
        videoCost.setUpdateTime(new Date());
        videoCost.setUpdatedBy(getUserId());
        int b = videoCostService.updateByPrimaryKey(videoCost);
        if (b==1) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
