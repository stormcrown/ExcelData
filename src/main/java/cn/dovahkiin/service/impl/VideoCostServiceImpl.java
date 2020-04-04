package cn.dovahkiin.service.impl;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.commons.shiro.ShiroUser;
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
    @Autowired
    private ISupplierService iSupplierService;
    @Autowired
    private IVideoVersionService iVideoVersionService;
    @Autowired
    private IPriceLevelService iPriceLevelService;
    @Autowired
    private IPayLevelService iPayLevelService;
    @Autowired
    private DateConverter dateConverter;



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
    @Transactional
    public synchronized int handleExcelFile(List<ArrayList<Object>> excelDatas, Date recoredDate,ShiroUser shiroUser) {
        if(excelDatas==null || excelDatas.size()<1)return 0;
        ArrayList<Object> head = excelDatas.get(0);
        if(head==null || head.size()<Const.videoCostExcelHead.length)return 0;
        Date now = new Date();
        for(int i=0;i<Const.videoCostExcelHead.length;i++){
            if( StringUtils.isNotBlank(Const.videoCostExcelHead[i])  &&   !Const.videoCostExcelHead[i].equals(head.get(i)))throw new RuntimeException("模板错误第 "+(i+1)+"行 需要："+Const.videoCostExcelHead[i] +"，实际"+head.get(i) );
        }
        Supplier supplier = shiroUser.getSupplier();
        EntityWrapper un_delete = new EntityWrapper();
        List<Organization> organizations = iOrganizationService.selectList(un_delete);

        un_delete.eq("delete_flag", 0);
        List<Customer> customers = customerService.selectUnDeleted(null);
        List<Editor> editors = editorService.selectList(un_delete);
        Set<String> newEditorNames = new HashSet<>();
        List<Industry> industries = iIndustryService.selectList(un_delete);Set<String> newIndustries = new HashSet<>();
        List<Optimizer> optimizers = iOptimizerService.selectList(un_delete);Set<String> newOptimizers = new HashSet<>();
        List<Originality> originalities = iOriginalityService.selectList(un_delete);
        List<Performer> performers = performerService.selectList(un_delete);Set<String> newPerformers = new HashSet<>();
        List<Photographer> photographers = iPhotographerService.selectList(un_delete);Set<String> newPhotographers = new HashSet<>();
        //  List<ProductType> productTypes = iProductTypeService.selectList(un_delete);
        List<VideoType> videoTypes = videoTypeService.selectList(un_delete);Set<String> newVideoTypes = new HashSet<>();
        List<TrueCustomer> trueCustomers = trueCustomerService.selectList(un_delete);Set<String> newTrueCustomers = new HashSet<>();
        List<VideoVersion> videoVersionList = iVideoVersionService.selectList(un_delete);
        List<PriceLevel> priceLevelList = iPriceLevelService.selectList(un_delete);
        List<PayLevel> payLevelList = iPayLevelService.selectList(un_delete);
        List<Supplier> supplierList =  iSupplierService.selectList(un_delete);

        // 检测新增的普通字典类
        for (int i=1; i<excelDatas.size();i++){
            if(excelDatas.get(i)==null )continue;
              for(int j=0;j<Const.videoCostExcelHead.length;j++){
                  if(excelDatas.get(i).size()< j+1|| excelDatas.get(i).get(j)==null || "".equals(excelDatas.get(i).get(j)) )continue;
                  Object column =  excelDatas.get(i).get(j);
                  Const.VCostEnum vCostEnum = Const.VCostEnum.getByIndex(j);
                  if(vCostEnum==null)continue;;
                  // 组织
                  if( vCostEnum.getTypee() == Organization.class ) checkNameForNew(organizations, (String)column,"需求部门",true);
                   else if(vCostEnum.getTypee() == Industry.class) newIndustries.add(checkNameForNew ( industries,  (String)column));
                  else if(vCostEnum.getTypee()==TrueCustomer.class) newTrueCustomers.add(checkNameForNew(trueCustomers,(String)column));
                  else if(vCostEnum.getTypee() == Optimizer.class) newOptimizers.add(checkNameForNew(optimizers,(String)column));
                  else if(vCostEnum.getTypee() == VideoType.class) newVideoTypes.add(checkNameForNew(videoTypes,(String)column));
                  else if(vCostEnum.getTypee() == Originality.class) checkNameForNew(originalities,(String)column,"创意",true);
                  else if(vCostEnum.getTypee() == Photographer.class) newPhotographers.add(checkNameForNew(photographers,(String)column));
                  else if(vCostEnum.getTypee() == Editor.class) newEditorNames.add(checkNameForNew(editors,(String)column));
                  else if(vCostEnum.getTypee() == Performer.class) newPerformers.add(checkNameForNew(performers,(String)column));
                  else if(vCostEnum.getTypee() == PriceLevel.class) checkNameForNew(priceLevelList,(String)column,"收入价格分级", true );
                  else if(vCostEnum.getTypee() == PayLevel.class) checkNameForNew(payLevelList,(String)column,"支出价格分级",true);
                  else if(vCostEnum.getTypee() == VideoVersion.class) checkNameForNew(videoVersionList,(String)column,"视频版本",true);
                  else if(vCostEnum.getTypee() == Supplier.class && supplier==null ) checkNameForNew(supplierList,(String)column,"供应商",true);
              }
        }

        for(String str:newEditorNames){
            if(StringUtils.isBlank(str))continue;
            Editor editor = Editor.craateForInsert(str);
            boolean b= editorService.insert(editor);
            if(b)editors.add(editor);
        }
        for(String str:newIndustries){
            if(StringUtils.isBlank(str))continue;
            Industry industry = Industry.craateForInsert(str);
            boolean b= iIndustryService.insert(industry);
            if(b)industries.add(industry);
        }
        for(String str:newOptimizers){
            if(StringUtils.isBlank(str))continue;
            Optimizer optimizer = Optimizer.craateForInsert(str);
            boolean b= iOptimizerService.insert(optimizer);
            if(b)optimizers.add(optimizer);
        }
        for(String str:newPerformers){
            if(StringUtils.isBlank(str))continue;
            Performer performer = Performer.craateForInsert(str);
            boolean b= performerService.insert(performer);
            if(b)performers.add(performer);
        }
        for(String str:newPhotographers){
            if(StringUtils.isBlank(str))continue;
            Photographer photographer = Photographer.craateForInsert(str);
            boolean b= iPhotographerService.insert(photographer);
            if(b)photographers.add(photographer);
        }
        for(String str:newVideoTypes){
            if(StringUtils.isBlank(str))continue;
            VideoType videoType = VideoType.craateForInsert(str);
            boolean b= videoTypeService.insert(videoType);
            if(b)videoTypes.add(videoType);
        }
        for(String str:newTrueCustomers){
            if(StringUtils.isBlank(str))continue;
            TrueCustomer trueCustomer = TrueCustomer.craateForInsert(str);
            boolean b= trueCustomerService.insert(trueCustomer);
            if(b)trueCustomers.add(trueCustomer);
        }

        // 检测素材
        行:
        for(int i=1;i<excelDatas.size();i++){
            if(excelDatas.get(i)==null ||excelDatas.get(i).size()< Const.videoCostExcelHead.length )continue;
            Customer customer = new Customer();
            if(supplier!=null) customer.setSupplier(supplier);
            for(int j=0;j<Const.videoCostExcelHead.length;j++){
                if( excelDatas.get(i).get(j)==null || "".equals(excelDatas.get(i).get(j)) )continue;
                Object column =  excelDatas.get(i).get(j);
                Const.VCostEnum vCostEnum = Const.VCostEnum.getByIndex(j);
                if(vCostEnum==null)continue;
                if(vCostEnum.getTypee() == String.class && Const.code.equals(vCostEnum.getProName()) ) customer.setCode((String) column);
                else if(vCostEnum.getTypee() == String.class && Const.name.equals(vCostEnum.getProName()) ) customer.setName((String)column);
                else if(vCostEnum.getTypee() == Industry.class)customer.setIndustry(checkName(industries,(String)column));
                else if(vCostEnum.getTypee()==TrueCustomer.class)customer.setTrueCustomer(checkName(trueCustomers,(String)column));
                else if(vCostEnum.getTypee() == VideoType.class)customer.setVideoType(checkName(videoTypes,(String)column));
                else if(vCostEnum.getTypee() == Originality.class)customer.setOriginality(checkName(originalities,(String)column));
                else if(vCostEnum.getTypee() == Photographer.class)customer.setPhotographer(checkName(photographers,(String)column));
                else if(vCostEnum.getTypee() == Editor.class)customer.setEditor(checkName(editors,(String)column));
                else if(vCostEnum.getTypee() == Performer.class && vCostEnum.getExcelIndex() == 12 )customer.setPerformer1(checkName(performers,(String)column));
//                else if(vCostEnum.getTypee() == Performer.class && vCostEnum.getExcelIndex() == 13 )customer.setPerformer2(checkName(performers,(String)column));
//                else if(vCostEnum.getTypee() == Performer.class && vCostEnum.getExcelIndex() == 14 )customer.setPerformer3(checkName(performers,(String)column));
                else if(vCostEnum.getTypee() == PriceLevel.class)customer.setPriceLevel(checkName(priceLevelList,(String)column));
                else if(vCostEnum.getTypee() == PayLevel.class)customer.setPayLevel(checkName(payLevelList,(String)column));
                else if(vCostEnum.getTypee() == VideoVersion.class)customer.setVideoVersion(checkName(videoVersionList,(String)column));
                else if(vCostEnum.getTypee() == Supplier.class  ){
                    if(supplier==null) customer.setSupplier(checkName(supplierList,(String)column));
                    else customer.setSupplier(supplier);
                }
                else if(vCostEnum.getTypee() ==Date.class && Const.completeDate.equals(vCostEnum.getProName())  ){
                    try {
                        if(column instanceof Date || ( column!=null && column instanceof String && StringUtils.isNotBlank((String)column) )  ){
                            Date comple =null;
                            if(column instanceof Date && ((Date) column).after(Const.date2010) ){
                                customer.setCompleteDate((Date) column);
                            }else if( column!=null && column instanceof String && StringUtils.isNotBlank((String)column) ){
                                comple = dateConverter.convert((String)column);
                                customer.setCompleteDate(comple);
                            }
                        }
                    } catch (IllegalArgumentException e) {
                        throw new RuntimeException("第"+(i+1)+"行无法识别列“成片日期”：\n"+column);
                    }
                }
            }
            // 没有名字，没有编号 直接跳过
            if(customer.getCode()==null && customer.getName()==null)continue;;
            // 素材通过两个个字段确定，编码，名字，如果能对上就不检测其他字段， 版本如果不同就新增，
            // 编号没有，直接新增,保存
            if(customer.getCode()==null) customer.CreateCode();
            boolean isOldCustom = false;
            检测素材: // 不检测供应商字段，因为如果有用户是有供应商的话，一开始查的就书供应商的素材
            for(Customer customer1:customers){
                if(customer1.getCode().equals(customer.getCode()) ){
                    if(customer1.getName()!=null && customer1.getName().equals(customer.getName())){
                        if(customer.getVideoVersion() == null && customer1.getVideoVersion()==null){
                            isOldCustom=Boolean.TRUE;
                            break 检测素材;
                        }
                        else if(customer.getVideoVersion()!=null && customer1.getVideoVersion()!=null && customer1.getVideoVersion().getId().equals(customer.getVideoVersion().getId())){
                            isOldCustom=Boolean.TRUE;
                            break 检测素材;
                        }
                    }else{
                        StringBuilder stringBuilder = new StringBuilder("第");
                        stringBuilder.append(i+1).append(" 行，编码：").append(customer.getCode())
                                .append("对应的素材名：").append(customer.getName()).append(",与数据库中的素材名称：")
                                .append(customer1.getName()).append("编码：").append(customer1.getCode()).append("不一致");
                        throw new RuntimeException(stringBuilder.toString());
                    }
                }
            }
            // 不是新的，就新增
            if(!isOldCustom){
                customer.setDeleteFlag(0);
                customer.setCreateTime(now);
                customer.setUpdateTime(now);
                customerService.insert(customer);
                customers.add(customer);
            }
        }

        // 字典齐备，开始存消耗数据
        List<VideoCost> videoCostListInsert = new ArrayList<>(excelDatas.size());
        行:
        for(int i=1;i<excelDatas.size();i++){
            if(excelDatas.get(i)==null ||excelDatas.get(i).size()< Const.videoCostExcelHead.length )continue;
            VideoCost videoCost = new VideoCost(shiroUser.getId() ,now,shiroUser.getId(), now, 0, recoredDate);
            Customer customer = new Customer();
            格:
            for(int j=0;j<Const.videoCostExcelHead.length;j++){
                if( excelDatas.get(i).get(j)==null || "".equals(excelDatas.get(i).get(j)) )continue;
                Object column =  excelDatas.get(i).get(j);
                Const.VCostEnum vCostEnum = Const.VCostEnum.getByIndex(j);
                if(vCostEnum==null)continue;
                if(vCostEnum.getTypee() == Date.class && Const.recoredDate.equals(vCostEnum.getProName())){
                    try {
                        if(column instanceof Date || ( column!=null && column instanceof String && StringUtils.isNotBlank((String)column) )  ){
                            if(column instanceof Date && ((Date) column).after(Const.date2010) ){
                               videoCost.setRecoredDate((Date) column);
                            }else if( column!=null && column instanceof String && StringUtils.isNotBlank((String)column) ){
                                videoCost.setRecoredDate(dateConverter.convert((String)column));
                            }
                        }
                    } catch (IllegalArgumentException e) {
                        throw new RuntimeException("第"+(i+1)+"行无法识别列“消耗日期”：\n"+column);
                    }
                    if(videoCost.getRecoredDate()==null)throw new RuntimeException("第"+(i+1)+"行无法识别列“消耗日期”：\n"+column);
                }
                else if(vCostEnum.getTypee()==Double.class && Const.consumption.equals(vCostEnum.getProName())){
                    try {
                        if(StringUtils.isNotBlank(column.toString())) videoCost.setConsumption(Double.parseDouble(column.toString()));
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        throw new RuntimeException("第"+(i+1)+"行无法识别消耗量");
                    }
                }
                else if(vCostEnum.getTypee()==Organization.class) videoCost.setDemandSector(checkName(organizations ,(String)column));
                else if(vCostEnum.getTypee()== Optimizer.class) videoCost.setOptimizer(checkName(optimizers,(String)column));
                else if(vCostEnum.getTypee() == String.class && Const.code.equals(vCostEnum.getProName()) ) customer.setCode((String) column);
                else if(vCostEnum.getTypee() == String.class && Const.name.equals(vCostEnum.getProName()) ) {
                    if(StringUtils.isBlank((String)column))continue 行; // 素材没有名称，整行被放弃
                    customer.setName((String)column);
                }
                else if(vCostEnum.getTypee() == VideoVersion.class)customer.setVideoVersion(checkName(videoVersionList,(String)column));
            }
            // 素材
            for(Customer customer1:customers){
                boolean codeEq = Boolean.FALSE ;
                if(customer.getCode() ==null || customer.getCode().equals(customer1.getCode()))codeEq=Boolean.TRUE;
                boolean nameEq = Boolean.FALSE ;
                if(customer.getName()!=null && customer.getName().equals(customer1.getName()))nameEq = Boolean.TRUE;
                boolean vvEq = Boolean.FALSE ;
                if(customer.getVideoVersion() == null && customer1.getVideoVersion()==null)vvEq=Boolean.TRUE;
                else if(customer.getVideoVersion()!=null && customer1.getVideoVersion()!=null && customer.getVideoVersion().getId().equals(customer1.getVideoVersion().getId()))vvEq=Boolean.TRUE;

                if(codeEq && nameEq && vvEq)videoCost.setCustomer(customer1);
            }

            if(videoCost.getCustomer()==null)continue ;
            videoCostListInsert.add(videoCost);
        }
        int x=0;
        if(videoCostListInsert.size()>0) x = videoCostMapper.insertMany(videoCostListInsert);
        return x;
    }

    @Override
    @Transactional(readOnly = true)
    public Workbook exportData(Map map, Workbook workbook) {

        Sheet sheet = workbook.createSheet();
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 19));
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
        for (int i = 1; i < 20; i++) {
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
        cell_2_13.setCellValue("收入价格分级");
        cell_2_13.setCellStyle(border_title);

        Cell cell_2_pay = ttile_row.createCell(14);
        cell_2_pay.setCellValue("支出价格分级");
        cell_2_pay.setCellStyle(border_title);


        Cell cell_2_VVE = ttile_row.createCell(15);
        cell_2_VVE.setCellValue("视频版本");
        cell_2_VVE.setCellStyle(border_title);
        Cell cell_2_SUP = ttile_row.createCell(16);
        cell_2_SUP.setCellValue("供应商");
        cell_2_SUP.setCellStyle(border_title);
//        Cell cell_2_14 = ttile_row.createCell(14);
//        cell_2_14.setCellValue("演员3");
//        cell_2_14.setCellStyle(border_title);

        Cell cell_2_15 = ttile_row.createCell(17);
        cell_2_15.setCellValue("当日消耗");
        cell_2_15.setCellStyle(border_title);

        Cell cell_2_16 = ttile_row.createCell(18);
        cell_2_16.setCellValue("累计消耗");
        cell_2_16.setCellStyle(border_title);
//        Cell cell_2_17 = ttile_row.createCell(17);
//        cell_2_17.setCellValue("累计排名");
//        cell_2_17.setCellStyle(border_title);
        Cell cell_2_18 = ttile_row.createCell(19);
        cell_2_18.setCellValue("消耗日期");
        cell_2_18.setCellStyle(border_title);
        List<VideoCost> videoCosts = videoCostMapper.selectWithCount(map);
        if (videoCosts != null) {
            sheet.setColumnWidth(2, 4000);
            sheet.setColumnWidth(3, 2*4000);
            sheet.setColumnWidth(8, 4000);
            sheet.setColumnWidth(15, 4000);
            sheet.setColumnWidth(16, 4000);
            sheet.setColumnWidth(17, 4000);
            sheet.setColumnWidth(18, 4000);
            sheet.setColumnWidth(19, 4000);


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
                Cell cell_i_pay = data_row.createCell(14);
                cell_i_pay.setCellStyle(border);

                Cell cell_i_vve = data_row.createCell(15);
                cell_i_vve.setCellStyle(border);
                Cell cell_i_sup = data_row.createCell(16);
                cell_i_sup.setCellStyle(border);

                Cell cell_i_14 = data_row.createCell(17);
                cell_i_14.setCellStyle(cellStyle_money);
                Cell cell_i_15 = data_row.createCell(18);
                cell_i_15.setCellStyle(cellStyle_money);
                Cell cell_i_16 = data_row.createCell(19);
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
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getPriceLevel() != null) cell_i_13.setCellValue(videoCost.getCustomer().getPriceLevel().getName());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getPayLevel() != null) cell_i_pay.setCellValue(videoCost.getCustomer().getPayLevel().getName());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getVideoVersion()!= null) cell_i_vve.setCellValue(videoCost.getCustomer().getVideoVersion().getName());
                if (videoCost.getCustomer() != null && videoCost.getCustomer().getSupplier() != null) cell_i_sup.setCellValue(videoCost.getCustomer().getSupplier().getName());
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

