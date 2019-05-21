package cn.dovahkiin.util;
import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Component;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.*;
public class ReadListenter<T>  extends AnalysisEventListener<T> {
    private List<T> data = new ArrayList<T>();
    private Class<T>  tClass;
    public ReadListenter(Class tClass) {
        this.tClass =tClass;
    }
    @Override
    public void invoke(Object object, AnalysisContext context) {
        if(tClass!=null){
            List<Field> fieldList = getAllFields(tClass);
            Map map =new HashMap();
            for(Field field:fieldList){
                ExcelProperty excelProperty = field.getAnnotation(ExcelProperty.class);
                if(excelProperty!=null){
                    int index = excelProperty.index();
                    if(object instanceof ArrayList  &&  ((ArrayList)object).size()>index ){
                        Object obj =((ArrayList)object).get(index);
                        if(obj instanceof String) obj= ((String) obj).trim();
                        map.put(field.getName(), obj);
                    }
                }
            }
            JSONObject jsonObject=(JSONObject)JSON.toJSON(map);
            data.add(jsonObject.toJavaObject(tClass) );
        }
    }
    private List<Field> getAllFields(Class<?> clazz){
        List<Field> fieldList = new ArrayList<Field>();
        ExeclIncludeFatherClassField fatherClassField= clazz.getAnnotation(ExeclIncludeFatherClassField.class);
        if(fatherClassField!=null){
            fieldList.addAll(getAllFields(clazz.getSuperclass()));
        }
        Field[] fields = clazz.getDeclaredFields();
        if(fields!=null) fieldList.addAll(Arrays.asList(fields));
        return fieldList;
    }
    public List<T> getData() {
        return data;
    }
    @Override
    public void doAfterAllAnalysed(AnalysisContext context) {
        try {
            InputStream in= context.getInputStream();
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}