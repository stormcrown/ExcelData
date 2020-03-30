package cn.dovahkiin.service;

import cn.dovahkiin.model.Supplier;
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
public interface ISupplierService extends IService<Supplier> {
    int insertWithConfig(Supplier supplier,Long userId);
    int toggleBySystemConfigIds( List<Long> systemConfigIds, int deleteFlag);
}
