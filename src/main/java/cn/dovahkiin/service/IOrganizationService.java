package cn.dovahkiin.service;

import java.util.List;

import cn.dovahkiin.model.Optimizer;
import com.baomidou.mybatisplus.service.IService;
import cn.dovahkiin.commons.result.Tree;
import cn.dovahkiin.model.Organization;

/**
 *
 * Organization 表数据服务层接口
 *
 */
public interface IOrganizationService extends IService<Organization> {
    @Override
    boolean insert(Organization organization);
    List<Tree> selectTree();

    List<Organization> selectTreeGrid();

}