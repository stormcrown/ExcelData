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
import cn.dovahkiin.model.VideoType;
import cn.dovahkiin.service.IVideoTypeService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 产品类型信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/videoType")
public class VideoTypeController extends BaseController {

    private IVideoTypeService videoTypeService;
    @Autowired
    public void setIVideoTypeService(IVideoTypeService videoTypeService) {
        this.videoTypeService = videoTypeService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/videoType/manager")
    public String manager() {
        return "videoType/videoTypeList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/videoType/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(VideoType videoType, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(videoType,videoTypeService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(videoTypeService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/videoType/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,videoTypeService,VideoType.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/videoType/add")
    @ResponseBody
    public Object add(@Valid VideoType videoType) {
        return super.add(videoType,videoTypeService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/videoType/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,VideoType.class,videoTypeService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/videoType/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,videoTypeService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/videoType/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,VideoType.class,videoTypeService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/videoType/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,VideoType.class,videoTypeService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/videoType/edit")
    @ResponseBody
    public Object edit(@Valid VideoType videoType) {
        return super.edit(videoType,videoTypeService);
    }
}
