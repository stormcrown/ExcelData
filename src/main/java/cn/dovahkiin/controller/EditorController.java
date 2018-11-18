package cn.dovahkiin.controller;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import cn.dovahkiin.commons.utils.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
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
 * @since 2018-11-18
 */
@Controller
@RequestMapping("/editor")
public class EditorController extends BaseController {

    @Autowired private IEditorService editorService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/editor/manager")
    public String manager() {
        return "editor/editorList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/editor/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Editor editor, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Editor> ew = new EntityWrapper<Editor>();
        if(editor!=null && StringUtils.hasText(editor.getCode()))ew.like("code","%"+editor.getCode().trim()+"%");
        if(editor!=null && StringUtils.hasText(editor.getName()) )ew.like("name","%"+editor.getName().trim()+"%");
        if(editor!=null && editor.getDeleteFlag()!=null  ) ew.eq("delete_flag", editor.getDeleteFlag() );
        Page<Editor> pages = getPage(page, rows, sort, order);
        pages = editorService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/editor/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            Editor editor = editorService.selectById(id);
            if(editor!=null){
                editor.setId(null);
                editor.setCode(null);
                model.addAttribute("editor", editor);
            }

        }
        return "editor/editorEdit";
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
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Editor> list = new ArrayList<Editor>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Editor editor = new Editor();
                    editor.setId(Long.valueOf(str));
                    editor.setDeleteFlag(1);
                    list.add(editor);
                }
            }
            if(list.size()>0){
                boolean suc = editorService.updateBatchById(list);
                if(suc)return renderSuccess("删除成功！");
            }
        }

        return renderError("删除失败！");

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
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Editor> list = new ArrayList<Editor>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    Editor editor = new Editor();
                    editor.setId(Long.valueOf(str));
                    editor.setDeleteFlag(0);
                    list.add(editor);
                }
            }
            if(list.size()>0){
                boolean suc = editorService.updateBatchById(list);
                if(suc)return renderSuccess("恢复成功！");
            }
        }
            return renderError("恢复失败！");
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
        Editor editor = editorService.selectById(id);
        model.addAttribute("editor", editor);
        model.addAttribute("method", "edit");
        return "editor/editorEdit";
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
        editor.setUpdateTime(new Date());
        boolean b = editorService.updateById(editor);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
