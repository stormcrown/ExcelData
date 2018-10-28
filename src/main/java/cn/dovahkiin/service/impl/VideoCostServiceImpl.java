package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.VideoCost;
import cn.dovahkiin.mapper.VideoCostMapper;
import cn.dovahkiin.service.IVideoCostService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 视频成片消耗 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-10-15
 */
@Service
public class VideoCostServiceImpl extends ServiceImpl<VideoCostMapper, VideoCost> implements IVideoCostService {
    @Autowired
    private VideoCostMapper videoCostMapper;
    public int insertMany(List<VideoCost> videoCostList){
        return videoCostMapper.insertMany(videoCostList);
    }

    @Override
    public List<VideoCost> countByCustomName() {
        return videoCostMapper.countByCustomName();
    }
}
