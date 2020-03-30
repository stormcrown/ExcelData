package cn.dovahkiin.service;

import cn.dovahkiin.model.SystemConfig;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
public interface ISystemConfigService extends IService<SystemConfig> {
    int insertI(SystemConfig systemConfig);
    SystemConfig selectByPrimaryKey(Long id);
    SystemConfig selectBySupplierId(Long id);
    List<SystemConfig> selectPageList(SystemConfig systemConfig,Long supplierId, String sort, String orderby, Integer offset, Integer limit );
    int selectTotal(SystemConfig systemConfig,Long supplierId);

    int updateByPrimaryKey(SystemConfig systemConfig);
    int toggleBySupplierIds(List<Long> supplierIds,int deleteFlag ,Long userId);
}