//        Row row12 = condition.createRow(11);
//        row12.createCell(0).setCellValue("供应商：");


        Row row13 = condition.createRow(12);
        row13.createCell(0).setCellValue("排序方式：");
        row13.createCell(1).setCellValue(map.get("order") == null ? "" : ("desc".equalsIgnoreCase(map.get("order").toString()) ? "逆序" : "正序"));


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
    private String  checkNameForNew(List models, String name,String colmunName,boolean throwEx) {
        Object object= checkNameWithMethodName(models, name, "getName");
        if(object==null && throwEx)
            throw new RuntimeException( colmunName+ "不存在："+name);
        else if(object==null)return name;
        return null;
    }
    private String  checkNameForNew(List models, String name) {
        Object object= checkNameWithMethodName(models, name, "getName");
         if(object==null)return name;
        return null;
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
        if(!roles.contains(Const.Administor_Role_Name)  && !roles.contains(Const.optimizerAdministorCN)  )map.put("userId",user.getId());
        if(roles.contains(Const.optimizerCN) && !roles.contains(Const.optimizerAdministorCN)  && !roles.contains(Const.Administor_Role_Name)  )map.put(Const.optimizerStr,user.getName());
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
        if(!roles.contains(Const.Administor_Role_Name)  && !roles.contains(Const.optimizerAdministorCN)  )userId=user.getId();
        if(roles.contains(Const.optimizerCN) && !roles.contains(Const.optimizerAdministorCN)  && !roles.contains(Const.Administor_Role_Name)  )optimizer = user.getName();
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
            if (str.contains(inj_stra[i])) {
                return true;
            }
        }
        return false;
    }


}
