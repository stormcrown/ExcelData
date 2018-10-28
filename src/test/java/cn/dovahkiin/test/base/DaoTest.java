package cn.dovahkiin.test.base;

import cn.dovahkiin.mapper.VideoCostMapper;
import cn.dovahkiin.model.VideoCost;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
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
//        List<VideoCost> list= videoCostMapper.selectWithCount(map);
        List<VideoCost> list= videoCostMapper.countByCustomName();
        EntityWrapper<VideoCost> ew = new EntityWrapper<VideoCost>(videoCost);
//        List<VideoCost> list= videoCostMapper.selectList(ew);
        Iterator is =list.iterator();
        while (is.hasNext()) System.out.println(is.next());

    }
}
