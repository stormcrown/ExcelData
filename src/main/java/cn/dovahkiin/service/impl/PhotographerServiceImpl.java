package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.Photographer;
import cn.dovahkiin.mapper.PhotographerMapper;
import cn.dovahkiin.service.IPhotographerService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 摄像师信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Service
public class PhotographerServiceImpl extends ServiceImpl<PhotographerMapper, Photographer> implements IPhotographerService {
	
}
