package cn.dovahkiin.mapper;

import cn.dovahkiin.model.VideoCost;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
  * 视频成片消耗 Mapper 接口
 * </p>
 *
 * @author lzt
 * @since 2018-10-15
 */
public interface VideoCostMapper extends BaseMapper<VideoCost> {
    int insertMany(List<VideoCost> videoCostList);

}