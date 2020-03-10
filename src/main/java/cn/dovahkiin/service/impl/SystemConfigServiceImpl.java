package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.SystemConfig;
import cn.dovahkiin.mapper.SystemConfigMapper;
import cn.dovahkiin.service.ISystemConfigService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
@Service
public class SystemConfigServiceImpl extends ServiceImpl<SystemConfigMapper, SystemConfig> implements ISystemConfigService {
	private SystemConfigMapper systemConfigMapper;
	@Autowired
    public void setSystemConfigMapper(SystemConfigMapper systemConfigMapper) {
        this.systemConfigMapper = systemConfigMapper;
    }

}
