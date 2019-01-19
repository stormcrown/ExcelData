package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.Editor;
import cn.dovahkiin.model.ProductType;
import cn.dovahkiin.mapper.ProductTypeMapper;
import cn.dovahkiin.service.IProductTypeService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 产品类型信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-04
 */
@Service
public class ProductTypeServiceImpl extends ServiceImpl<ProductTypeMapper, ProductType> implements IProductTypeService {
    @Override
    @Transactional(propagation=Propagation.REQUIRES_NEW)
    public boolean insert(ProductType productType){
        return super.insert(productType);
    }
}
