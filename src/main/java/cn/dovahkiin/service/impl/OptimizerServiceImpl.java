package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.Editor;
import cn.dovahkiin.model.Optimizer;
import cn.dovahkiin.mapper.OptimizerMapper;
import cn.dovahkiin.service.IOptimizerService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 优化师信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Service
public class OptimizerServiceImpl extends ServiceImpl<OptimizerMapper, Optimizer> implements IOptimizerService {
    @Override
    @Transactional(propagation=Propagation.REQUIRES_NEW)
    public boolean insert(Optimizer optimizer){
        return super.insert(optimizer);
    }
}
