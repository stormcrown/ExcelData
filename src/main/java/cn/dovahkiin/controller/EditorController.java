package cn.dovahkiin.controller;

import javax.validation.Valid;

import java.util.List;
import java.util.Date;
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
 * @since 2018-11-03
 */
@Controller
@RequestMapping("/editor")
public class EditorController extends BaseController {

    @Autowired private IEditorService editorService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/editor/editorList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(Editor editor, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<Editor> ew = new EntityWrapper<Editor>(editor);
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
    public String addPage() {
        return "admin/editor/editorAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid Editor editor) {
        editor.setCreateTime(new Date());
        editor.setUpdateTime(new Date());
        editor.setDeleteFlag(0);
        boolean b = editorService.insert(editor);
        if (b) {
            return renderSuccess("添加成功！");
        } else {
            return renderError("添加失败！");
        }
    }
    
    /**
     * 删除
     * @param id
     * @return
     */
    @PostMapping("/delete")
    @ResponseBody
    public Object delete(Long id) {
        Editor editor = new Editor();
        editor.setId(id);
        editor.setUpdateTime(new Date());
        editor.setDeleteFlag(1);
        boolean b = editorService.updateById(editor);
        if (b) {
            return renderSuccess("删除成功！");
        } else {
            return renderError("删除失败！");
        }
    }
    
    /**
     * 编辑
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/editPage")
    public String editPage(Model model, Long id) {
        Editor editor = editorService.selectById(id);
        model.addAttribute("editor", editor);
        return "admin/editor/editorEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
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
