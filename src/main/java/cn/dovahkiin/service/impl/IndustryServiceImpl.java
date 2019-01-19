package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.Editor;
import cn.dovahkiin.model.Industry;
import cn.dovahkiin.mapper.IndustryMapper;
import cn.dovahkiin.service.IIndustryService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 行业信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-04
 */
@Service
public class IndustryServiceImpl extends ServiceImpl<IndustryMapper, Industry> implements IIndustryService {
    @Override
    @Transactional(propagation=Propagation.REQUIRES_NEW)
    public boolean insert(Industry industry){
        return super.insert(industry);
    }
}
