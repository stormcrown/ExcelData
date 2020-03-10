package cn.dovahkiin.service.impl;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.commons.shiro.ShiroUser;
import cn.dovahkiin.commons.utils.JsonUtils;
import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.model.*;
import cn.dovahkiin.mapper.VideoCostMapper;
import cn.dovahkiin.service.*;
import cn.dovahkiin.util.Const;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;

import static org.apache.poi.ss.usermodel.FillPatternType.SOLID_FOREGROUND;

/**
 * <p>
 * 视频成片消耗 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-10-15
 */
@Service
public class VideoCostServiceImpl implements IVideoCostService {
    //  调用Dao失败回滚
    @Autowired
    private VideoCostMapper videoCostMapper;
    // 调用服务，即使失败数据也不会回滚
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private IEditorService editorService;
    @Autowired
    private IIndustryService iIndustryService;
    @Autowired
    private IOptimizerService iOptimizerService;
    @Autowired
    private IOrganizationService iOrganizationService;
    @Autowired
    private IOriginalityService iOriginalityService;
    @Autowired
    private IPerformerService performerService;
    @Autowired
    private IPhotographerService iPhotographerService;
    @Autowired
    private IProductTypeService iProductTypeService;
    @Autowired
    private IVideoTypeService videoTypeService;
    @Autowired
    private ITrueCustomerService trueCustomerService;


    protected static Log logger = LogFactory.getLog(VideoCostServiceImpl.class);

    @Transactional
    public int insertMany(List<VideoCost> videoCostList) {
        return videoCostMapper.insertMany(videoCostList);
    }

    @Override
    public int updateByPrimaryKey(VideoCost videoCost) {
        if (videoCost != null && videoCost.getId() != null) return videoCostMapper.updateByPrimaryKey(videoCost);
        return 0;
    }

    @Override
    public int deleteMany(String[] ids) {
        return videoCostMapper.deleteMany(ids);
    }

    @Override
    public int deleteManyForever(String[] ids) {
        int unDeleted = videoCostMapper.countUndeleted(ids);
        if(unDeleted==0) return videoCostMapper.deleteManyForever(ids);
        else throw new RuntimeException("请先删除数据，再执行永久删除");
    }

    @Override
    public org.springframework.ui.Model modelForEdit(org.springframework.ui.Model model) {
        EntityWrapper un_delete = new EntityWrapper();
        List<Organization> organizations = iOrganizationService.selectList(un_delete);
        model.addAttribute("organizations", organizations);
        un_delete.eq("delete_flag", 0);
        List<Customer> customers = customerService.selectUnDeleted();
        model.addAttribute("customers", customers);
        List<Optimizer> optimizers = iOptimizerService.selectList(un_delete);
        model.addAttribute("optimizers", JsonUtils.toJson(optimizers));
        return model;
    }

