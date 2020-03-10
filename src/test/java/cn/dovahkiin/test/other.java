package cn.dovahkiin.test;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.model.Industry;
import org.junit.Test;

import java.util.Date;

public class other {
    @Test
    public void tetss(){
        Object j = new Object();
        Industry industry1 = new Industry();
        industry1.CreateCode();

        Industry industry2 = new Industry();
        industry2.CreateCode();
        System.out.println(industry1 == industry2);
        System.out.println(industry1.hashCode()+"\t"+industry2.hashCode());


    }
}
