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
import cn.dovahkiin.model.VideoType;
import cn.dovahkiin.service.IVideoTypeService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 产品类型信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-04
 */
@Controller
@RequestMapping("/videoType")
public class VideoTypeController extends BaseController {

    @Autowired private IVideoTypeService videoTypeService;
    
    @GetMapping("/manager")
    public String manager() {
        return "admin/videoType/videoTypeList";
    }
    
    @PostMapping("/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(VideoType videoType, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<VideoType> ew = new EntityWrapper<VideoType>(videoType);
        Page<VideoType> pages = getPage(page, rows, sort, order);
        pages = videoTypeService.selectPage(pages, ew);
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
        return "admin/videoType/videoTypeAdd";
    }
    
    /**
     * 添加
     * @param 
     * @return
     */
    @PostMapping("/add")
    @ResponseBody
    public Object add(@Valid VideoType videoType) {
        videoType.setCreateTime(new Date());
        videoType.setUpdateTime(new Date());
        videoType.setDeleteFlag(0);
        boolean b = videoTypeService.insert(videoType);
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
        VideoType videoType = new VideoType();
        videoType.setId(id);
        videoType.setUpdateTime(new Date());
        videoType.setDeleteFlag(1);
        boolean b = videoTypeService.updateById(videoType);
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
        VideoType videoType = videoTypeService.selectById(id);
        model.addAttribute("videoType", videoType);
        return "admin/videoType/videoTypeEdit";
    }
    
    /**
     * 编辑
     * @param 
     * @return
     */
    @PostMapping("/edit")
    @ResponseBody
    public Object edit(@Valid VideoType videoType) {
        videoType.setUpdateTime(new Date());
        boolean b = videoTypeService.updateById(videoType);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
