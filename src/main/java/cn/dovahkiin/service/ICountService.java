package cn.dovahkiin.service;

import cn.dovahkiin.model.Editor;
import cn.dovahkiin.model.dto.CusCheckConfig;
import cn.dovahkiin.model.dto.CustomerEffectDto;
import cn.dovahkiin.model.dto.EffectCountDto;
import cn.dovahkiin.model.dto.ModelCountDto;
import com.baomidou.mybatisplus.service.IService;
import org.apache.poi.ss.usermodel.Workbook;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 统计服务 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
public interface ICountService  {
    List<Map> count1(Map map);
    List<ModelCountDto> countByModel(Map map);
    Workbook handleModelCountToExcel(List<ModelCountDto> modelCountDtoList,String sort,String order);

    EffectCountDto countEffConTimeCut(Map map);

    Workbook handleEffConTimeToExcel(EffectCountDto effectCountDto,String sort,String order);


    List<CusCheckConfig> checkCusConfig();
}
