package cn.dovahkiin.service.impl;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.mapper.VideoCostPerformerMapper;
import cn.dovahkiin.model.*;
import cn.dovahkiin.mapper.VideoCostMapper;
import cn.dovahkiin.service.*;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
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
public class VideoCostServiceImpl extends ServiceImpl<VideoCostMapper, VideoCost> implements IVideoCostService {
    //  调用Dao失败回滚
    @Autowired private VideoCostMapper videoCostMapper;
    @Autowired private VideoCostPerformerMapper videoCostPerformerMapper;
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
//        return videoCostMapper.insertMany(videoCostList);
        return 0;
    }

    @Override
    @Transactional
    public List<VideoCost> countByCustomName() {
//        return videoCostMapper.countByCustomName();
        return null;
    }

    @Override
    @Transactional
    public boolean saveExcel(Sheet sheet,Date recoredDate,DateConverter dateConverter) {
        EntityWrapper un_delete = new EntityWrapper();
        List<Organization> organizations = iOrganizationService.selectList(un_delete);

        un_delete.eq("delete_flag",0);
        List<Customer> customers = customerService.selectList(un_delete);logger.info("customers="+customers.size());
        List<Editor> editors = editorService.selectList(un_delete);logger.info("editors="+editors.size());
        List<Industry> industries = iIndustryService.selectList(un_delete);logger.info("industries="+industries.size());
        List<Optimizer> optimizers = iOptimizerService.selectList(un_delete);logger.info("optimizers="+optimizers.size());
        List<Originality> originalities = iOriginalityService.selectList(un_delete);logger.info("originalities="+originalities.size());
        List<Performer> performers = performerService.selectList(un_delete);logger.info("performers="+performers.size());
        List<Photographer> photographers = iPhotographerService.selectList(un_delete);logger.info("photographers = "+photographers.size());
        List<ProductType> productTypes = iProductTypeService.selectList(un_delete);logger.info("productTypes = "+productTypes.size());
        List<VideoType> videoTypes = videoTypeService.selectList(un_delete);logger.info("videoTypes = "+videoTypes.size());

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

        return x>0 ? Boolean.TRUE: Boolean.FALSE;

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
       // int total = videoCostMapper.selectCount(map);
        pages.setRecords(videoCosts);
      //  pages.setTotal(total);
        return pages;
    }
    @Override
    public double selectMaxConsumption() {
        return videoCostMapper.selectMaxConsumption();
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
