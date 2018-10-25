package cn.dovahkiin.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import cn.dovahkiin.commons.result.Tree;
import cn.dovahkiin.commons.shiro.ShiroUser;
import cn.dovahkiin.model.Resource;

/**
 *
 * Resource 表数据服务层接口
 *
 */
public interface IResourceService extends IService<Resource> {

    List<Resource> selectAll();

    List<Tree> selectAllMenu();

    List<Tree> selectAllTree();

    List<Tree> selectTree(ShiroUser shiroUser);

}