    @Override
    @Transactional
    public int saveExcel(Sheet sheet, Date recoredDate, DateConverter dateConverter, ShiroUser user) {
        EntityWrapper un_delete = new EntityWrapper();

        List<Organization> organizations = iOrganizationService.selectList(un_delete);
        un_delete.eq("delete_flag", 0);
        List<Customer> customers = customerService.selectUnDeleted();
        List<Editor> editors = editorService.selectList(un_delete);
        List<Industry> industries = iIndustryService.selectList(un_delete);
        List<Optimizer> optimizers = iOptimizerService.selectList(un_delete);
        List<Originality> originalities = iOriginalityService.selectList(un_delete);
        List<Performer> performers = performerService.selectList(un_delete);
        List<Photographer> photographers = iPhotographerService.selectList(un_delete);
      //  List<ProductType> productTypes = iProductTypeService.selectList(un_delete);
        List<VideoType> videoTypes = videoTypeService.selectList(un_delete);
        List<TrueCustomer> trueCustomers = trueCustomerService.selectList(un_delete);
        int first = sheet.getFirstRowNum();
        int last = sheet.getLastRowNum();
        logger.info("first=" + first + "\tlast=" + last + "\trecoredDate=" + recoredDate);
        List<VideoCost> videoCosts = new ArrayList();

        for (int i = first; i < last + 1; i++) {
            Row row = sheet.getRow(i);
            if (row != null) {
                    Cell cell=row.getCell(0);
                    Object value = getCellValue(cell);
                    if(value!=null && "排名".equals(value)){
                          first = i;
                          break ;
                    }

            }
        }
        first++;
        Date now = new Date();
        /*  被合并的单元格  */
        Map<String, String> mergeDatas = new HashMap<>((last - first) * 2);
        /*  被合并的单元格 */
        List<CellRangeAddress> merges = sheet.getMergedRegions();
        for (CellRangeAddress cell_mege : merges) {
            int f_row = cell_mege.getFirstRow();
            int l_row = cell_mege.getLastRow();
            int f_colum = cell_mege.getFirstColumn();
            int l_colum = cell_mege.getLastColumn();
            if (l_row - f_row > 1 || f_colum - l_colum > 1) {
                for (int r = f_row; r < l_row + 1; r++) {
                    for (int col = f_colum; col < l_colum + 1; col++) {
                        mergeDatas.put(r + "_" + col, f_row + "_" + f_colum);
                    }
                }
            }
        }
        Calendar date2010 = Calendar.getInstance();
        date2010.set(Calendar.YEAR,2010);
        date2010.set(Calendar.MONTH,9);
        Date date_2010 = date2010.getTime();
        行:
        for (int i = first; i < last + 1; i++) {
            Row row = sheet.getRow(i);
            if (row != null) {
                VideoCost videoCost = new VideoCost(user.getId() ,now,user.getId(), now, 0, recoredDate);
                videoCost.setBusinessDepartment(new Organization());
                Customer customer_1 = new Customer(null, null, now, 0);
                Object codeC = getCellValue(row.getCell(1)) ; ;
                String code ="";
                if(codeC!=null)code=codeC.toString();
                if(!StringUtils.hasText(code))code=null;
                格:
                for (int j = 0; j < 17; j++) {
                    Cell cell = row.getCell(j);
                    if (cell != null) {
                        CellType cellType = cell.getCellTypeEnum();
                        Object value = null;
                        switch (cellType) {
                            case BLANK://被合并了，或者是空格,查找被合并的里有没有。
                                String location = mergeDatas.get(i + "_" + j);
                                if (cn.dovahkiin.commons.utils.StringUtils.isNotBlank(location) && location.indexOf("_") > 0) {
                                    String[] locations = location.split("_");
                                    if (locations.length == 2 && cn.dovahkiin.commons.utils.StringUtils.isInteger(locations[0]) && cn.dovahkiin.commons.utils.StringUtils.isInteger(locations[1])) {
                                        Row loac_row = sheet.getRow(Integer.parseInt(locations[0]));
                                        Cell loac_cell = loac_row.getCell(Integer.parseInt(locations[1]));
                                        value = getCellValue(loac_cell);
                                    }
                                }
                                break;
                            case ERROR:
                                continue 格;//错误格 ，继续下一格
                            default:
                                value = getCellValue(cell);

                        }
                        if (value != null  ) {
                            String valueStr = value.toString().replaceAll(" ","");
                            if(!StringUtils.hasText(valueStr))continue 格;
                            if ("——".equals(valueStr.replaceAll(" ", ""))) continue 格;
                            ;
                            switch (j) {

                                case 1:
                                    synchronized (customers ) {
                                        customer_1.setCode(valueStr);
                                        code=valueStr;
                                    }
                                    break;
                                case 2:
                                    synchronized (trueCustomers){
                                        TrueCustomer trueCustomer = checkName(trueCustomers,valueStr);
                                        if(trueCustomer==null){
                                            trueCustomer = new TrueCustomer(valueStr,now,now,0);
                                            trueCustomer.CreateCode();
                                            trueCustomerService.insert(trueCustomer);
                                            trueCustomers.add(trueCustomer);
                                        }
                                        customer_1.setTrueCustomer(trueCustomer);

                                        break ;
                                    }

                                case 3:
                                    synchronized (customers ) {
                                        customer_1.setName(valueStr);
                                        //customer_1.setCode(code);
                                        Customer     customer = checkCodeOrName(customers,customer_1.getCode(),customer_1.getName());
                                        if (customer == null) {
                                            if (!cn.dovahkiin.commons.utils.StringUtils.hasText(customer_1.getCode())) customer_1.CreateCode();
                                            customerService.insert(customer_1);
                                            customers.add(customer_1);
                                            customer = customer_1;
                                        }
                                        else if( !customer_1.getName().equals(customer.getName()) || ( StringUtils.hasText(customer_1.getCode()) && !customer.getCode().equals(customer_1.getCode()) ) ) {
                                            StringBuffer stringBuffer = new StringBuffer("第");
                                            stringBuffer.append(i+1).append(" 行，编码：")
                                                    .append(customer_1.getCode()).append("对应的素材名：").append(customer_1.getName()).append(",与数据库中的素材名称：")
                                                    .append(customer.getName()).append("编码：").append(customer.getCode()).append("不一致");
                                            throw new  RuntimeException(stringBuffer.toString() );
                                        }

                                        videoCost.setCustomer(customer);
                                        break;
                                    }
                                case 4:
                                    synchronized (industries) {
                                        Industry industry = checkName(industries, valueStr);
                                        if (industry == null) {
                                            industry = new Industry(valueStr, null, now, 0);
                                            industry.CreateCode();
                                            iIndustryService.insert(industry);
                                            industries.add(industry);
                                        }
                                        customer_1.setIndustry(industry);
//                                            videoCost.setIndustry(industry);
                                        break;
                                    }
                                case 5:
                                    synchronized (organizations) {
                                        Organization organization = checkSimpleName(organizations, valueStr);
                                        if (organization == null) organization = checkName(organizations, valueStr);
                                        if (organization == null) {
                                            organization = new Organization(valueStr, null, 0, now);
                                            organization.CreateCode();
                                            iOrganizationService.insert(organization);
                                            organizations.add(organization);
                                        }

                                        videoCost.setDemandSector(organization);
                                        break;
                                    }
                                case 6:
                                    synchronized (optimizers) {
                                        Optimizer optimizer = checkName(optimizers, valueStr);
                                        if (optimizer == null) {
                                            optimizer = new Optimizer(valueStr, null, now, 0);
                                            optimizer.CreateCode();
                                            iOptimizerService.insert(optimizer);
                                            optimizers.add(optimizer);
                                        }
                                        videoCost.setOptimizer(optimizer);
                                        break;
                                    }
                                case 7:
                                    synchronized (videoTypes) {
                                        valueStr = StringUtils.replace(valueStr, "类", "");
                                        VideoType videoType = checkName(videoTypes, valueStr);
                                        if (videoType == null) {
                                            videoType = new VideoType(valueStr, null, now, 0);
                                            videoType.CreateCode();
                                            videoTypeService.insert(videoType);
                                            videoTypes.add(videoType);
                                        }
                                        customer_1.setVideoType(videoType);
//                                         videoCost.setVideoType(videoType);
                                        break;
                                    }
                                case 8:
                                    try {
                                        if(StringUtils.isNotBlank(valueStr)){
                                            Date date = null;
                                            try {
                                                cell.setCellType(CellType.NUMERIC);
                                                date = cell.getDateCellValue();
                                                if(date!=null  && date.getTime() > date_2010.getTime() )customer_1.setCompleteDate(date);
                                            } catch (Exception e) { e.printStackTrace(); }
                                            if(date==null || date.getTime() > date_2010.getTime() )customer_1.setCompleteDate(dateConverter.convert(valueStr));
                                        }
                                    } catch (IllegalArgumentException e) {
                                        throw new RuntimeException("第"+(i+1)+"行无法识别列“成片日期”：\n"+valueStr);
                                    }
                                    break;
                                case 9:
                                    synchronized (originalities) {
                                        Originality originality = checkName(originalities, valueStr);
                                        if (originality == null) {
                                            originality = new Originality(valueStr, null, now, 0);
                                            originality.CreateCode();
                                            iOriginalityService.insert(originality);
                                            originalities.add(originality);
                                        }
//                                        videoCost.setOriginality(originality);
                                        customer_1.setOriginality(originality);
                                        break;
                                    }
                                case 10:
                                    synchronized (photographers) {
                                        Photographer photographer = checkName(photographers, valueStr);
                                        if (photographer == null) {
                                            photographer = new Photographer(valueStr, null, now, 0);
                                            photographer.CreateCode();
                                            iPhotographerService.insert(photographer);
                                            photographers.add(photographer);
                                        }
//                                            videoCost.setPhotographer(photographer);
                                        customer_1.setPhotographer(photographer);
                                        break;
                                    }
                                case 11:
                                    synchronized (editors) {
                                        Editor editor = checkName(editors, valueStr);
                                        if (editor == null) {
                                            editor = new Editor(valueStr, null, now, 0);
                                            editor.CreateCode();
                                            editorService.insert(editor);
                                            editors.add(editor);
                                        }
//                                            videoCost.setEditor(editor);
                                        customer_1.setEditor(editor);
                                        break;
                                    }
                                case 12:
                                    synchronized (performers) {
                                        Performer performer = checkName(performers, valueStr);
                                        if (performer == null) {
                                            performer = new Performer(valueStr, null, now, 0);
                                            performer.CreateCode();
                                            performerService.insert(performer);
                                            performers.add(performer);
                                        }
//                                            videoCost.setPerformer1(performer);
                                        customer_1.setPerformer1(performer);
                                        break;
                                    }
                                case 13:
                                    synchronized (performers) {
                                        Performer performer = checkName(performers, valueStr);
                                        if (performer == null) {
                                            performer = new Performer(valueStr, null, now, 0);
                                            performer.CreateCode();
                                            performerService.insert(performer);
                                            performers.add(performer);
                                        }
//                                            videoCost.setPerformer2(performer);
                                        customer_1.setPerformer2(performer);
                                        break;
                                    }
                                case 14:
                                    try {
                                        if(StringUtils.isNotBlank(valueStr)) videoCost.setConsumption(Double.parseDouble(valueStr));
                                    } catch (NumberFormatException e) {
                                        e.printStackTrace();
                                        throw new RuntimeException("第"+(i+1)+"行无法识别消耗量");
                                    }
                                    break;
                                case 15:
                                    Date rec = videoCost.getRecoredDate();
                                        if(StringUtils.isNotBlank(valueStr)){
                                            Date date = null;
                                            try {
                                                cell.setCellType(CellType.NUMERIC);
                                                date = cell.getDateCellValue();
                                                if(date!=null && date.getTime() > date_2010.getTime() )rec = date;
                                            } catch (Exception e) { e.printStackTrace(); }
                                            try {
                                                if(date==null || date.getTime() < date_2010.getTime()) rec = dateConverter.convert(valueStr) ;
                                            } catch (IllegalArgumentException e) {
                                               throw new RuntimeException("第"+(i+1)+"行无法识别列“消耗日期”：\n"+valueStr);
                                            }
                                        }
                                        videoCost.setRecoredDate(rec);
                                    break;
                            }
                        }
                    }
                }
                if (customer_1.getId() != null) {
                    customer_1.setUpdateTime(now);
                    if(StringUtils.hasText(customer_1.getCode())){
                        Customer customer = customerService.selectByCode(customer_1.getCode());
                        if(customer!=null && (!customer.getId().equals(customer_1.getId()) || !customer_1.getName().equals(customer.getName()) ) ){
                            StringBuffer stringBuffer = new StringBuffer("第");
                            stringBuffer.append(i+1).append(" 行，编码：")
                                    .append(customer_1.getCode()).append("对应的素材名：").append(customer_1.getName()).append(",与数据库中的素材名称：")
                                    .append(customer.getName()).append("编码：").append(customer.getCode()).append("不一致");
                            throw new  RuntimeException(stringBuffer.toString() );
                        }
                    }
                    customerService.updateByPrimaryKeySelective(customer_1);
                }
                if (videoCost.getCustomer() != null) videoCosts.add(videoCost);
            }

        }
        logger.info("开始保存");
        int x = videoCostMapper.insertMany(videoCosts); //insertBatch(videoCosts);

        return x;

    }


