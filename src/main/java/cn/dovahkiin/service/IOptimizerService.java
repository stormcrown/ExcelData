package cn.dovahkiin.service;

import cn.dovahkiin.model.Optimizer;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 优化师信息 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
public interface IOptimizerService extends IService<Optimizer> {
    @Override
    boolean insert(Optimizer optimizer);
}
