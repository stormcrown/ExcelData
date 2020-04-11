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
import cn.dovahkiin.model.Editor;
import cn.dovahkiin.service.IEditorService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 剪辑师信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-04-10
 */
@Controller
@RequestMapping("/editor")
public class EditorController extends BaseController {

    private IEditorService editorService;
    @Autowired
    public void setIEditorService(IEditorService editorService) {
        this.editorService = editorService;
    }
    @GetMapping("/manager")
    @RequiresPermissions("/editor/manager")
    public String manager() {
        return "editor/editorList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/editor/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Editor editor, Integer page, Integer rows, String sort,String order) {
        return super.dataGrid(editor,editorService,page,rows,sort,order);
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar" },logical = Logical.OR)
    public Object combobox() {
        return super.combobox(editorService);
        }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/editor/add")
    public String addPage(Model model,Long id) {
        return super.addPage(model,id,editorService,Editor.class);
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @RequiresPermissions("/editor/add")
    @ResponseBody
    public Object add(@Valid Editor editor) {
        return super.add(editor,editorService);
    }
    
    /**
     * 删除
     * @param ids
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("/editor/delete")
    @ResponseBody
    public Object delete(String ids) {
        return super.delete(ids,Editor.class,editorService);
    }
/**
*永久删除
* @param ids
* @return
*/
@RequiresPermissions("/editor/delete")
@PostMapping("/deleteForever")
@RequiresRoles(Const.Administor_Role_Name)
@ResponseBody
public Object deleteForever(String ids) {
        return super.deleteForever(ids,editorService);
        }
/**
 * 恢复
 * @param ids
 * @return
 */
@PostMapping("/rollback")
@RequiresPermissions("/editor/add")
@ResponseBody
public Object rollback(String ids) {
        return super.rollback(ids,Editor.class,editorService);
}
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    @RequiresPermissions("/editor/edit")
    public String editPage(Model model, Long id) {
        return super.editPage(model,id,Editor.class,editorService);
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @RequiresPermissions("/editor/edit")
    @ResponseBody
    public Object edit(@Valid Editor editor) {
        return super.edit(editor,editorService);
    }
}