    @Override
    @Transactional(readOnly = true)
    public Workbook exportData(Map map, Workbook workbook) {

        Sheet sheet = workbook.createSheet();
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 18));
        Row title = sheet.createRow(1);
        title.setHeight((short) 760);
        Cell title_cell = title.createCell(0);

        title_cell.setCellValue("市场部视频组成片消耗日报（按部门）");
        CellStyle cellStyle_title = sheet.getWorkbook().createCellStyle();
        cellStyle_title.setAlignment(HorizontalAlignment.CENTER);
        cellStyle_title.setVerticalAlignment(VerticalAlignment.CENTER);
//            cellStyle_title.setFillForegroundColor(IndexedColors.YELLOW.index);
        cellStyle_title.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
        cellStyle_title.setFillPattern(SOLID_FOREGROUND);
        cellStyle_title.setBorderBottom(BorderStyle.THIN);
        cellStyle_title.setBorderLeft(BorderStyle.THIN);
        cellStyle_title.setBorderRight(BorderStyle.THIN);
        cellStyle_title.setBorderTop(BorderStyle.THIN);
        Font font_title = sheet.getWorkbook().createFont();
        font_title.setBold(Boolean.TRUE);
        font_title.setFontHeight((short) 480);
        font_title.setFontName("楷体");
        font_title.setColor(IndexedColors.ROYAL_BLUE.index);
        cellStyle_title.setFont(font_title);
        title_cell.setCellStyle(cellStyle_title);
        for (int i = 1; i < 19; i++) {
            Cell x = title.createCell(i);
            x.setCellStyle(cellStyle_title);
        }
        Row ttile_row = sheet.createRow(2);

        CellStyle border_title = sheet.getWorkbook().createCellStyle();
        border_title.setBorderBottom(BorderStyle.THIN);
        border_title.setBorderLeft(BorderStyle.THIN);
        border_title.setBorderRight(BorderStyle.THIN);
        border_title.setBorderTop(BorderStyle.THIN);
        Font font_title2 = sheet.getWorkbook().createFont();
        font_title2.setBold(Boolean.TRUE);
