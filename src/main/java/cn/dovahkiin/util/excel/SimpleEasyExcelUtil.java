
package cn.dovahkiin.util.excel;

import com.alibaba.excel.ExcelReader;
import com.alibaba.excel.support.ExcelTypeEnum;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.util.List;

/**
 * 简单的EasyUi工具类
 * 仅支持easyExcel的ExcelProperty 注解 和 ExeclIncludeFatherClassField 注解
 *
 * @description
 */
@Component
public class SimpleEasyExcelUtil<T> {
    public List<T> read(InputStream in, Class<T> tClass) {
        ReadListenter<T> readListenter = new ReadListenter<T>(tClass);
        ExcelReader reader = new ExcelReader(in, null, readListenter, true);
        reader.read();
        List<T> list = readListenter.getData();
        return list;
    }

    public List<T> readXLSX(InputStream in, Class<T> clazz) {
        ReadListenter<T> readListenter = new ReadListenter<T>(clazz);
        ExcelReader reader = new ExcelReader(in, ExcelTypeEnum.XLSX, readListenter, true);
        reader.read();
        List<T> list = readListenter.getData();
        return list;
    }

    public List<T> readXLS(InputStream in, Class<T> clazz) {
        ReadListenter<T> readListenter = new ReadListenter<T>(clazz);
        ExcelReader reader = new ExcelReader(in, ExcelTypeEnum.XLS, readListenter, true);
        reader.read();
        List<T> list = readListenter.getData();
        return list;
    }
}