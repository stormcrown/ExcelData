package cn.dovahkiin.controller;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import cn.dovahkiin.commons.utils.StringUtils;
import com.alibaba.fastjson.JSON;
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
import cn.dovahkiin.model.VideoType;
import cn.dovahkiin.service.IVideoTypeService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 * 产品类型信息 前端控制器
 * </p>
 *
 * @author lzt
 * @since 2018-11-19
 */
@Controller
@RequestMapping("/videoType")
public class VideoTypeController extends BaseController {

    @Autowired private IVideoTypeService videoTypeService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/videoType/manager")
    public String manager() {
        return "videoType/videoTypeList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/videoType/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(VideoType videoType, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<VideoType> ew = new EntityWrapper<VideoType>();
        if(videoType!=null && StringUtils.hasText(videoType.getCode()))ew.like("code","%"+videoType.getCode().trim()+"%");
        if(videoType!=null && StringUtils.hasText(videoType.getName()) )ew.like("name","%"+videoType.getName().trim()+"%");
        if(videoType!=null && videoType.getDeleteFlag()!=null  ) ew.eq("delete_flag", videoType.getDeleteFlag() );
        Page<VideoType> pages = getPage(page, rows, sort, order);
        pages = videoTypeService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }
    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions("/videoCost/dataGrid")
    public Object dataGrid() {
        EntityWrapper ew = new EntityWrapper();
        ew.eq("delete_flag", 0 );
        return JSON.toJSON(videoTypeService.selectList(ew));
    }
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/videoType/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            VideoType videoType = videoTypeService.selectById(id);
            if(videoType!=null){
                videoType.setId(null);
                model.addAttribute("videoType", videoType);
            }

        }
        return "videoType/videoTypeEdit";
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
        if(ids!=null){
            String[] idss = ids.split(",");
            List<VideoType> list = new ArrayList<VideoType>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    VideoType videoType = new VideoType();
                    videoType.setId(Long.valueOf(str));
                    videoType.setDeleteFlag(1);
                    list.add(videoType);
                }
            }
            if(list.size()>0){
                boolean suc = videoTypeService.updateBatchById(list);
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
@RequiresPermissions("/videoType/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<VideoType> list = new ArrayList<VideoType>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    VideoType videoType = new VideoType();
                    videoType.setId(Long.valueOf(str));
                    videoType.setDeleteFlag(0);
                    list.add(videoType);
                }
            }
            if(list.size()>0){
                boolean suc = videoTypeService.updateBatchById(list);
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
    @RequiresPermissions("/videoType/edit")
    public String editPage(Model model, Long id) {
        VideoType videoType = videoTypeService.selectById(id);
        model.addAttribute("videoType", videoType);
        model.addAttribute("method", "edit");
        return "videoType/videoTypeEdit";
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
        videoType.setUpdateTime(new Date());
        boolean b = videoTypeService.updateById(videoType);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
