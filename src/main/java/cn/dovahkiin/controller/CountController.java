package cn.dovahkiin.controller;

import cn.dovahkiin.commons.base.BaseController;
import cn.dovahkiin.commons.utils.DateTools;
import cn.dovahkiin.service.ICountService;
import com.alibaba.fastjson.JSON;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.aspectj.lang.annotation.AfterReturning;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author 骆长涛
 * @DateTime 2018/12/1 10:25
 * @description
 */

@Controller
@RequestMapping("/count")
public class CountController extends BaseController {
    public static final Log logger = LogFactory.getLog(CountController.class);
    @Autowired private ICountService countService;
    @GetMapping("/manager")
    @RequiresPermissions("/count/manager")
    public String manager() {
        return "/count/manager";
    }
    private Map handleCondition(String recoredDateRange ,Integer type){
        Map map = new HashMap();
        if(recoredDateRange!=null && recoredDateRange.indexOf("~")>0){
            String[] da = recoredDateRange.split("~");
            if(da!=null && da.length==2 && da[0]!=null && da[1] !=null ){
                Date date1 = dateConverter.convert(da[0].replaceAll(" ",""));
                Date date2 = dateConverter.convert(da[1].replaceAll(" ",""));
                if(type==1){
                    map.put("recoredDate_start", DateTools.firstDayD(date1));
                    map.put("recoredDate_end",DateTools.lastDateD(date2));
                }else{
                    map.put("recoredDate_start",date1);
                    map.put("recoredDate_end",date2);
                }

//                map.put("recoredDates",DateTools.getBetweenDates(date1,date2));
            }
        }else{
            map.put("recoredDate_start",DateTools.firstDay());
            map.put("recoredDate_end",DateTools.lastDate());
//            map.put("recoredDates",DateTools.getBetweenDates(DateTools.firstDay(),DateTools.lastDate()));
        }
        map.put("type",type==null?0:type);

        return map;
    }
    @PostMapping("/count1")
    @RequiresPermissions("/count/manager")
    @ResponseBody
    public Object count1(String recoredDateRange,Integer type ) {
        Map map = handleCondition(recoredDateRange,type);
        return JSON.toJSON(countService.count1(map));
    }

}
