package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.Editor;
import cn.dovahkiin.model.Originality;
import cn.dovahkiin.mapper.OriginalityMapper;
import cn.dovahkiin.service.IOriginalityService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 创意师信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Service
public class OriginalityServiceImpl extends ServiceImpl<OriginalityMapper, Originality> implements IOriginalityService {
    @Override
    @Transactional(propagation=Propagation.REQUIRES_NEW)
    public boolean insert(Originality originality){
        return super.insert(originality);
    }
}
