package cn.dovahkiin.test;

import cn.dovahkiin.commons.converter.DateConverter;
import org.junit.Test;

import java.util.Date;

public class other {
    @Test
    public void tetss(){
        String Str = new String("Welcome to Tutorialspoint.com");

        System.out.print("Return Value :" );
        System.out.println(Str.matches("(.*)Tutorials(.*)"));

        System.out.print("Return Value :" );
        System.out.println(Str.matches("Tutorials"));

        System.out.print("Return Value :" );
        System.out.println(Str.matches("Welcome(.*)"));



        DateConverter dateConverter = new DateConverter();
        Date x=dateConverter.convert("2018.12.21");
        System.out.println(x);
    }
}