//        font_title2.setFontHeight((short) 480);
        font_title2.setFontName("楷体");
        border_title.setFont(font_title2);

        Cell cell_2_0 = ttile_row.createCell(0);
        cell_2_0.setCellValue("累计排名");
        cell_2_0.setCellStyle(border_title);
        Cell cell_2_1 = ttile_row.createCell(1);
        cell_2_1.setCellValue("编号");
        cell_2_1.setCellStyle(border_title);
        Cell cell_2_2 = ttile_row.createCell(2);
        cell_2_2.setCellValue("客户名");
        cell_2_2.setCellStyle(border_title);
        Cell cell_2_3 = ttile_row.createCell(3);
        cell_2_3.setCellValue("素材名");
        cell_2_3.setCellStyle(border_title);
        Cell cell_2_4 = ttile_row.createCell(4);
        cell_2_4.setCellValue("行业");
        cell_2_4.setCellStyle(border_title);
        Cell cell_2_5 = ttile_row.createCell(5);
        cell_2_5.setCellValue("需求部门");
        cell_2_5.setCellStyle(border_title);
        Cell cell_2_6 = ttile_row.createCell(6);
        cell_2_6.setCellValue("优化师");
        cell_2_6.setCellStyle(border_title);
        Cell cell_2_7 = ttile_row.createCell(7);
        cell_2_7.setCellValue("视频类型");
        cell_2_7.setCellStyle(border_title);
        Cell cell_2_8 = ttile_row.createCell(8);
        cell_2_8.setCellValue("成片日期");
        cell_2_8.setCellStyle(border_title);
        Cell cell_2_9 = ttile_row.createCell(9);
        cell_2_9.setCellValue("创意");
        cell_2_9.setCellStyle(border_title);
        Cell cell_2_10 = ttile_row.createCell(10);
        cell_2_10.setCellValue("摄像");
        cell_2_10.setCellStyle(border_title);
        Cell cell_2_11 = ttile_row.createCell(11);
        cell_2_11.setCellValue("剪辑");
        cell_2_11.setCellStyle(border_title);
        Cell cell_2_12 = ttile_row.createCell(12);
        cell_2_12.setCellValue("演员");
        cell_2_12.setCellStyle(border_title);
        Cell cell_2_13 = ttile_row.createCell(13);
        cell_2_13.setCellValue("");
        cell_2_13.setCellStyle(border_title);
