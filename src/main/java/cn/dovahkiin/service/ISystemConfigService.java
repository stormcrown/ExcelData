package cn.dovahkiin.service;

import cn.dovahkiin.model.SystemConfig;
import com.baomidou.mybatisplus.service.IService;
import org.apache.ibatis.annotations.Param;

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
    List<SystemConfig> selectPageList(@Param("supplierId")Long supplierId, @Param("sort")String sort, @Param("order")String orderby, @Param("offset")Integer offset, @Param("limit")Integer limit );
    int selectTotal(@Param("supplierId")Long supplierId);

    int updateByPrimaryKey(SystemConfig systemConfig);
}
