package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.VideoVersion;
import cn.dovahkiin.mapper.VideoVersionMapper;
import cn.dovahkiin.service.IVideoVersionService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
@Service
public class VideoVersionServiceImpl extends ServiceImpl<VideoVersionMapper, VideoVersion> implements IVideoVersionService {
	
}
