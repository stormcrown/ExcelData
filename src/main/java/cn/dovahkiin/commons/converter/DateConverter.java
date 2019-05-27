package cn.dovahkiin.commons.converter;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

@Component
public class DateConverter implements Converter<String, Date>  {
    protected static Log logger = LogFactory.getLog(DateConverter.class);
    private static final List<String> formarts = new ArrayList<String>(5);
    static{
        formarts.add("yyyy-MM");
        formarts.add("yyyy-MM-dd");
        formarts.add("yyyy年MM月dd日");
        formarts.add("yyyy-MM-dd hh:mm");
        formarts.add("yyyy-MM-dd hh:mm:ss");
        formarts.add("yyyy.MM.dd");
    }
    public Date convert(String source) {
        String value = source.trim();
        if ("".equals(value)) {
            return null;
        }
        if(source.matches("^\\d{4}-\\d{1,2}$")){
            return parseDate(source, formarts.get(0));
        }else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2}$")){
            return parseDate(source, formarts.get(1));
        }else if(source.matches("^\\d{4}年\\d{1,2}月\\d{1,2}日$")){
            return parseDate(source, formarts.get(2));
        }else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}$")){
            return parseDate(source, formarts.get(3));
        }else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}:\\d{1,2}$")){
            return parseDate(source, formarts.get(4));
        }else if(source.matches("^\\d{4}\\.\\d{1,2}\\.\\d{1,2}$")){
            return parseDate(source, formarts.get(5));
        }else if(source.matches("^\\d{5}$")){
            Calendar calendar = new GregorianCalendar(1900,0,-1);
            calendar.add(Calendar.DATE,Integer.parseInt(source));
            return calendar.getTime();
        }else if(source.matches("^\\d{5}\\.\\d{0,12}$")){
            Calendar calendar = new GregorianCalendar(1900,0,-1);
            Integer days = Integer.parseInt(source.substring(0,source.indexOf(".")));
            calendar.add(Calendar.DATE,days);
            Double seconds = Double.parseDouble(source.substring(source.indexOf("."))) * 24 * 60 * 60*1000 ;
            calendar.add(Calendar.MILLISECOND,seconds.intValue());
            logger.warn("警告：数字格式的日期，包含时分秒，会导致秒级误差；通常这种格式是Excl的日期格式，将Excel单元格设为字符可以避免这种情况！！");
            return calendar.getTime();
        }
        else {
            throw new IllegalArgumentException("日期不能识别 '" + source + "'");
        }
    }

    /**
     * 功能描述：格式化日期
     *
     * @param dateStr
     *            String 字符型日期
     * @param format
     *            String 格式
     * @return Date 日期
     */
    public  Date parseDate(String dateStr, String format) {
        Date date=null;
        try {
            DateFormat dateFormat = new SimpleDateFormat(format);
            date = (Date) dateFormat.parse(dateStr);
        } catch (Exception e) {
        }
        return date;
    }

}