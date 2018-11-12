package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.Industry;
import cn.dovahkiin.mapper.IndustryMapper;
import cn.dovahkiin.service.IIndustryService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

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
	
}
