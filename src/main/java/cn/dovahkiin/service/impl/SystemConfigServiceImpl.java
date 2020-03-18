package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.SystemConfig;
import cn.dovahkiin.mapper.SystemConfigMapper;
import cn.dovahkiin.service.ISystemConfigService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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

    @Override
    public int insertI(SystemConfig systemConfig) {
        return systemConfigMapper.insertI(systemConfig);
    }

    @Override
    public SystemConfig selectByPrimaryKey(Long id) {
        return systemConfigMapper.selectByPrimaryKey(id);
    }

    @Override
    public SystemConfig selectBySupplierId(Long id) {
        return systemConfigMapper.selectBySupplierId(id);
    }

    @Override
    public List<SystemConfig> selectPageList(Long supplierId, String sort, String orderby, Integer offset, Integer limit) {
        return systemConfigMapper.selectPageList(supplierId, sort, orderby, offset, limit);
    }

    @Override
    public int selectTotal(Long supplierId) {
        return systemConfigMapper.selectTotal(supplierId);
    }

    @Override
    public int updateByPrimaryKey(SystemConfig systemConfig) {
        return systemConfigMapper.updateByPrimaryKey(systemConfig);
    }
}
