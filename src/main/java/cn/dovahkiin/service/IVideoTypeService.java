package cn.dovahkiin.service;

import cn.dovahkiin.model.VideoType;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 产品类型信息 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-11-04
 */
public interface IVideoTypeService extends IService<VideoType> {
    @Override
    boolean insert(VideoType videoType);
}
