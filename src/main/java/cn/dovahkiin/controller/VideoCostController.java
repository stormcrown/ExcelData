package cn.dovahkiin.controller;

import javax.validation.Valid;

import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;


import cn.dovahkiin.commons.utils.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.model.VideoCost;
import cn.dovahkiin.service.IVideoCostService;
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
    public String manager() {
        return "videoCost/videoCostList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    @RequiresPermissions("/videoCost/dataGrid")
    public PageInfo dataGrid(VideoCost videoCost, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        
        EntityWrapper<VideoCost> ew = new EntityWrapper<VideoCost>(videoCost);
        ew.eq("delete_flag",0);
        if(videoCost.getCustomerName()!=null) ew.like("customer_name" ,"%"+videoCost.getCustomerName().trim()+"%");
        Page<VideoCost> pages = getPage(page, rows, sort, order);
        pages = videoCostService.selectPage(pages, ew);
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
        videoCost.setCreateTime(new Date());
        videoCost.setUpdateTime(new Date());
        videoCost.setDeleteFlag(0);
        boolean b = videoCostService.insert(videoCost);

        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
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
        try {
            StringBuilder tips = new StringBuilder("以下行：需要补充数据");
            InputStream inputStream = excels.getInputStream();
            boolean needTip = false;
            Workbook workbook= WorkbookFactory.create(inputStream);
            Sheet sheet=workbook.getSheetAt(0);
            int first = sheet.getFirstRowNum();
            int last = sheet.getLastRowNum();
            logger.info("first="+first+"\tlast="+last+"\trecoredDate="+recoredDate);
            List<VideoCost> datas = new ArrayList();

            /*  可能被合并的单元格，值取上一行的值 */
            Cell upper_0 = null;
            Cell upper_1 = null;
            Date now = new Date();
            first = 3;//实际数据从哪一行开始
            行: for(int i=first;i<last+1;i++ ){
                Row row=sheet.getRow(i);
                if(row!=null){
                    VideoCost videoCost = new VideoCost(now,now,0,recoredDate);
                   格:for(int j=0;j<17;j++  ){
                        Cell cell = row.getCell(j);
                       // if(j==0) logger.info("cell 位置： i="+i+"\tj="+j +"\tcell "+(cell.getCellTypeEnum().name()));
//                        if(cell!=null){
////                            if(j==0)upper_0=cell;else if(j==1)upper_1 = cell;
////                        }else {
////                            if(j==0)cell=upper_0;else if(j==1)  cell=upper_1;
////                        }

                        if(cell!=null){

                            CellType cellType= cell.getCellTypeEnum();
                            if(!CellType.BLANK.equals(cellType)){
                                if(j==0   )upper_0=cell;else if(j==1)upper_1 = cell;
                            }
                            Object value = null;
                            switch (cellType){
                                case STRING:value = cell.getStringCellValue();break ;
                                case NUMERIC:value=cell.getNumericCellValue();break;
                                case BOOLEAN:value=cell.getBooleanCellValue();break ;
                                case FORMULA:value=cell.getNumericCellValue();break ;
                                case BLANK://被合并了,取上一行的值
                                    if(j==0)value=upper_0.getStringCellValue();
                                    else if(j==1)value=upper_1.getStringCellValue();
                                    else continue 格;
                                    break;
                                case ERROR:continue 格;//错误格 ，继续下一格

                            }
                            if(value!=null){
                                String valueStr = value.toString();
                                switch (j){
                                    case 0:
                                        videoCost.setBusinessDepartment(valueStr);break ;
                                    case 1:
                                        if(valueStr.indexOf("·")>0)valueStr=valueStr.split("·")[0];
                                        videoCost.setProductType(valueStr);break ;
                                    case 2:
                                        videoCost.setCustomerName(valueStr);break ;
                                    case 3:
                                        videoCost.setIndustry(valueStr);break ;
                                    case 4:
                                        videoCost.setDemandSector(valueStr);break;
                                    case 5:
                                        videoCost.setOptimizer(valueStr);break ;
                                    case 6:videoCost.setVideoType(valueStr);break ;
                                    case 7:
                                        try{
                                            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd");
                                            videoCost.setCompleteDate(simpleDateFormat.parse(valueStr));
                                        }catch (ParseException e){
                                            e.printStackTrace();
                                        }
                                        break ;
                                    case 8:videoCost.setOriginality(valueStr);break;
                                    case 9:videoCost.setPhotographer(valueStr);break;
                                    case 10:videoCost.setEditor(valueStr);break ;
                                    case 11:videoCost.setPerformer1(valueStr);break;
                                    case 12:videoCost.setPerformer2(valueStr);break ;
                                    case 13:videoCost.setPerformer3(valueStr);break;
                                    case 14:
                                        if(StringUtils.isNumber(valueStr)) videoCost.setConsumption(Double.parseDouble(valueStr) );
                                        break ;
                                    case 15:
                                        if(StringUtils.isNumber(valueStr)) videoCost.setCumulativeConsumption(Double.parseDouble(valueStr) );
                                        break ;
                                    case 16:
                                        if(StringUtils.isInteger(valueStr)) videoCost.setCumulativeConsumptionRanking(Integer.parseInt(valueStr) );
                                        break ;
                                }
                            }
                        }

                    }
                    if(StringUtils.isNotBlank(videoCost.getCustomerName() ) ){
                        datas.add(videoCost);
                      //  logger.info(videoCost);
                    }
                }

            }
            m= videoCostService.insertMany(datas);

            inputStream.close();
        }catch (InvalidFormatException e){
            e.printStackTrace();
        }catch (IOException e){
            e.printStackTrace();
        }

        boolean b = true;
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
