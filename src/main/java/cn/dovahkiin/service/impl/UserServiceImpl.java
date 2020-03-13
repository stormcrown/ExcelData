package cn.dovahkiin.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.commons.utils.BeanUtils;
import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.mapper.UserMapper;
import cn.dovahkiin.mapper.UserRoleMapper;
import cn.dovahkiin.model.User;
import cn.dovahkiin.model.UserRole;
import cn.dovahkiin.model.vo.UserVo;
import cn.dovahkiin.service.IUserService;

/**
 *
 * User 表数据服务层接口实现类
 *
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;
    
    @Override
    public UserVo selectByLoginName(UserVo userVo) {
        return userMapper.selectUserVoById(userVo.getId(),userVo.getLoginName());
    }

    @Override
    public UserVo selectByLoginName(String loginName) {
        return userMapper.selectUserVoById(null,loginName);
    }

    @Override
    public int checkUserName(Long selfId, String loginName) {
        return userMapper.checkLoginName(selfId,loginName);
    }

    @Override
    public void insertByVo(UserVo userVo) {
        User user = BeanUtils.copy(userVo, User.class);
        user.setCreateTime(new Date());
        userMapper.insertAll(user);
        Long id = user.getId();
        String[] roles = userVo.getRoleIds().split(",");
        UserRole userRole = new UserRole();
        for (String string : roles) {
            userRole.setUserId(id);
            userRole.setRoleId(Long.valueOf(string));
            userRoleMapper.insert(userRole);
        }
    }

    @Override
    public UserVo selectVoById(Long id) {
        return userMapper.selectUserVoById(id,null);
    }

    @Override
    public void updateByVo(UserVo userVo) {
        User user = BeanUtils.copy(userVo, User.class);
        if (StringUtils.isBlank(user.getPassword())) user.setPassword(null);

//        this.updateById(user);
        userMapper.updateByPrimaryKey(user);
        
        Long id = userVo.getId();
        List<UserRole> userRoles = userRoleMapper.selectByUserId(id);
        if (userRoles != null && !userRoles.isEmpty()) {
            for (UserRole userRole : userRoles) {
                userRoleMapper.deleteById(userRole.getId());
            }
        }

        String[] roles = userVo.getRoleIds().split(",");
        UserRole userRole = new UserRole();
        for (String string : roles) {
            userRole.setUserId(id);
            userRole.setRoleId(Long.valueOf(string));
            userRoleMapper.insert(userRole);
        }
    }

    @Override
    public void updatePwdByUserId(Long userId, String md5Hex) {
        User user = new User();
        user.setId(userId);
        user.setPassword(md5Hex);
        this.updateById(user);
    }

    @Override
    public void selectDataGrid(PageInfo pageInfo) {
        Page<Map<String, Object>> page = new Page<Map<String, Object>>(pageInfo.getNowpage(), pageInfo.getSize());
        page.setOrderByField(pageInfo.getSort());
        page.setAsc(pageInfo.getOrder().equalsIgnoreCase("asc"));
        List<Map<String, Object>> list = userMapper.selectUserPage(page, pageInfo.getCondition());
        pageInfo.setRows(list);
        pageInfo.setTotal(page.getTotal());
    }

    @Override
    public void deleteUserById(Long id) {
        this.deleteById(id);
        userRoleMapper.deleteByUserId(id);
    }

}