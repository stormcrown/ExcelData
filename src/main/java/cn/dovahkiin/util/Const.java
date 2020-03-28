package cn.dovahkiin.util;

import cn.dovahkiin.model.*;
import org.apache.poi.ss.usermodel.CellStyle;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Const {


    public static final String Administor_Role_Name = "admin";
    public static final String optimizerCN = "优化师";
    public static final String optimizerAdministorCN = "优化师管理员";
    public static final String optimizerStr = "optimizer";
    public static final String customerStr = "customer";
    public static final String customerId = "customerId";
    public static final String customerCode = "customerCode";
    public static final String supplierStr ="supplier";
    public static final String supplierName = "supplierName";
    public static final String supplierId = "supplierId";
    public static final String videoCostStr = "videoCost";
    public static final String completeDate = "completeDate";
    public static final String recoredDate = "recoredDate";
    public static final String RECORED_DATE_START ="recoredDate_start";
    public static final String RECORED_DATE_END ="recoredDate_end";
    public static final String RECORED_DATE_Last ="recoredDate_last";
    public static final String consumption = "consumption"; // 当日消耗
    public static final String code = "code";
    public static final String name = "name";


    public static final SimpleDateFormat simDF = new SimpleDateFormat("yyyy-MM-dd") ;
    public static  Date date2010 = null;
    static {
        try {
            date2010 = simDF.parse("2010-01-01");
        } catch (Exception ignored){}
    }

    public static final String [] videoCostExcelHead  =new String[] { "排名","编号","客户名","视频名称","行业","需求部门","优化师","视频类型","成片日期","创意","摄像","剪辑",	"演员",	"价格分类",	"支出分类","视频版本",	"供应商","当日消耗", 	"消耗日期"};
    public enum VCostEnum{
        CustomerCode(1,String.class,code),
        TrueCustomName(2, TrueCustomer.class,"customer.trueCustomer"),
        CustomerName(3, String.class,name),
        IndustryName(4, cn.dovahkiin.model.Industry.class,""),
        OrganizationName(5, Organization.class,""),
        OptimizerName(6, Optimizer.class,""),
        VideoTypeName(7, VideoType.class,""),
        CompleteName(8, Date.class,completeDate),
        OriginalityName(9,Originality.class,""),
        PhotographerName(10,Photographer.class,""),
        EditorName(11,Editor.class,""),
        Performer1Name(12,Performer.class,""),
//        Performer2Name(13,Performer.class,""),
//        Performer3Name(14,Performer.class,""),
        PriceLevelName(13,PriceLevel.class,""),
        PayLevelName(14,PayLevel.class,""),
        VideoVersionName(15,VideoVersion.class,""),
        SupplierName(16,Supplier.class,""),

        ConsumptionName(17,Double.class,consumption),
        ReCoredDateName(18,Date.class,recoredDate),

        ;
        private int excelIndex;
        private Class typee;
        private String proName;
        VCostEnum(int excelIndex, Class typee,String proName) {
            this.excelIndex = excelIndex;
            this.typee = typee;
            this.proName =proName;
        }

        public int getExcelIndex() { return excelIndex; }
        public Class getTypee() { return typee; }
        public String getProName() { return proName; }

        public static VCostEnum getByIndex(int index){
            switch (index){
                case 1:return VCostEnum.CustomerCode;
                case 2:return VCostEnum.TrueCustomName;
                case 3:return VCostEnum.CustomerName;
                case 4:return VCostEnum.IndustryName;
                case 5:return VCostEnum.OrganizationName;
                case 6:return VCostEnum.OptimizerName;
                case 7:return VCostEnum.VideoTypeName;
                case 8:return VCostEnum.CompleteName;
                case 9:return VCostEnum.OriginalityName;
                case 10:return VCostEnum.PhotographerName;
                case 11:return VCostEnum.EditorName;
                case 12:return VCostEnum.Performer1Name;
//                case 13:return VCostEnum.Performer2Name;
//                case 14:return VCostEnum.Performer3Name;
                case 13:return VCostEnum.PriceLevelName;
                case 14:return VCostEnum.PayLevelName;
                case 15:return VCostEnum.VideoVersionName;
                case 16:return VCostEnum.SupplierName;
                case 17:return VCostEnum.ConsumptionName;
                case 18:return VCostEnum.ReCoredDateName;

                default:return null;
            }
        }

    }


}
