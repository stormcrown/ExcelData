package cn.dovahkiin.service;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.model.VideoCost;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import org.apache.poi.ss.usermodel.Sheet;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 视频成片消耗 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-10-15
 */
public interface IVideoCostService extends IService<VideoCost> {
    int insertMany(List<VideoCost> videoCostList);
    List<VideoCost> countByCustomName();
    boolean saveExcel(Sheet sheet,Date recoredDate,DateConverter dateConverter);
    Page<VideoCost> selectWithCount(Page<VideoCost> pages,Map<String , Object> map);
    double selectMaxConsumption();
}
