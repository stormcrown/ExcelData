package cn.dovahkiin.service;

import cn.dovahkiin.model.VideoCost;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;

/**
 * <p>
 * 视频成片消耗 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-10-15
 */
public interface IVideoCostService extends IService<VideoCost> {
    int insertMany(List<VideoCost> videoCostList);
    List<VideoCost> countByCustomName();
}
