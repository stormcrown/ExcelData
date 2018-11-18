package cn.dovahkiin.service.impl;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.commons.utils.JsonUtils;
import cn.dovahkiin.model.*;
import cn.dovahkiin.mapper.VideoCostMapper;
import cn.dovahkiin.service.*;
import com.alibaba.druid.support.json.JSONParser;
import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.util.JSONPObject;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;

/**
 * <p>
 * 视频成片消耗 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-10-15
 */
@Service
public class VideoCostServiceImpl  implements IVideoCostService {
    //  调用Dao失败回滚
    @Autowired private VideoCostMapper videoCostMapper;
    // 调用服务，即使失败数据也不会回滚
    @Autowired private ICustomerService customerService;
    @Autowired private IEditorService editorService;
    @Autowired private IIndustryService iIndustryService;
    @Autowired private IOptimizerService iOptimizerService;
    @Autowired private IOrganizationService iOrganizationService;
    @Autowired private IOriginalityService iOriginalityService;
    @Autowired private IPerformerService performerService;
    @Autowired private IPhotographerService iPhotographerService;
    @Autowired private IProductTypeService iProductTypeService;
    @Autowired private IVideoTypeService videoTypeService;


    protected static Log logger = LogFactory.getLog(VideoCostServiceImpl.class);

    @Transactional
    public int insertMany(List<VideoCost> videoCostList){
        return videoCostMapper.insertMany(videoCostList);
    }

    @Override
    public int updateByPrimaryKey(VideoCost videoCost) {
        if(videoCost!=null && videoCost.getId()!=null)return videoCostMapper.updateByPrimaryKey(videoCost);
        return 0;
    }

    @Override
    public int deleteMany(String[] ids) {
        return videoCostMapper.deleteMany(ids);
    }
    @Override
    public org.springframework.ui.Model modelForEdit(org.springframework.ui.Model model) {
        EntityWrapper un_delete = new EntityWrapper();
        List<Organization> organizations = iOrganizationService.selectList(un_delete);
            model.addAttribute("organizations", organizations);
        un_delete.eq("delete_flag",0);
        List<Customer> customers = customerService.selectList(un_delete);
            model.addAttribute("customers",customers);
        List<Editor> editors = editorService.selectList(un_delete);
            model.addAttribute("editors",JsonUtils.toJson(editors));
        List<Industry> industries = iIndustryService.selectList(un_delete);
            model.addAttribute("industries",JsonUtils.toJson(industries));
        List<Optimizer> optimizers = iOptimizerService.selectList(un_delete);
            model.addAttribute("optimizers",JsonUtils.toJson(optimizers));
        List<Originality> originalities = iOriginalityService.selectList(un_delete);
            model.addAttribute("originalities",JsonUtils.toJson(originalities));
        List<Performer> performers = performerService.selectList(un_delete);
            model.addAttribute("performers",JsonUtils.toJson(performers));
        List<Photographer> photographers = iPhotographerService.selectList(un_delete);
            model.addAttribute("photographers",JsonUtils.toJson(photographers));
        List<ProductType> productTypes = iProductTypeService.selectList(un_delete);
            model.addAttribute("productTypes",JsonUtils.toJson(productTypes));
        List<VideoType> videoTypes = videoTypeService.selectList(un_delete);
            model.addAttribute("videoTypes",JsonUtils.toJson(videoTypes));
        return model;
    }

