package cn.dovahkiin.controller;

import javax.validation.Valid;
import cn.dovahkiin.util.Const;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.model.VideoVersion;
import cn.dovahkiin.service.IVideoVersionService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/videoVersion")
public class VideoVersionController extends BaseController {

    private IVideoVersionService videoVersionService;
    @Autowired
    public void setIVideoVersionService(IVideoVersionService videoVersionService) {
        this.videoVersionService = videoVersionService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/videoVersion/manager")
    public String manager() {
        return "videoVersion/videoVersionList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/videoVersion/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(VideoVersion videoVersion, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(videoVersion,videoVersionService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(videoVersionService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/videoVersion/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,videoVersionService,VideoVersion.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/videoVersion/add")
    @ResponseBody
    public Object add(@Valid VideoVersion videoVersion) {
        return super.add(videoVersion,videoVersionService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/videoVersion/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,VideoVersion.class,videoVersionService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/videoVersion/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,videoVersionService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/videoVersion/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,VideoVersion.class,videoVersionService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/videoVersion/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,VideoVersion.class,videoVersionService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/videoVersion/edit")
    @ResponseBody
    public Object edit(@Valid VideoVersion videoVersion) {
        return super.edit(videoVersion,videoVersionService);
    }
}
