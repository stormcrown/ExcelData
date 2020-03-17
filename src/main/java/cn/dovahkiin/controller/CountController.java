package cn.dovahkiin.controller;

import cn.dovahkiin.commons.base.BaseController;
import cn.dovahkiin.commons.shiro.ShiroUser;
import cn.dovahkiin.commons.utils.DateTools;
import cn.dovahkiin.model.Customer;
import cn.dovahkiin.model.VideoCost;
import cn.dovahkiin.service.ICountService;
import cn.dovahkiin.util.Const;
import com.alibaba.fastjson.JSON;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
    public static final String dateStart ="recoredDate_start";
    public static final String dateEnd ="recoredDate_end";
    @Autowired
    public void setCountService(ICountService countService) {
        this.countService = countService;
    }

    @GetMapping("/bar")
    @RequiresPermissions("/count/bar")
    public String manager() {
        return "count/bar";
    }
    @GetMapping("/eff")
    @RequiresPermissions("/count/eff")
    public String manager2() {
        return "count/effect_con";
    }
    private Map<String,Object> handleCondition(String recoredDateRange ,Integer type, VideoCost videoCost){
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
                    map.put(dateStart, DateTools.firstDayD(date1));
                    map.put(dateEnd,DateTools.lastDateD(date2));
                }else{
                    map.put(dateStart,date1);
                    map.put(dateEnd,date2);
                }

//                map.put("recoredDates",DateTools.getBetweenDates(date1,date2));
            }
        }else{
            map.put(dateStart,DateTools.firstDay());
            map.put(dateEnd,DateTools.lastDate());
//            map.put("recoredDates",DateTools.getBetweenDates(DateTools.firstDay(),DateTools.lastDate()));
        }
        map.put("type",type==null?0:type);

        if(user.getSupplier()!=null){
            if(videoCost==null)videoCost=new VideoCost();
            if(videoCost.getCustomer()==null)videoCost.setCustomer(new Customer());
            videoCost.getCustomer().setSupplier(user.getSupplier());
        }
        map.put("videoCost",videoCost);

        return map;
    }
    @PostMapping("/bar")
    @RequiresPermissions("/count/bar")
    @ResponseBody
    public Object count1(String recoredDateRange, Integer type , VideoCost videoCost) {
        Map map = handleCondition(recoredDateRange,type,videoCost);
        return JSON.toJSON(countService.count1(map));
    }
    @PostMapping("/countByOptimizer")
    @RequiresPermissions("/count/bar")
    @ResponseBody
    public Object line(String recoredDateRange, Integer type , VideoCost videoCost,Boolean countZero) {
        Map map = handleCondition(recoredDateRange,type,videoCost);
        map.put("countZero",countZero);
        return JSON.toJSON(countService.countByOptimizer(map));
    }
    @PostMapping("/countByTrueCustomer")
    @RequiresPermissions("/count/bar")
    @ResponseBody
    public Object countByCustomer(String recoredDateRange, Integer type , VideoCost videoCost,Boolean countZero) {
        Map map = handleCondition(recoredDateRange,type,videoCost);
        map.put("countZero",countZero);
        return JSON.toJSON(countService.countByCustomer(map));
    }

    @PostMapping("/effBar")
    @RequiresPermissions("/count/eff")
    @ResponseBody
    public Object effCount(String recoredDateRange, Integer type ,Integer effectDays,Double maxEffectCon, VideoCost videoCost) {
        Map<String,Object> map = handleCondition(recoredDateRange,type,videoCost);
        map.put("effectDays",effectDays);
        map.put("maxEffectCon",maxEffectCon);
        return JSON.toJSON(5);
    }

}
