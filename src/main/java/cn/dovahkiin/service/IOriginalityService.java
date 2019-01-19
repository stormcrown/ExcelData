package cn.dovahkiin.service;

import cn.dovahkiin.model.Originality;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 创意师信息 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
public interface IOriginalityService extends IService<Originality> {
    @Override
    boolean insert(Originality originality);
}
