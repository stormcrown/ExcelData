package cn.dovahkiin.service.impl;

import cn.dovahkiin.model.Editor;
import cn.dovahkiin.mapper.EditorMapper;
import cn.dovahkiin.model.TrueCustomer;
import cn.dovahkiin.service.IEditorService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 * 剪辑师信息 服务实现类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
@Service
public class EditorServiceImpl extends ServiceImpl<EditorMapper, Editor> implements IEditorService {
    @Override
    @Transactional(propagation=Propagation.REQUIRES_NEW)
    public boolean insert(Editor editor){
        return super.insert(editor);
    }
}
