package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.Performer;
import cn.dovahkiin.mapper.PerformerMapper;
import cn.dovahkiin.service.IPerformerService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 演员信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Service
public class PerformerServiceImpl extends ServiceImpl<PerformerMapper, Performer> implements IPerformerService {
	
}