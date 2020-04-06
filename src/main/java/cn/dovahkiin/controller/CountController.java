package cn.dovahkiin.controller;

import cn.dovahkiin.commons.base.BaseController;
import cn.dovahkiin.commons.shiro.ShiroUser;
import cn.dovahkiin.commons.utils.DateTools;
import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.model.Customer;
import cn.dovahkiin.model.VideoCost;
import cn.dovahkiin.model.dto.EffectCountDto;
import cn.dovahkiin.model.dto.ModelCountDto;
import cn.dovahkiin.service.ICountService;
import cn.dovahkiin.util.Const;
import com.alibaba.fastjson.JSON;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/**
 * @author 骆长涛
 * @DateTime 2018/12/1 10:25
 * @description
 */

@Controller
@RequestMapping("/count")
public class CountController extends BaseController {
    public static final Log logger = LogFactory.getLog(CountController.class);
    private ICountService countService;

    @Autowired
    public void setCountService(ICountService countService) {
        this.countService = countService;
    }

    @GetMapping("/bar")
    @RequiresPermissions("/count/bar")
    public String manager() {
        return "count/bar";
    }
    @GetMapping("/effConCount")
    @RequiresPermissions("/count/effConCount")
    public String managerEffConCount() {
        return "count/effConCount";
    }
    private Map<String,Object> handleCondition(String recoredDateRange ,Integer type, VideoCost videoCost,String[] supplierIds){
        Map<String,Object> map = new HashMap<>();
        ShiroUser user = getShiroUser();
        Set<String> roles = user.getRoles();
         if(!roles.contains(Const.Administor_Role_Name)  && !roles.contains(Const.optimizerAdministorCN)  )map.put("userId",user.getId());
        if(roles.contains(Const.optimizerCN) && !roles.contains(Const.optimizerAdministorCN)  && !roles.contains(Const.Administor_Role_Name)  )map.put(Const.optimizerStr,user.getName());

        if(recoredDateRange!=null && recoredDateRange.indexOf("~")>0){
            String[] da = recoredDateRange.split("~");
            if(da.length==2 && da[0]!=null && da[1] !=null ){
                Date date1 = dateConverter.convert(da[0].replaceAll(" ",""));
                Date date2 = dateConverter.convert(da[1].replaceAll(" ",""));
                if(type!=null &&  type==1){
                    map.put(Const.RECORED_DATE_START, DateTools.firstDayD(date1));
                    map.put(Const.RECORED_DATE_END,DateTools.lastDateD(date2));
                }else{
                    map.put(Const.RECORED_DATE_START,date1);
                    map.put(Const.RECORED_DATE_END,date2);
                }

//                map.put("recoredDates",DateTools.getBetweenDates(date1,date2));
            }
        }else{
            map.put(Const.RECORED_DATE_START,DateTools.firstDay());
            map.put(Const.RECORED_DATE_END,DateTools.lastDate());
//            map.put("recoredDates",DateTools.getBetweenDates(DateTools.firstDay(),DateTools.lastDate()));
        }
        map.put("type",type==null?0:type);

        if(user.getSupplier()!=null){
            if(videoCost==null)videoCost=new VideoCost();
            if(videoCost.getCustomer()==null)videoCost.setCustomer(new Customer());
            videoCost.getCustomer().setSupplier(user.getSupplier());
        }
        map.put("videoCost",videoCost);
        if(supplierIds!=null && supplierIds.length>0) {
            List<Long> ids = new ArrayList<>();
            for(int i =0;i<supplierIds.length;i++){
                if(StringUtils.isNotBlank(supplierIds[i])&& StringUtils.isInteger(supplierIds[i]))ids.add(Long.parseLong(supplierIds[i]));
            }
            if(ids.size()>0) map.put("supplierIds",ids);
        }

        return map;
    }
    @PostMapping("/bar")
    @RequiresPermissions("/count/bar")
    @ResponseBody
    public Object count1(String recoredDateRange, Integer type , VideoCost videoCost ,String[] supplierIds) {
        Map map = handleCondition(recoredDateRange,type,videoCost,supplierIds);
        return countService.count1(map);
    }

    @PostMapping("/countByModel")
    @RequiresPermissions("/count/bar")
    @ResponseBody
    public Object countByModel(String recoredDateRange, Integer type , VideoCost videoCost,Boolean countZero,String model,String[] supplierIds) {
        Map map = handleCondition(recoredDateRange,type,videoCost,supplierIds);
        map.put("countZero",countZero);
        map.put("model",model);
        return countService.countByModel(map);
    }
    @PostMapping("/exportCountByModel")
    @RequiresPermissions("/count/bar")
    @ResponseBody
    public Object exportCountByModel(HttpServletResponse response,String recoredDateRange, Integer type , VideoCost videoCost, Boolean countZero,String model, String[] supplierIds ,String sort,String order) throws IOException {
        Map map = handleCondition(recoredDateRange,type,videoCost,supplierIds);
        map.put("countZero",countZero);
        map.put("model",model);
        response.setContentType("application/x-msdownload;");
        response.setHeader("Content-disposition", "attachment; filename=" + new String(("分组统计"+ StringUtils.getDateCode()+".xlsx").getBytes("utf-8"), "ISO8859-1"));
        List<ModelCountDto> datas=countService.countByModel(map);
        OutputStream outputStream = response.getOutputStream();
        Workbook workbook= countService.handleModelCountToExcel(datas,sort,order);
        workbook.write(outputStream);
        outputStream.flush();
        outputStream.close();
        return renderSuccess();
    }

    @GetMapping("/checkCustomConfigs")
    @RequiresPermissions("/count/effConCount")
    @ResponseBody
    public Object checkCustomConfigs(){
        return countService.checkCusConfig();
    }

    @PostMapping("/effTimeCount")
    @RequiresPermissions("/count/effConCount")
    @ResponseBody
    public Object effTimeCount(String recoredDateRange, Integer type , VideoCost videoCost,Boolean countZero,String[] supplierIds) {
        Map<String,Object> map = handleCondition(recoredDateRange,type,videoCost,supplierIds);
        map.put("countZero",countZero);
        return countService.countEffConTimeCut(map);
    }
    @PostMapping("/exportEffTimeCount")
    @RequiresPermissions("/count/effConCount")
    @ResponseBody
    public Object exportEffTimeCount(HttpServletResponse response,String recoredDateRange, Integer type , VideoCost videoCost, Boolean countZero, String[] supplierIds ,String sort,String order) throws IOException {
        Map<String,Object> map = handleCondition(recoredDateRange,type,videoCost,supplierIds);
        map.put("countZero",countZero);
        response.setContentType("application/x-msdownload;");
        response.setHeader("Content-disposition", "attachment; filename=" + new String(("收入支出统计"+ StringUtils.getDateCode()+".xlsx").getBytes("utf-8"), "ISO8859-1"));
        EffectCountDto effectCountDto =countService.countEffConTimeCut(map) ;
        OutputStream outputStream = response.getOutputStream();
        Workbook workbook= countService.handleEffConTimeToExcel(effectCountDto,sort,order);
        workbook.write(outputStream);
        outputStream.flush();
        outputStream.close();
        return renderSuccess();
    }


}
