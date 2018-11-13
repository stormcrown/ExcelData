package cn.dovahkiin.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.model.Customer;
import cn.dovahkiin.service.*;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.model.VideoCost;
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

    @Autowired private IVideoCostService videoCostService;
    @GetMapping("/manager")
    @RequiresPermissions("/videoCost/manager")
    public String manager(HttpServletResponse response) {
        double max = videoCostService.selectMaxConsumption();
        if(max==0)max = 100;
//        if((max+"") .indexOf(".")>0 )max++;
        Cookie cookie = new Cookie("MaxConsumption", max+"");
        cookie.setPath("/");
        addCookie(response,cookie);
        return "videoCost/videoCostList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    @RequiresPermissions("/videoCost/dataGrid")
    public PageInfo dataGrid(VideoCost videoCost, Integer page, Integer rows, String sort,String order ,
                             String customerName_like,String  ConsumptionRange,String KeyWord
    ) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map map = new HashMap(5);
        map.put("videoCost",videoCost);
        map.put("order",order );
        map.put("sort",sort);
        if(StringUtils.isNotBlank(KeyWord)) map.put("KeyWord",KeyWord );

        Page<VideoCost> pages = getPage(page, rows, sort, order);
//        Page<VideoCost>
                pages= videoCostService.selectWithCount(pages,map);

//        pages = videoCostService.selectPage(pages, ew);
//        List<VideoCost> list = pages.getRecords();

        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/videoCost/add")
    public String addPage(Model model) {
        model.addAttribute("method", "add");
        return "videoCost/videoCost";
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/importExcelPage")
    @RequiresPermissions("/videoCost/importExcel")
    public String importExcelPage() {
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
        return super.add(videoCost,videoCostService);
//        videoCost.setCreateTime(new Date());
//        videoCost.setUpdateTime(new Date());
//        videoCost.setDeleteFlag(0);
//        boolean b = videoCostService.insert(videoCost);
//        if (b) {
//            return renderSuccess("添加成功！");
//        } else {
//            return renderError("添加失败！");
//        }
    }
    /**
     * 添加
     * @param
     * @return
     */
    @PostMapping("/importExcel")
    @ResponseBody
    @RequiresPermissions("/videoCost/importExcel")
    public Object importExcel(@Valid Date recoredDate, @RequestParam(name="excels") MultipartFile excels) {
        int m=0;
        boolean b = true;
        try {
            StringBuilder tips = new StringBuilder("部分数据需要补充或者修改：");
            InputStream inputStream = excels.getInputStream();
            Workbook workbook= WorkbookFactory.create(inputStream);
            Sheet sheet=workbook.getSheetAt(0);
            b = videoCostService.saveExcel(sheet,recoredDate,dateConverter);
            inputStream.close();
        }catch (InvalidFormatException e){
            e.printStackTrace();
        }catch (IOException e){
            e.printStackTrace();
        }
        if (b) {
            return renderSuccess("添加成功！"+m+"行数据被导入");
        } else {
            return renderError("添加失败！");
        }
    }
    /**
     * 删除
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    @RequiresPermissions("/videoCost/delete")
    public Object delete(Long id) {
        VideoCost videoCost = new VideoCost();
        videoCost.setId(id);
        videoCost.setUpdateTime(new Date());
        videoCost.setDeleteFlag(1);
        boolean b = videoCostService.updateById(videoCost);
//        videoCostService.deleteById(id);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
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
        VideoCost videoCost = videoCostService.selectById(id);
        model.addAttribute("videoCost", videoCost);
        model.addAttribute("method", "edit");
        return "videoCost/videoCost";
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
        boolean b = videoCostService.updateById(videoCost);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
