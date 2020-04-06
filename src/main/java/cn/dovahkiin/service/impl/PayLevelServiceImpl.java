package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.PayLevel;
import cn.dovahkiin.mapper.PayLevelMapper;
import cn.dovahkiin.service.IPayLevelService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author lzt
 * @since 2020-03-27
 */
@Service
public class PayLevelServiceImpl extends ServiceImpl<PayLevelMapper, PayLevel> implements IPayLevelService {
    private PayLevelMapper payLevelMapper;
    @Override
    public int updateByPrimaryKey(PayLevel record) {
        return payLevelMapper.updateByPrimaryKey(record);
    }

    @Autowired
    public void setPayLevelMapper(PayLevelMapper payLevelMapper) {
        this.payLevelMapper = payLevelMapper;
    }
}
