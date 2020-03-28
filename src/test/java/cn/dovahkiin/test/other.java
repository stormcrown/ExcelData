package cn.dovahkiin.test;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.commons.utils.DateTools;
import cn.dovahkiin.model.Industry;
import cn.dovahkiin.util.Const;
import org.junit.Test;

import java.text.ParseException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class other {
    @Test
    public void getDates()throws ParseException {
        Date start= Const.simDF.parse("2020-01-05");
        Date end = Const.simDF.parse("2020-01-02");
        List<Date> dateList= DateTools.getBetweenDates(start,end);
        for(int i=0;i<dateList.size();i++){
            System.out.println(Const.simDF.format(dateList.get(i)) );
        }
    }

}
