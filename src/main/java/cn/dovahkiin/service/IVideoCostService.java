package cn.dovahkiin.service;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.commons.shiro.ShiroUser;
import cn.dovahkiin.model.VideoCost;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.ui.Model;

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
public interface IVideoCostService  {
    int insertMany(List<VideoCost> videoCostList);
    int updateByPrimaryKey(VideoCost videoCost);
    int deleteMany(String[] ids);
    int deleteManyForever(String[] ids);
    int saveExcel(Sheet sheet, Date recoredDate, DateConverter dateConverter, ShiroUser user);
    Workbook exportData(Map map,Workbook workbook);
    VideoCost selectByPrimaryKey(Long  id);
    Page<VideoCost> selectWithCount(Page<VideoCost> pages,Map<String , Object> map);
    double sumConsumption(Map<String , Object> map);
    int selectCount(Date recoredDate,Long customId,ShiroUser user);
    double selectMaxConsumption(ShiroUser user);
    Map selectDataForListPage(Map<String , Object> map);

}