    @Override
    @Transactional
    public int saveExcel(Sheet sheet,Date recoredDate,DateConverter dateConverter) {
        EntityWrapper un_delete = new EntityWrapper();
        List<Organization> organizations = iOrganizationService.selectList(un_delete);
        un_delete.eq("delete_flag",0);
        List<Customer> customers = customerService.selectList(un_delete);
        List<Editor> editors = editorService.selectList(un_delete);
        List<Industry> industries = iIndustryService.selectList(un_delete);
        List<Optimizer> optimizers = iOptimizerService.selectList(un_delete);
        List<Originality> originalities = iOriginalityService.selectList(un_delete);
        List<Performer> performers = performerService.selectList(un_delete);
        List<Photographer> photographers = iPhotographerService.selectList(un_delete);
        List<ProductType> productTypes = iProductTypeService.selectList(un_delete);
        List<VideoType> videoTypes = videoTypeService.selectList(un_delete);

        int first = sheet.getFirstRowNum();
        int last = sheet.getLastRowNum();
         logger.info("first="+first+"\tlast="+last+"\trecoredDate="+recoredDate);
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
                videoCost.setBusinessDepartment(new Organization());
              格:for(int j=0;j<17;j++  ){
                    Cell cell = row.getCell(j);
                    if(cell!=null){
                        CellType cellType= cell.getCellTypeEnum();
                        Object value = null;
                        switch (cellType){
                            case BLANK://被合并了，或者是空格,查找被合并的里有没有。
                                String location = mergeDatas.get(i+"_"+j);
                                if(cn.dovahkiin.commons.utils.StringUtils.isNotBlank(location)&& location.indexOf("_")>0  ){
                                    String[] locations =location.split("_");
                                    if(locations.length==2 && cn.dovahkiin.commons.utils.StringUtils.isInteger(locations[0]) && cn.dovahkiin.commons.utils.StringUtils.isInteger(locations[1])  ){
                                        Row loac_row = sheet.getRow(Integer.parseInt(locations[0]));
                                        Cell loac_cell = loac_row.getCell(Integer.parseInt(locations[1]));
                                        value = getCellValue(loac_cell);
                                    }
                                }
                                break ;
                            case ERROR:continue 格;//错误格 ，继续下一格
                            default:value=getCellValue(cell);

                        }
                       // if(value==null)value="";
                        if(value!=null){
                            String valueStr = value.toString().trim();
                            if("——".equals(valueStr.replaceAll(" ","")))continue 格;;
                            switch (j){
                                    case 0: //业务部
                                        synchronized (organizations){
                                            Organization business = checkName(organizations,valueStr);
                                            if(business==null)business = checkSimpleName(organizations,valueStr);
                                            if(business==null){
                                                business = new Organization(valueStr,"",0,new Date());
                                                business.setCode(business.CreateCode());
                                                iOrganizationService.insert(business);
                                                organizations.add(business);
                                            }
                                            videoCost.setBusinessDepartment(business);
                                            break ;
                                        }

                                case 1:
                                    synchronized (productTypes){
                                        if(valueStr.indexOf("·")>0)valueStr=valueStr.split("·")[0];
                                        ProductType productType = checkName(productTypes,valueStr);
                                        if(productType == null){
                                            productType = new ProductType(valueStr,null,new Date(),0);
                                            productType.setCode(productType.CreateCode());
                                            iProductTypeService.insert(productType);
                                            productTypes.add(productType);
                                        }
                                        videoCost.setProductType(productType);
                                        break ;
                                    }
                                case 2:
                                    synchronized (customers){
                                        Customer customer = checkName(customers,valueStr);
                                        if(customer==null){
                                            customer = new Customer(valueStr,null,new Date(),0);
                                            customer.CreateCode();
                                            customerService.insert(customer);
                                            customers.add(customer);
                                        }
                                        videoCost.setCustomer(customer);
                                        break ;
                                    }

                                    case 3:
                                        synchronized (industries){
                                            Industry industry = checkName(industries,valueStr);
                                            if(industry==null){
                                                industry = new Industry(valueStr,null,new Date(),0);
                                                industry.CreateCode();
                                                iIndustryService.insert(industry);
                                                industries.add(industry);
                                            }
                                            videoCost.setIndustry(industry);
                                            break ;
                                        }
                                    case 4:
                                        synchronized (organizations){
                                            Organization organization = checkSimpleName(organizations,valueStr);
                                            if(organization==null)organization=checkName(organizations,valueStr);
                                            if(organization==null){
                                                organization = new Organization(valueStr,null,0,new Date());
                                                organization.CreateCode();
                                                iOrganizationService.insert(organization);
                                                organizations.add(organization);
                                            }
                                            videoCost.setDemandSector(organization);
                                            break;
                                        }
                                case 5:
                                    synchronized (optimizers){
                                        Optimizer optimizer = checkName(optimizers,valueStr);
                                        if(optimizer==null){
                                            optimizer = new Optimizer(valueStr,null,new Date(),0);
                                            optimizer.CreateCode();
                                            iOptimizerService.insert(optimizer);
                                            optimizers.add(optimizer);
                                        }
                                        videoCost.setOptimizer(optimizer);
                                        break ;
                                    }
                                 case 6:
                                     synchronized (videoTypes){
                                         valueStr=StringUtils.replace(valueStr,"类","");
                                         VideoType videoType = checkName(videoTypes,valueStr);
                                         if(videoType==null){
                                             videoType = new VideoType(valueStr,null,new Date(),0);
                                             videoType.CreateCode();
                                             videoTypeService.insert(videoType);
                                             videoTypes.add(videoType);
                                         }
                                         videoCost.setVideoType(videoType);
                                         break ;
                                     }
                                case 7:
                                    try{
                                        videoCost.setCompleteDate(dateConverter.convert(valueStr));
                                    }catch (IllegalArgumentException e){
//                                        e.printStackTrace();
                                    }
                                    break ;
                                case 8:
                                    synchronized (originalities){
                                        Originality originality = checkName(originalities,valueStr);
                                        if(originality==null){
                                            originality = new Originality(valueStr,null,new Date(),0);
                                            originality.CreateCode();
                                            iOriginalityService.insert(originality);
                                            originalities.add(originality);
                                        }
                                        videoCost.setOriginality(originality);
                                        break;
                                    }
                                    case 9:
                                        synchronized (photographers){
                                            Photographer photographer = checkName(photographers,valueStr);
                                            if(photographer==null){
                                                photographer = new Photographer(valueStr,null,new Date(),0);
                                                photographer.CreateCode();
                                                iPhotographerService.insert(photographer);
                                                photographers.add(photographer);
                                            }
                                            videoCost.setPhotographer(photographer);break;
                                        }
                                    case 10:
                                        synchronized (editors){
                                            Editor editor = checkName(editors,valueStr);
                                            if(editor==null){
                                                editor = new Editor(valueStr,null,new Date(),0);
                                                editor.CreateCode();
                                                editorService.insert(editor);
                                                editors.add(editor);
                                            }
                                            videoCost.setEditor(editor);break ;
                                        }
                                    case 11:
                                        synchronized (performers){
                                            Performer performer = checkName(performers,valueStr);
                                            if(performer==null){
                                                performer = new Performer(valueStr,null,new Date(),0);
                                                performer.CreateCode();
                                                performerService.insert(performer);
                                                performers.add(performer);
                                            }
                                            videoCost.setPerformer1(performer);
                                            break;
                                        }
                                    case 12:
                                        synchronized (performers){
                                            Performer performer = checkName(performers,valueStr);
                                            if(performer==null){
                                                performer = new Performer(valueStr,null,new Date(),0);
                                                performer.CreateCode();
                                                performerService.insert(performer);
                                                performers.add(performer);
                                            }
                                            videoCost.setPerformer2(performer);
                                            break;
                                        }
                                    case 13:
                                        synchronized (performers){
                                            Performer performer = checkName(performers,valueStr);
                                            if(performer==null){
                                                performer = new Performer(valueStr,null,new Date(),0);
                                                performer.CreateCode();
                                                performerService.insert(performer);
                                                performers.add(performer);
                                            }
                                            videoCost.setPerformer3(performer);
                                            break;
                                        }
                                case 14:
                                    if(cn.dovahkiin.commons.utils.StringUtils.isNumber(valueStr)) videoCost.setConsumption(Double.parseDouble(valueStr) );
                                    break ;
//                                case 15:
//                                    if(cn.dovahkiin.commons.utils.StringUtils.isNumber(valueStr)) videoCost.setCumulativeConsumption(Double.parseDouble(valueStr) );
//                                    break ;
//                                case 16:
//                                    if(cn.dovahkiin.commons.utils.StringUtils.isInteger(valueStr)) videoCost.setCumulativeConsumptionRanking(Integer.parseInt(valueStr) );
//                                    break ;
                            }
                        }
                    }

                }
                    if(videoCost.getCustomer() !=null ){
                        videoCosts.add(videoCost);
                        //logger.info(videoCost);
                    }
            }

        }
        logger.info("开始保存");
        int x = videoCostMapper.insertMany(videoCosts); //insertBatch(videoCosts);

        return x;

    }


    @Override
    @Transactional(readOnly = true)
    public Sheet exportData(Map map,Sheet sheet) {

        sheet.addMergedRegion(new CellRangeAddress(1,1,0,17));
        Row title = sheet.createRow(1);
        title.setHeight((short)760);
        Cell title_cell= title.createCell(0);
            title_cell.setCellValue("市场部视频组成片消耗日报（按部门）");
            CellStyle cellStyle_title = sheet.getWorkbook().createCellStyle();
            cellStyle_title.setAlignment(HorizontalAlignment.CENTER);
            cellStyle_title.setVerticalAlignment(VerticalAlignment.CENTER);
            cellStyle_title.setFillForegroundColor(IndexedColors.YELLOW.index);
            cellStyle_title.setFillBackgroundColor(IndexedColors.BLUE.index);
        Font font =sheet.getWorkbook().createFont();
                font.setBold(Boolean.TRUE);
                font.setFontHeight((short)480);
                font.setFontName("楷体");
                font.setColor(IndexedColors.DARK_RED.index);
                cellStyle_title.setFont(font);
            title_cell.setCellStyle(cellStyle_title);
        Row ttile_row = sheet.createRow(2);
        Cell cell_2_0 = ttile_row.createCell(0); cell_2_0.setCellValue("业务部");
        Cell cell_2_1 = ttile_row.createCell(1); cell_2_1.setCellValue("产品类型");
        Cell cell_2_2 = ttile_row.createCell(2); cell_2_2.setCellValue("客户名");
        Cell cell_2_3 = ttile_row.createCell(3); cell_2_3.setCellValue("行业");
        Cell cell_2_4 = ttile_row.createCell(4); cell_2_4.setCellValue("需求部门");
        Cell cell_2_5 = ttile_row.createCell(5); cell_2_5.setCellValue("优化师");
        Cell cell_2_6 = ttile_row.createCell(6); cell_2_6.setCellValue("视频类型");
        Cell cell_2_7 = ttile_row.createCell(7); cell_2_7.setCellValue("成片日期");
        Cell cell_2_8 = ttile_row.createCell(8); cell_2_8.setCellValue("创意");
        Cell cell_2_9 = ttile_row.createCell(9); cell_2_9.setCellValue("摄像");
        Cell cell_2_10 = ttile_row.createCell(10); cell_2_10.setCellValue("剪辑");
        Cell cell_2_11 = ttile_row.createCell(11); cell_2_11.setCellValue("演员1");
        Cell cell_2_12 = ttile_row.createCell(12); cell_2_12.setCellValue("演员2");
        Cell cell_2_13 = ttile_row.createCell(13); cell_2_13.setCellValue("演员3");
        Cell cell_2_14 = ttile_row.createCell(14); cell_2_14.setCellValue("当日消耗");
        Cell cell_2_15 = ttile_row.createCell(15); cell_2_15.setCellValue("累计消耗");
        Cell cell_2_16 = ttile_row.createCell(16); cell_2_16.setCellValue("累计排名");
        Cell cell_2_17 = ttile_row.createCell(17); cell_2_17.setCellValue("数据日期");
        List<VideoCost> videoCosts= videoCostMapper.selectWithCount(map);
        if(videoCosts!=null){
            sheet.setColumnWidth(7,4000);
            sheet.setColumnWidth(17,4000);
            CellStyle cellStyle_date = sheet.getWorkbook().createCellStyle();
            DataFormat format= sheet.getWorkbook().createDataFormat();
            cellStyle_date.setDataFormat(format.getFormat("yyyy年MM月dd日"));

            CellStyle cellStyle_money = sheet.getWorkbook().createCellStyle();
            DataFormat money_format= sheet.getWorkbook().createDataFormat();
            cellStyle_money.setDataFormat(format.getFormat("¥#,##0"));



            for(int i=0;i<videoCosts.size();i++){
                Row data_row = sheet.createRow(i+3);
                VideoCost videoCost = videoCosts.get(i);
                if(videoCost==null)continue;
                if(videoCost.getBusinessDepartment()!=null){
                    Cell cell_i_0 = data_row.createCell(0); cell_i_0.setCellValue(videoCost.getBusinessDepartment().getName());
                }
                if(videoCost.getProductType()!=null){
                    Cell cell_i_1 = data_row.createCell(1); cell_i_1.setCellValue(videoCost.getProductType().getName());
                }
                if(videoCost.getCustomer()!=null){
                    Cell cell_i_2 = data_row.createCell(2); cell_i_2.setCellValue(videoCost.getCustomer().getName());
                }
                if(videoCost.getIndustry()!=null){
                    Cell cell_i_3 = data_row.createCell(3); cell_i_3.setCellValue(videoCost.getIndustry().getName());
                }
                if(videoCost.getDemandSector()!=null ){
                    Cell cell_i_4 = data_row.createCell(4); cell_i_4.setCellValue(videoCost.getDemandSector().getName());
                }
                if(videoCost.getOptimizer()!=null){
                    Cell cell_i_5 = data_row.createCell(5); cell_i_5.setCellValue(videoCost.getOptimizer().getName());
                }
                if(videoCost.getVideoType()!=null){
                    Cell cell_i_6 = data_row.createCell(6); cell_i_6.setCellValue(videoCost.getVideoType().getName());
                }
                if(videoCost.getCompleteDate()!=null){
                    Cell cell_i_7 = data_row.createCell(7); cell_i_7.setCellValue(videoCost.getCompleteDate());
                    cell_i_7.setCellStyle(cellStyle_date);
                }
                if(videoCost.getOriginality()!=null){
                    Cell cell_i_8 = data_row.createCell(8); cell_i_8.setCellValue(videoCost.getOriginality().getName());
                }
                if(videoCost.getPhotographer()!=null){
                    Cell cell_i_9 = data_row.createCell(9); cell_i_9.setCellValue(videoCost.getPhotographer().getName());
                }
                if(videoCost.getEditor()!=null){
                    Cell cell_i_10 = data_row.createCell(10); cell_i_10.setCellValue(videoCost.getEditor().getName());
                }
                if(videoCost.getPerformer1()!=null){
                    Cell cell_i_11 = data_row.createCell(11); cell_i_11.setCellValue(videoCost.getPerformer1().getName());
                }
                if(videoCost.getPerformer2()!=null){
                    Cell cell_i_12 = data_row.createCell(12); cell_i_12.setCellValue(videoCost.getPerformer2().getName());
                }
                if(videoCost.getPerformer3()!=null){
                    Cell cell_i_13 = data_row.createCell(13); cell_i_13.setCellValue(videoCost.getPerformer3().getName());
                }
                if(videoCost.getConsumption()!=null){
                    Cell cell_i_14 = data_row.createCell(14); cell_i_14.setCellValue(videoCost.getConsumption());
                    cell_i_14.setCellStyle(cellStyle_money);
                }
                if(videoCost.getCumulativeConsumptionByPro()!=null){
                    Cell cell_i_15 = data_row.createCell(15); cell_i_15.setCellValue(videoCost.getCumulativeConsumptionByPro());
                    cell_i_15.setCellStyle(cellStyle_money);
                }
                if(videoCost.getCumulativeConsumptionRankingByProglam()!=null){
                    Cell cell_i_16 = data_row.createCell(16); cell_i_16.setCellValue(videoCost.getCumulativeConsumptionRankingByProglam());
                }
                if(videoCost.getRecoredDate()!=null){
                    Cell cell_i_17 = data_row.createCell(17); cell_i_17.setCellValue(videoCost.getRecoredDate());
                    cell_i_17.setCellStyle(cellStyle_date);
                }
            }
        }
        return sheet;
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

    private <T extends Model> T checkName(List<T>  models,String name){
        return checkNameWithMethodName(models,name,"getName");
    }
    private <T extends Model> T checkSimpleName(List<T>  models,String name){
        return checkNameWithMethodName(models,name,"getSimpleNames");
    }
    private <T extends Model> T checkNameWithMethodName(List<T>  models,String name,String methodName){
        try {
            synchronized (models){
                for(T model: models){
                    if(model==null || name == null || name.trim().equals("")  )return null;
                    Method method = model.getClass().getMethod(methodName) ;
                    String old_name =  (String)method.invoke(model);
                    //logger.info("比较名称："+old_name+"\t"+name+"\t"+name.equals(old_name));
                    if(name.equals(old_name)  )return model;
                }
            }
        }catch (NoSuchMethodException e){
            e.printStackTrace();
        }catch (InvocationTargetException e){
            e.printStackTrace();
        }catch (IllegalAccessException e){e.printStackTrace();
        }catch (Exception e){e.printStackTrace();
        }
        return  null;
    }

    @Override
    public Page<VideoCost> selectWithCount(Page<VideoCost> pages ,Map<String, Object> map) {
        List<VideoCost> videoCosts = videoCostMapper.selectWithCount(map);
        int total = videoCostMapper.selectCount(map);
        pages.setRecords(videoCosts);
        pages.setTotal(total);
        return pages;
    }
    @Override
    public int selectCount(Date recoredDate) {
        Map map =new HashMap();
        map.put("recoredDate_start",recoredDate);
        map.put("recoredDate_end",recoredDate);
        return  videoCostMapper.selectCount(map);
    }

    @Override
    public VideoCost selectByPrimaryKey(Long  id) {
        Map map = new HashMap();
        map.put("videoCostId",id);
        List<VideoCost> videoCosts = videoCostMapper.selectWithCount(map);
        if(videoCosts!=null && videoCosts.size()==1)return videoCosts.get(0);
        return null;
    }

    @Override
    public double selectMaxConsumption() {
        Double d =videoCostMapper.selectMaxConsumption();
        if(d!=null)return d;
        return 0;
    }

    public static boolean sql_inj(String str){
        String inj_str = "'|and|exec|insert|select|delete|update|count|*|%|chr|mid|master|truncate|char|declare|;|or|-|+|,";
        String inj_stra[] = StringUtils.split(inj_str,"|");
        for (int i=0 ; i < inj_stra.length ; i++ ){
            if (str.indexOf(inj_stra[i])>=0){
                return true;
            }
        }
        return false;
    }


}
