package cn.dovahkiin.service.impl;

import cn.dovahkiin.mapper.CountMapper;
import cn.dovahkiin.mapper.EditorMapper;
import cn.dovahkiin.model.Editor;
import cn.dovahkiin.service.ICountService;
import cn.dovahkiin.service.IEditorService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 统计服务
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Service
public class CountServiceImpl implements ICountService {
    @Autowired private CountMapper countMapper;
    @Override
    public List<Map> count1(Map map) {
        return countMapper.count1(map);
    }
}
