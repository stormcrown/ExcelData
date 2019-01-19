package cn.dovahkiin.test;

import cn.dovahkiin.model.TrueCustomer;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;

/**
 * @author 骆长涛
 * @DateTime 2018/11/30 14:18
 * @description
 */
public class TrueCustomerNameTest {
    public static final Log logger = LogFactory.getLog(TrueCustomerNameTest.class);

    @Test
    public void testname() {
        String[] names = new String[]{
                "每日优鲜89-单人口播水果",
                "淘宝返利07（1081951 3）",
                "淘宝返利07（OK1951 3）",
                "51信用卡03-银行贷款版"
                , "97淘"
                , "TuorABC-翻纸"
                , "TuorABC-翻纸"
                ,"陌陌001"
                ,"折800APP"
                ,"折800app"
                ,"腾讯WiFiAPP"

        };
        for (String str : names) {
          //  logger.info("素材名：" + str + "\t客户名：" + TrueCustomer.guessName(str));
        }


    }
}
