package cn.dovahkiin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import cn.dovahkiin.util.Const;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.dovahkiin.commons.base.BaseController;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.commons.shiro.PasswordHash;
import cn.dovahkiin.commons.shiro.ShiroDbRealm;
import cn.dovahkiin.commons.utils.StringUtils;
import cn.dovahkiin.model.Role;
import cn.dovahkiin.model.User;
import cn.dovahkiin.model.vo.UserVo;
import cn.dovahkiin.service.IUserService;

/**
 * @description：用户管理
 * @author：zhixuan.wang
 * @date：2015/10/1 14:51
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
    @Autowired
    private IUserService userService;
    @Autowired
    private PasswordHash passwordHash;

    /**
     * 用户管理页
     *
     * @return
     */
    @GetMapping("/manager")
    @RequiresPermissions("/user/manager")
    public String manager() {
        return "admin/user/user";
    }

    /**
     * 用户管理列表
     *
     * @param userVo
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    @RequiresPermissions("/user/dataGrid")
    public Object dataGrid(UserVo userVo, Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        Map<String, Object> condition = new HashMap<String, Object>();

        if (StringUtils.isNotBlank(userVo.getName())) condition.put("name", userVo.getName());

        if (userVo.getOrganizationId() != null) condition.put("organizationId", userVo.getOrganizationId());

        if (userVo.getCreatedateStart() != null) condition.put("startTime", userVo.getCreatedateStart());

        if (userVo.getCreatedateEnd() != null) condition.put("endTime", userVo.getCreatedateEnd());

        if(userVo.getSupplier()!=null)condition.put("supplierId",userVo.getSupplier().getId());

        pageInfo.setCondition(condition);
        userService.selectDataGrid(pageInfo);
        return pageInfo;
    }

    /**
     * 添加用户页
     *
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/user/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        model.addAttribute("roleIds", new ArrayList<Long>());
        model.addAttribute("user", null);
        return "admin/user/userEdit";
    }

    /**
     * 添加用户
     *
     * @param userVo
     * @return
     */
    @RequiresRoles(Const.Administor_Role_Name)
    @PostMapping("/add")
    @ResponseBody
    @RequiresPermissions("/user/add")
    public Object add(@Valid UserVo userVo) {
        List<User> list = userService.selectByLoginName(userVo);
        if (list != null && !list.isEmpty()) return renderError("登录名已存在!");
        String salt = StringUtils.getUUId();
        if(StringUtils.isBlank(userVo.getPassword()))return renderError("密码为空!");
        String pwd = passwordHash.toHex(userVo.getPassword(), salt);
        userVo.setSalt(salt);
        userVo.setPassword(pwd);
        userService.insertByVo(userVo);
        return renderSuccess("添加成功");
    }

    /**
     * 编辑用户页
     *
     * @param id
     * @param model
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/user/edit")
    public String editPage(Model model, Long id) {
        UserVo userVo = userService.selectVoById(id);
        List<Role> rolesList = userVo.getRolesList();
        List<Long> ids = new ArrayList<Long>();
        for (Role role : rolesList) ids.add(role.getId());

        model.addAttribute("roleIds", ids);
        model.addAttribute("user", userVo);
        model.addAttribute("method", "edit");
        return "admin/user/userEdit";
    }

    /**
     * 编辑用户
     *
     * @param userVo
     * @return
     */
    @RequiresRoles(Const.Administor_Role_Name)
    @PostMapping("/edit")
    @ResponseBody
    @RequiresPermissions("/user/edit")
    public Object edit(@Valid UserVo userVo) {
        List<User> list = userService.selectByLoginName(userVo);
        if (list != null && !list.isEmpty()) return renderError("登录名已存在!");
        // 更新密码
        if (StringUtils.isNotBlank(userVo.getPassword())) {
            User user = userService.selectById(userVo.getId());
            String salt = user.getSalt();
            String pwd = passwordHash.toHex(userVo.getPassword(), salt);
            userVo.setPassword(pwd);
            userVo.setSalt(salt);
        }
        userService.updateByVo(userVo);
        return renderSuccess("修改成功！");
    }

    /**
     * 修改密码页
     *
     * @return
     */
    @GetMapping("/editPwdPage")
    @RequiresPermissions("/user/editPwdPage")
    public String editPwdPage() {
        return "admin/user/userEditPwd";
    }

    @Autowired
    private ShiroDbRealm shiroDbRealm;
    
    /**
     * 修改密码
     *
     * @param oldPwd
     * @param pwd
     * @return
     */
    @PostMapping("/editUserPwd")
    @ResponseBody
    @RequiresPermissions("/user/editPwdPage")
    public Object editUserPwd(String oldPwd, String pwd) {
        User user = userService.selectById(getUserId());
        String salt = user.getSalt();
        if (!user.getPassword().equals(passwordHash.toHex(oldPwd, salt))) {
            return renderError("老密码不正确!");
        }
        // 修改密码时清理用户的缓存
        shiroDbRealm.removeUserCache(user.getLoginName());
        userService.updatePwdByUserId(getUserId(), passwordHash.toHex(pwd, salt));
        return renderSuccess("密码修改成功！");
    }

    /**
     * 删除用户
     *
     * @param id
     * @return
     */
    @RequiresRoles(Const.Administor_Role_Name)
    @PostMapping("/delete")
    @ResponseBody
    @RequiresPermissions("/user/delete")
    public Object delete(Long id) {
        Long currentUserId = getUserId();
        if (id == currentUserId) {
            return renderError("不可以删除自己！");
        }
        userService.deleteUserById(id);
        return renderSuccess("删除成功！");
    }
}