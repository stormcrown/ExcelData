package cn.dovahkiin.test.base;

import cn.dovahkiin.mapper.CountMapper;
import com.alibaba.fastjson.JSON;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

public class TestVideocostDao extends BaseTest {
    @Autowired private CountMapper countMapper;
//    @Autowired
//    public void setCountMapper(CountMapper countMapper) {
//        this.countMapper = countMapper;
//    }

    @Test
    public void selectMaxCon(){
//        List<Map> data = countMapper.effCount1(60,100.00d);
//        logger.info(JSON.toJSONString(data));

    }

}
