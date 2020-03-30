package cn.dovahkiin.service.impl;

import cn.dovahkiin.mapper.SystemConfigMapper;
import cn.dovahkiin.model.Supplier;
import cn.dovahkiin.mapper.SupplierMapper;
import cn.dovahkiin.model.SystemConfig;
import cn.dovahkiin.service.ISupplierService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
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
public class SupplierServiceImpl extends ServiceImpl<SupplierMapper, Supplier> implements ISupplierService {
    private SupplierMapper supplierMapper;
    private SystemConfigMapper systemConfigMapper;
    @Override
    @Transactional
    public int insertWithConfig(Supplier supplier,Long userId) {
        int insertSelective = supplierMapper.insertSelective(supplier);
        SystemConfig systemConfig = systemConfigMapper.selectBySupplierId(null);
        systemConfig.setSupplier(supplier);
        systemConfig.setUpdateBy(userId);
        systemConfig.setUpdateTime(new Date());
         systemConfigMapper.insertI(systemConfig);
        return insertSelective;
    }

    @Override @Transactional
    public int toggleBySystemConfigIds(List<Long> systemConfigIds, int deleteFlag) {
        List<Long> supplierIds = systemConfigMapper.selectSupplierIds(systemConfigIds);
        return supplierMapper.toggleByIds(supplierIds,deleteFlag);
    }

    @Autowired public void setSupplierMapper(SupplierMapper supplierMapper) { this.supplierMapper = supplierMapper; }
    @Autowired public void setSystemConfigMapper(SystemConfigMapper systemConfigMapper) { this.systemConfigMapper = systemConfigMapper; }
}
