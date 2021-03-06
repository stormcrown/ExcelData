package cn.dovahkiin.commons.utils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 骆长涛
 * @DateTime 2018/12/1 11:25
 * @description
 */
public class DateTools {
    public static final Log logger = LogFactory.getLog(DateTools.class);
    public static final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    public static final SimpleDateFormat TIMEFORMAT = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    public static String getDateTimeStr(Date date){return TIMEFORMAT.format(date);}
    /**
     * 获取两个日期之间的日期
     * @param start 开始日期
     * @param end 结束日期
     * @return 日期集合
     */
    public static List<Date> getBetweenDates(Date start, Date end) {
        if(start==null || end==null)return new ArrayList<>();
        if(start.after(end)){
            Date temp = start;
            start = end;
            end = temp;
        }
        List<Date> result = new ArrayList<Date>();
        Calendar tempStart = Calendar.getInstance();
        tempStart.setTime(start);
        Calendar tempEnd = Calendar.getInstance();
        tempEnd.setTime(end);
        while (tempStart.before(tempEnd)) {
            result.add(tempStart.getTime());
            tempStart.add(Calendar.DAY_OF_YEAR, 1);
        }
        result.add(end);
        return result;
    }

    public static Date firstDay(){
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH,1);
        return c.getTime();
    }
    public static Date firstDayD(Date date){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.set(Calendar.DAY_OF_MONTH,1);
        return c.getTime();
    }
    public static Date lastDate(){
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
        return c.getTime();
    }
    public static Date lastDateD(Date date){
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
        return c.getTime();
    }
}
