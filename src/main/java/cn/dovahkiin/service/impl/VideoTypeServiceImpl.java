package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.VideoType;
import cn.dovahkiin.mapper.VideoTypeMapper;
import cn.dovahkiin.service.IVideoTypeService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 产品类型信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-04
 */
@Service
public class VideoTypeServiceImpl extends ServiceImpl<VideoTypeMapper, VideoType> implements IVideoTypeService {
	
}
