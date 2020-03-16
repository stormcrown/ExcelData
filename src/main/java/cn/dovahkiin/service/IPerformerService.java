package cn.dovahkiin.service;

import cn.dovahkiin.model.Performer;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 演员信息 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
public interface IPerformerService extends IService<Performer> {
    boolean insertTr(Performer performer);
}
