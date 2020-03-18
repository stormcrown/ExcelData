package cn.dovahkiin.mapper;

import cn.dovahkiin.model.SystemConfig;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
  *  Mapper 接口
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
public interface SystemConfigMapper extends BaseMapper<SystemConfig> {
    int insertI(SystemConfig systemConfig);
    SystemConfig selectByPrimaryKey(Long id);
    SystemConfig selectBySupplierId(@Param("supplierId") Long supplierId);
    List<SystemConfig> selectPageList(@Param("supplierId")Long supplierId,@Param("sort")String sort,@Param("order")String orderby,@Param("offset")Integer offset,@Param("limit")Integer limit );
    int selectTotal(@Param("supplierId")Long supplierId);

    int updateByPrimaryKey(SystemConfig systemConfig);

}