package cn.dovahkiin.controller;

import javax.validation.Valid;

import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


import cn.dovahkiin.commons.utils.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
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
    public PageInfo dataGrid(VideoCost videoCost, Integer page, Integer rows, String sort,String order ,String customerName_like) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<VideoCost> ew = new EntityWrapper<VideoCost>(videoCost);
        if(StringUtils.isNotBlank(customerName_like))
            ew.like("customer_name",customerName_like);
            ew.eq("delete_flag",0);


        Page<VideoCost> pages = getPage(page, rows, sort, order);
        pages = videoCostService.selectPage(pages, ew);

        List<VideoCost> list = pages.getRecords();
        List<VideoCost> counts = videoCostService.countByCustomName();
        for(VideoCost v1 :counts  ){
            for(VideoCost v2 :list  ){
                if( v1!=null && v1.getCustomerName()!=null &&  v1.getCustomerName().equals( v2.getCustomerName() )){
                    v2.setCumulativeConsumptionByPro(v1.getCumulativeConsumptionByPro());
                    v2.setCumulativeConsumptionRankingByProglam(v1.getCumulativeConsumptionRankingByProglam());
                }
            }
        }
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
            StringBuilder tips = new StringBuilder("部分数据需要补充或者修改：");
            InputStream inputStream = excels.getInputStream();
            boolean needTip = false;
            Workbook workbook= WorkbookFactory.create(inputStream);
            Sheet sheet=workbook.getSheetAt(0);
            int first = sheet.getFirstRowNum();
            int last = sheet.getLastRowNum();
           // logger.info("first="+first+"\tlast="+last+"\trecoredDate="+recoredDate);
            List<VideoCost> videoCosts = new ArrayList();



            Date now = new Date();
            first = 3;//实际数据从哪一行开始

            /*  被合并的单元格  */
            Map<String ,String> mergeDatas =new HashMap<>((last-first)*2);
            /*  被合并的单元格 */
            List<CellRangeAddress> merges= sheet.getMergedRegions();
            for(CellRangeAddress cell_mege:merges){
                int f_row = cell_mege.getFirstRow();
                int l_row = cell_mege.getLastRow();
                int f_colum = cell_mege.getFirstColumn();
                int l_colum = cell_mege.getLastColumn();
                if(l_row-f_row>1 || f_colum-l_colum>1 ){
                    for(int r=f_row ;r<l_row+1;r++){
                        for(int col=f_colum ;col<l_colum+1;col++){
                            mergeDatas.put(r+"_"+col,f_row+"_"+f_colum);
                        }
                    }
                }
            }

            行: for(int i=first;i<last+1;i++ ){
                Row row=sheet.getRow(i);
                if(row!=null){
                    VideoCost videoCost = new VideoCost(now,now,0,recoredDate);
                   格:for(int j=0;j<17;j++  ){
                        Cell cell = row.getCell(j);

                        if(cell!=null){


                            CellType cellType= cell.getCellTypeEnum();
                            Object value = null;
                            switch (cellType){
                                case BLANK://被合并了，或者是空格,查找被合并的里有没有。
                                    String location = mergeDatas.get(i+"_"+j);
                                    if(StringUtils.isNotBlank(location)&& location.indexOf("_")>0  ){
                                     String[] locations =location.split("_");
                                     if(locations.length==2 && StringUtils.isInteger(locations[0]) && StringUtils.isInteger(locations[1])  ){
                                         Row loac_row = sheet.getRow(Integer.parseInt(locations[0]));
                                         Cell loac_cell = loac_row.getCell(Integer.parseInt(locations[1]));
                                         value = getCellValue(loac_cell);
                                     }
                                    }
                                    break ;
                                case ERROR:continue 格;//错误格 ，继续下一格
                                default:value=getCellValue(cell);

                            }
                            if(value!=null){
                                String valueStr = value.toString();
                                if("——".equals(valueStr.replaceAll(" ","")))continue 格;;
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
                                            videoCost.setCompleteDate(dateConverter.convert(valueStr));
                                        }catch (IllegalArgumentException e){
                                            e.printStackTrace();
                                            needTip=true;
                                            tips.append(i+1).append("行完成日期格式不匹配；");
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
                        videoCosts.add(videoCost);
                      //  logger.info(videoCost);
                    }
                }

            }
            m= videoCostService.insertMany(videoCosts);

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
    private Object getCellValue(Cell cell){
        CellType cellType= cell.getCellTypeEnum();
        Object value = null;
        switch (cellType){
            case STRING:value = cell.getStringCellValue();break ;
            case NUMERIC:value=cell.getNumericCellValue();break;
            case BOOLEAN:value=cell.getBooleanCellValue();break ;
            case FORMULA:value=cell.getNumericCellValue();break ;
        }
        return value;
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
