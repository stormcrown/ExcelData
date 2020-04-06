package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.PriceLevel;
import cn.dovahkiin.mapper.PriceLevelMapper;
import cn.dovahkiin.service.IPriceLevelService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
@Service
public class PriceLevelServiceImpl extends ServiceImpl<PriceLevelMapper, PriceLevel> implements IPriceLevelService {
	private PriceLevelMapper priceLevelMapper;

    @Override
    public int updateByPrimaryKey(PriceLevel record) {
        return priceLevelMapper.updateByPrimaryKey(record);
    }

    @Autowired
    public void setPriceLevelMapper(PriceLevelMapper priceLevelMapper) {
        this.priceLevelMapper = priceLevelMapper;
    }
}
