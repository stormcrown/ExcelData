package cn.dovahkiin.service;

import cn.dovahkiin.model.Industry;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 * 行业信息 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-11-04
 */
public interface IIndustryService extends IService<Industry> {
    @Override
    boolean insert(Industry industry);
}
