package cn.dovahkiin.controller;

import java.util.List;

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
import cn.dovahkiin.model.Role;
import cn.dovahkiin.service.IRoleService;

/**
 * @description：权限管理
 * @author：zhixuan.wang
 * @date：2015/10/1 14:51
 */
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

    @Autowired
    private IRoleService roleService;

    /**
     * 权限管理页
     *
     * @return
     */
    @GetMapping("/manager")
    @RequiresPermissions("/role/manager")
    public String manager() {
        return "admin/role/role";
    }

    /**
     * 权限列表
     *
     * @param page
     * @param rows
     * @param sort
     * @param order
     * @return
     */
    @PostMapping("/dataGrid")
    @ResponseBody
    @RequiresPermissions("/role/dataGrid")
    public Object dataGrid(Integer page, Integer rows, String sort, String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        roleService.selectDataGrid(pageInfo);
        return pageInfo;
    }

    /**
     * 权限树
     *
     * @return
     */
    @PostMapping("/tree")
    @ResponseBody
    public Object tree() {
        return roleService.selectTree();
    }

    /**
     * 添加权限页
     *
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/role/add")
    public String addPage() {
        return "admin/role/roleAdd";
    }

    /**
     * 添加权限
     *
     * @param role
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    @RequiresPermissions("/role/add")
    public Object add(@Valid Role role) {
        roleService.insert(role);
        return renderSuccess("添加成功！");
    }

    /**
     * 删除权限
     *
     * @param id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    @RequiresPermissions("/role/delete")
    public Object delete(Long id) {
        roleService.deleteById(id);
        return renderSuccess("删除成功！");
    }

    /**
     * 编辑权限页
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/editPage")
    @RequiresPermissions("/role/edit")
    public String editPage(Model model, Long id) {
        Role role = roleService.selectById(id);
        model.addAttribute("role", role);
        return "admin/role/roleEdit";
    }

    /**
     * 删除权限
     *
     * @param role
     * @return
     */
    @RequestMapping("/edit")
    @ResponseBody
    @RequiresPermissions("/role/edit")
    public Object edit(@Valid Role role) {
        roleService.updateById(role);
        return renderSuccess("编辑成功！");
    }

    /**
     * 授权页面
     *
     * @param id
     * @param model
     * @return
     */
    @GetMapping("/grantPage")
    @RequiresPermissions("/role/grant")
    public String grantPage(Model model, Long id) {
        model.addAttribute("id", id);
        return "admin/role/roleGrant";
    }

    /**
     * 授权页面页面根据角色查询资源
     *
     * @param id
     * @return
     */
    @RequestMapping("/findResourceIdListByRoleId")
    @ResponseBody
    @RequiresPermissions("/role/grant")
    public Object findResourceByRoleId(Long id) {
        List<Long> resources = roleService.selectResourceIdListByRoleId(id);
        return renderSuccess(resources);
    }

    /**
     * 授权
     *
     * @param id
     * @param resourceIds
     * @return
     */
    @RequiresRoles(Const.Administor_Role_Name)
    @RequestMapping("/grant")
    @ResponseBody
    @RequiresPermissions("/role/grant")
    public Object grant(Long id, String resourceIds) {
        roleService.updateRoleResource(id, resourceIds);
        return renderSuccess("授权成功！");
    }

}
