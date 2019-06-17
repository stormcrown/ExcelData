package cn.dovahkiin.mapper;

import cn.dovahkiin.model.VideoCost;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
/**
 * <p>
  * 视频成片消耗 Mapper 接口
 * </p>
 *
 * @author lzt
 * @since 2018-10-15
 */
public interface VideoCostMapper extends BaseMapper<VideoCost> {
    int insertMany(List<VideoCost> videoCostList);
    int updateByPrimaryKey(VideoCost videoCost);
    int deleteMany(String[] ids);
    int countUndeleted(String[] ids);
    int deleteManyForever(String[] ids);
    List<VideoCost> selectWithCount(Map<String ,Object> map);
    Integer selectCount(Map<String ,Object> map);
    Double selectMaxConsumption(@Param("userId")Long userId,@Param("optimizer")String optimizer);
    Double sumConsumption(Map<String , Object> map);
    Map selectDataForListPage(Map<String , Object> map);
//    List<VideoCost> countByCustomName();
}