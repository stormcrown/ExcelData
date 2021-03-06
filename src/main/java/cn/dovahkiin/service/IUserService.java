package cn.dovahkiin.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.model.User;
import cn.dovahkiin.model.vo.UserVo;

/**
 *
 * User 表数据服务层接口
 *
 */
public interface IUserService extends IService<User> {

    UserVo selectByLoginName(UserVo userVo);
    UserVo selectByLoginName(String loginName);
    int checkUserName(Long selfId,String loginName);

    void insertByVo(UserVo userVo);

    UserVo selectVoById(Long id);

    void updateByVo(UserVo userVo);

    void updatePwdByUserId(Long userId, String md5Hex);

    void selectDataGrid(PageInfo pageInfo);

    void deleteUserById(Long id);
}