//        Cell cell_2_14 = ttile_row.createCell(14);
//        cell_2_14.setCellValue("演员3");
//        cell_2_14.setCellStyle(border_title);
        Cell cell_2_15 = ttile_row.createCell(14);
        cell_2_15.setCellValue("当日消耗");
        cell_2_15.setCellStyle(border_title);
        Cell cell_2_16 = ttile_row.createCell(15);
        cell_2_16.setCellValue("累计消耗");
        cell_2_16.setCellStyle(border_title);
//        Cell cell_2_17 = ttile_row.createCell(17);
//        cell_2_17.setCellValue("累计排名");
//        cell_2_17.setCellStyle(border_title);
        Cell cell_2_18 = ttile_row.createCell(16);
        cell_2_18.setCellValue("消耗日期");
        cell_2_18.setCellStyle(border_title);
        List<VideoCost> videoCosts = videoCostMapper.selectWithCount(map);
        if (videoCosts != null) {
            sheet.setColumnWidth(2, 4000);
            sheet.setColumnWidth(8, 4000);
            sheet.setColumnWidth(14, 4000);
            sheet.setColumnWidth(15, 4000);
            sheet.setColumnWidth(16, 4000);


            CellStyle cellStyle_date = sheet.getWorkbook().createCellStyle();
            DataFormat format = sheet.getWorkbook().createDataFormat();
            cellStyle_date.setDataFormat(format.getFormat("yyyy/MM/dd"));
            cellStyle_date.setBorderBottom(BorderStyle.THIN);
            cellStyle_date.setBorderLeft(BorderStyle.THIN);
            cellStyle_date.setBorderRight(BorderStyle.THIN);
            cellStyle_date.setBorderTop(BorderStyle.THIN);
            CellStyle cellStyle_money = sheet.getWorkbook().createCellStyle();
            //  DataFormat money_format= sheet.getWorkbook().createDataFormat();
            cellStyle_money.setDataFormat(format.getFormat("￥###0.00"));
            cellStyle_money.setBorderBottom(BorderStyle.THIN);
            cellStyle_money.setBorderLeft(BorderStyle.THIN);
            cellStyle_money.setBorderRight(BorderStyle.THIN);
            cellStyle_money.setBorderTop(BorderStyle.THIN);

            CellStyle cellStyle_txt = sheet.getWorkbook().createCellStyle();
            //  DataFormat money_format= sheet.getWorkbook().createDataFormat();
            cellStyle_txt.setDataFormat(format.getFormat("0"));
            cellStyle_txt.setBorderBottom(BorderStyle.THIN);
            cellStyle_txt.setBorderLeft(BorderStyle.THIN);
            cellStyle_txt.setBorderRight(BorderStyle.THIN);
            cellStyle_txt.setBorderTop(BorderStyle.THIN);

            CellStyle border_red = sheet.getWorkbook().createCellStyle();
            border_red.setBorderBottom(BorderStyle.THIN);
            border_red.setBorderLeft(BorderStyle.THIN);
            border_red.setBorderRight(BorderStyle.THIN);
            border_red.setBorderTop(BorderStyle.THIN);
            Font font_red = sheet.getWorkbook().createFont();
            font_red.setBold(Boolean.TRUE);
            font_red.setFontName("楷体");
            font_red.setColor(IndexedColors.RED.index);
            border_red.setFont(font_red);

            CellStyle border = sheet.getWorkbook().createCellStyle();
            border.setBorderBottom(BorderStyle.THIN);
            border.setBorderLeft(BorderStyle.THIN);
            border.setBorderRight(BorderStyle.THIN);
            border.setBorderTop(BorderStyle.THIN);

            for (int i = 0; i < videoCosts.size(); i++) {
                Row data_row = sheet.createRow(i + 3);
                VideoCost videoCost = videoCosts.get(i);
                if (videoCost == null) continue;
                Cell cell_i_0 = data_row.createCell(0);
                cell_i_0.setCellStyle(border);
                Cell cell_i_1 = data_row.createCell(1);
                cell_i_1.setCellStyle(cellStyle_txt);
                Cell cell_i_2 = data_row.createCell(2);
                cell_i_2.setCellStyle(border);
                Cell cell_i_3 = data_row.createCell(3);
                cell_i_3.setCellStyle(border);
                Cell cell_i_4 = data_row.createCell(4);
                cell_i_4.setCellStyle(border);
                Cell cell_i_5 = data_row.createCell(5);
                cell_i_5.setCellStyle(border);
                Cell cell_i_6 = data_row.createCell(6);
                cell_i_6.setCellStyle(border);
                Cell cell_i_7 = data_row.createCell(7);
                cell_i_7.setCellStyle(border);
                Cell cell_i_8 = data_row.createCell(8);
                cell_i_8.setCellStyle(cellStyle_date);
                Cell cell_i_9 = data_row.createCell(9);
                cell_i_9.setCellStyle(border);
                Cell cell_i_10 = data_row.createCell(10);
                cell_i_10.setCellStyle(border);
                Cell cell_i_11 = data_row.createCell(11);
                cell_i_11.setCellStyle(border);
                Cell cell_i_12 = data_row.createCell(12);
                cell_i_12.setCellStyle(border);
                Cell cell_i_13 = data_row.createCell(13);
                cell_i_13.setCellStyle(border);
                Cell cell_i_14 = data_row.createCell(14);
                cell_i_14.setCellStyle(cellStyle_money);
                Cell cell_i_15 = data_row.createCell(15);
                cell_i_15.setCellStyle(cellStyle_money);
                Cell cell_i_16 = data_row.createCell(16);
                cell_i_16.setCellStyle(cellStyle_date);
//                Cell cell_i_17 = data_row.createCell(17);
//                cell_i_17.setCellStyle(border);
//                Cell cell_i_18 = data_row.createCell(18);
//                cell_i_18.setCellStyle(cellStyle_date);

                if (videoCost.getCumulativeConsumptionRankingByProglam() != null) cell_i_0.setCellValue(videoCost.getCumulativeConsumptionRankingByProglam());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getCode() != null) cell_i_1.setCellValue(videoCost.getCustomer().getCode());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getTrueCustomer()!=null  ) cell_i_2.setCellValue(videoCost.getCustomer().getTrueCustomer().getName());
                if (videoCost.getCustomer() != null  ) cell_i_3.setCellValue(videoCost.getCustomer().getName());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getIndustry() != null) cell_i_4.setCellValue(videoCost.getCustomer().getIndustry().getName());
                if (videoCost.getDemandSector() != null) cell_i_5.setCellValue(videoCost.getDemandSector().getName());
                if (videoCost.getOptimizer() != null) cell_i_6.setCellValue(videoCost.getOptimizer().getName());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getVideoType() != null) cell_i_7.setCellValue(videoCost.getCustomer().getVideoType().getName());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getCompleteDate() != null) cell_i_8.setCellValue(videoCost.getCustomer().getCompleteDate());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getOriginality() != null) cell_i_9.setCellValue(videoCost.getCustomer().getOriginality().getName());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getPhotographer() != null) cell_i_10.setCellValue(videoCost.getCustomer().getPhotographer().getName());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getEditor() != null) cell_i_11.setCellValue(videoCost.getCustomer().getEditor().getName());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getPerformer1() != null) cell_i_12.setCellValue(videoCost.getCustomer().getPerformer1().getName());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getPerformer2() != null) cell_i_13.setCellValue(videoCost.getCustomer().getPerformer2().getName());
