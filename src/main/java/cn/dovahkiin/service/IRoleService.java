package cn.dovahkiin.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import cn.dovahkiin.commons.result.PageInfo;
import com.baomidou.mybatisplus.service.IService;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.model.Role;

/**
 *
 * Role 表数据服务层接口
 *
 */
public interface IRoleService extends IService<Role> {

    void selectDataGrid(PageInfo pageInfo);

    Object selectTree();

    List<Long> selectResourceIdListByRoleId(Long id);

    void updateRoleResource(Long id, String resourceIds);

    Map<String, Set<String>> selectResourceMapByUserId(Long userId);

}