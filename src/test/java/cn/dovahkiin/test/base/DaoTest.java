package cn.dovahkiin.test.base;

import cn.dovahkiin.mapper.VideoCostMapper;
import cn.dovahkiin.model.VideoCost;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class DaoTest  extends BaseTest{
    @Autowired
    protected VideoCostMapper videoCostMapper;
    @Test
    public void seleectPage(){
        VideoCost videoCost = new VideoCost();
        //videoCost.setCustomerName("%白菜挖挖菌%");
        Map map = new HashMap(5);
        map.put("videoCost",videoCost);
        map.put("orderBy","");
        map.put("asc","asc");
        map.put("offset",1);
        map.put("limit",100);
        List<VideoCost> list= videoCostMapper.selectWithCount(map);
        Iterator is =list.iterator();
        while (is.hasNext()) System.out.println(is.next());
    }
    @Test
    public void seleectMaxCou(){
        double max = videoCostMapper.selectMaxConsumption(-1L,"sss");
        logger.info("MaxConsumption = "+max);
    }
    @Test
    public void testCount(){
        Map map = videoCostMapper.selectDataForListPage(new HashMap<String, Object>());
        logger.info(map);
    }
}
