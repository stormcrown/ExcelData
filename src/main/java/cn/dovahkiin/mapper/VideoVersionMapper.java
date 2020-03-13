package cn.dovahkiin.mapper;

import cn.dovahkiin.model.VideoVersion;
import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
public interface VideoVersionMapper extends BaseMapper<VideoVersion> {
    int deleteByPrimaryKey(Long id);

    int insertSelective(VideoVersion record);

    VideoVersion selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(VideoVersion record);

    int updateByPrimaryKey(VideoVersion record);
}