//                if (videoCost.getCustomer() != null && videoCost.getCustomer().getPerformer3() != null) cell_i_14.setCellValue(videoCost.getCustomer().getPerformer3().getName());
                if (videoCost.getConsumption() != null) cell_i_14.setCellValue(videoCost.getConsumption());
                if (videoCost.getCumulativeConsumptionByPro() != null) cell_i_15.setCellValue(videoCost.getCumulativeConsumptionByPro());
//                if (videoCost.getCumulativeConsumptionRankingByProglam() != null) cell_i_17.setCellValue(videoCost.getCumulativeConsumptionRankingByProglam());
                if (videoCost.getRecoredDate() != null) cell_i_16.setCellValue(videoCost.getRecoredDate());

            }
        }
        Sheet condition = workbook.createSheet("导出条件");
        condition.setColumnWidth(0, 6000);
        Row row1 = condition.createRow(0);
        condition.addMergedRegion(new CellRangeAddress(0, 0, 0, 4));
        condition.addMergedRegion(new CellRangeAddress(1, 1, 1, 4));
        condition.addMergedRegion(new CellRangeAddress(2, 2, 1, 4));
        condition.addMergedRegion(new CellRangeAddress(3, 3, 1, 4));
        condition.addMergedRegion(new CellRangeAddress(4, 4, 1, 4));

        for (int i = 0; i < 5; i++) {
            Cell x = row1.createCell(i);
            x.setCellStyle(cellStyle_title);
            if (i == 0) x.setCellValue("查询条件");
        }
        Row row2 = condition.createRow(1);
        row2.createCell(0).setCellValue("关键字：");
        try {
            row2.createCell(1).setCellValue(map.get("KeyWord") == null ? "" : (String) map.get("KeyWord"));
        } catch (Exception e) {
            // e.printStackTrace();
        }

        Row row3 = condition.createRow(2);
        row3.createCell(0).setCellValue("最小当日消耗：");
        row3.createCell(1).setCellValue(map.get("consumption_min") == null ? "" : map.get("consumption_min").toString());

        Row row4 = condition.createRow(3);
        row4.createCell(0).setCellValue("最大当日消耗：");
        row4.createCell(1).setCellValue(map.get("consumption_max") == null ? "" : map.get("consumption_max").toString());

        Row row5 = condition.createRow(4);
        row5.createCell(0).setCellValue("消耗日期起始：");
        row5.createCell(1).setCellValue(map.get("recoredDate_start") == null ? "" : map.get("recoredDate_start").toString());

        Row row6 = condition.createRow(5);
        row6.createCell(0).setCellValue("消耗日期结束：");
        row6.createCell(1).setCellValue(map.get("recoredDate_end") == null ? "" : map.get("recoredDate_end").toString());

        Row row7 = condition.createRow(6);
        row7.createCell(0).setCellValue("完成日期起始：");
        row7.createCell(1).setCellValue(map.get("completeDate_start") == null ? "" : map.get("completeDate_start").toString());

        Row row8 = condition.createRow(7);
        row8.createCell(0).setCellValue("完成日期结束：");
        row8.createCell(1).setCellValue(map.get("completeDate_end") == null ? "" : map.get("completeDate_end").toString());

        Row row9 = condition.createRow(8);
        row9.createCell(0).setCellValue("起始行：");
        row9.createCell(1).setCellValue(map.get("offset") == null ? "" : map.get("offset").toString());

        Row row10 = condition.createRow(9);
        row10.createCell(0).setCellValue("结束行：");
        row10.createCell(1).setCellValue(map.get("limit") == null ? "" : map.get("limit").toString());

        Row row11 = condition.createRow(10);
        row11.createCell(0).setCellValue("排序：");
        row11.createCell(1).setCellValue(map.get("sort") == null ? "" : map.get("sort").toString());

        Row row12 = condition.createRow(11);
        row12.createCell(0).setCellValue("排序方式：");
        row12.createCell(1).setCellValue(map.get("order") == null ? "" : ("desc".equalsIgnoreCase(map.get("order").toString()) ? "逆序" : "正序"));


        return workbook;
    }

    private Object getCellValue(Cell cell) {
        if(cell==null)return null;
        cell.setCellType(CellType.STRING);
        CellType cellType = cell.getCellTypeEnum();
        Object value = null;
        switch (cellType) {
            case STRING:
                value = cell.getStringCellValue();
                break;
            case NUMERIC:
                value = cell.getNumericCellValue();
//                value = cell.getStringCellValue();
                break;
//            case BOOLEAN:
//                value = cell.getBooleanCellValue();
//                break;
//            case FORMULA:
//                value = cell.getNumericCellValue();
//                break;
        }
        return value;
    }

    private <T extends Model> T checkCodeOrName(List<T> models, String code,String name) {
        T t = checkCode(models,code);
        if (t==null)t=checkName(models,name);
        return t;
    }
    private <T extends Model> T checkName(List<T> models, String name) {
        return checkNameWithMethodName(models, name, "getName");
    }
    private <T extends Model> T checkCode(List<T> models, String name) {
        return checkNameWithMethodName(models, name, "getCode");
    }

    private <T extends Model> T checkSimpleName(List<T> models, String name) {
        return checkNameWithMethodName(models, name, "getSimpleNames");
    }
    private TrueCustomer checkTrueCustomer(List<TrueCustomer> trueCustomers,String customerName ){
        if(StringUtils.hasText(customerName) && trueCustomers!=null && trueCustomers.size()>0 ){
            synchronized (trueCustomers){
                for(TrueCustomer trueCustomer:trueCustomers){
                    if(trueCustomer!=null &&  StringUtils.hasText(trueCustomer.getName()) && customerName.toUpperCase().contains(trueCustomer.getName().toUpperCase())  ) return trueCustomer;
                }
            }
        }
        return null;
    }
    private <T extends Model> T checkNameWithMethodName(List<T> models, String name, String methodName) {
        try {
            synchronized (models) {
                for (T model : models) {
                    if (model == null || name == null || name.trim().equals("")) return null;
                    Method method = model.getClass().getMethod(methodName);
                    String old_name = (String) method.invoke(model);
                    //logger.info("比较名称："+old_name+"\t"+name+"\t"+name.equals(old_name));
                    if (name.equals(old_name)) return model;
                }
            }
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Page<VideoCost> selectWithCount(Page<VideoCost> pages, Map<String, Object> map) {
        List<VideoCost> videoCosts = videoCostMapper.selectWithCount(map);
        int total = videoCostMapper.selectCountTotal(map);
        pages.setRecords(videoCosts);
        pages.setTotal(total);
        return pages;
    }

    @Override
    public double sumConsumption(Map<String, Object> map) {
        Double sum = videoCostMapper.sumConsumption(map);
        if (sum == null) sum = 0.00;
        return sum;
    }

    @Override
    public int selectCount(Date recoredDate, Long customerId,ShiroUser user) {
        Map map = new HashMap();
        if (recoredDate != null) {
            map.put("recoredDate_start", recoredDate);
            map.put("recoredDate_end", recoredDate);
        }
        if (customerId != null) map.put("customerId", customerId);
        Set<String> roles = user.getRoles();
        if(!roles.contains(Const.Administor_Role_Name)  && !roles.contains(Const.OptimizerAdministorCN)  )map.put("userId",user.getId());
        if(roles.contains(Const.OptimizerCN) && !roles.contains(Const.OptimizerAdministorCN)  && !roles.contains(Const.Administor_Role_Name)  )map.put(Const.Optimizer,user.getName());
        Integer x = videoCostMapper.selectCountTotal(map);
        if (x == null) x = 0;
        return x;
    }

    @Override
    public VideoCost selectByPrimaryKey(Long id) {
        Map map = new HashMap();
        map.put("videoCostId", id);
        List<VideoCost> videoCosts = videoCostMapper.selectWithCount(map);
        if (videoCosts != null && videoCosts.size() == 1) return videoCosts.get(0);
        return null;
    }

    @Override
    public double selectMaxConsumption(ShiroUser user) {
        Long userId =null;
        String optimizer = null;
        Set<String> roles = user.getRoles();
        if(!roles.contains(Const.Administor_Role_Name)  && !roles.contains(Const.OptimizerAdministorCN)  )userId=user.getId();
        if(roles.contains(Const.OptimizerCN) && !roles.contains(Const.OptimizerAdministorCN)  && !roles.contains(Const.Administor_Role_Name)  )optimizer = user.getName();
        Double d = videoCostMapper.selectMaxConsumption(userId,optimizer);
        if (d != null) return d;
        return 0;
    }

    @Override
    public Map selectDataForListPage(Map<String, Object> map) {

        return videoCostMapper.selectDataForListPage(map);
    }

    public static boolean sql_inj(String str) {
        String inj_str = "'|and|exec|insert|select|delete|update|count|*|%|chr|mid|master|truncate|char|declare|;|or|-|+|,";
        String inj_stra[] = StringUtils.split(inj_str, "|");
        for (int i = 0; i < inj_stra.length; i++) {
            if (str.indexOf(inj_stra[i]) >= 0) {
                return true;
            }
        }
        return false;
    }


}
