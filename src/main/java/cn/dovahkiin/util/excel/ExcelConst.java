package cn.dovahkiin.util.excel;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Sheet;

public class ExcelConst {
    public static DataFormat getDataFormat(Sheet sheet){
        return sheet.getWorkbook().createDataFormat();
    }
    public static CellStyle getDateCellStyle(Sheet sheet){
        CellStyle cellStyle_date = sheet.getWorkbook().createCellStyle();
        cellStyle_date.setDataFormat(getDataFormat(sheet).getFormat("yyyy年MM月dd日"));
        return cellStyle_date;
    }
    public static CellStyle getMoneyCellStyle(Sheet sheet){
        CellStyle cellStyle_money = sheet.getWorkbook().createCellStyle();
        cellStyle_money.setDataFormat(getDataFormat(sheet).getFormat("￥###0.00"));
        return cellStyle_money;
    }

}
