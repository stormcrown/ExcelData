package cn.dovahkiin.controller;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import cn.dovahkiin.commons.utils.StringUtils;
import com.alibaba.fastjson.JSON;
import org.apache.shiro.authz.annotation.Logical;
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
import cn.dovahkiin.model.VideoVersion;
import cn.dovahkiin.service.IVideoVersionService;
import cn.dovahkiin.commons.base.BaseController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
@Controller
@RequestMapping("/videoVersion")
public class VideoVersionController extends BaseController {

    @Autowired private IVideoVersionService videoVersionService;
    
    @GetMapping("/manager")
    @RequiresPermissions("/videoVersion/manager")
    public String manager() {
        return "videoVersion/videoVersionList";
    }
    
    @PostMapping("/dataGrid")
    @RequiresPermissions("/videoVersion/dataGrid")
    @ResponseBody
    public PageInfo dataGrid(VideoVersion videoVersion, Integer page, Integer rows, String sort,String order) {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<VideoVersion> ew = new EntityWrapper<VideoVersion>();
        if(videoVersion!=null && StringUtils.hasText(videoVersion.getCode()))ew.like("code","%"+videoVersion.getCode().trim()+"%");
        if(videoVersion!=null && StringUtils.hasText(videoVersion.getName()) )ew.like("name","%"+videoVersion.getName().trim()+"%");
        if(videoVersion!=null && videoVersion.getDeleteFlag()!=null  ) ew.eq("delete_flag", videoVersion.getDeleteFlag() );
        Page<VideoVersion> pages = getPage(page, rows, sort, order);
        pages = videoVersionService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }

    @PostMapping("/combobox")
    @ResponseBody
    @RequiresPermissions(value = {"/videoCost/dataGrid","/customer/*","/count/bar"  },logical = Logical.OR)
    public Object combobox(){
        EntityWrapper ew = new EntityWrapper();
        ew.eq("delete_flag", 0 );
        return JSON.toJSON(videoVersionService.selectList(ew));
    }
    
    /**
     * 添加页面
     * @return
     */
    @GetMapping("/addPage")
    @RequiresPermissions("/videoVersion/add")
    public String addPage(Model model,Long id) {
        model.addAttribute("method", "add");
        if(id!=null){
            VideoVersion videoVersion = videoVersionService.selectById(id);
            if(videoVersion!=null){
                videoVersion.setId(null);
                model.addAttribute("videoVersion", videoVersion);
            }
        }
        return "videoVersion/videoVersionEdit";
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
        if(ids!=null){
            String[] idss = ids.split(",");
            List<VideoVersion> list = new ArrayList<VideoVersion>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    VideoVersion videoVersion = new VideoVersion();
                    videoVersion.setId(Long.valueOf(str));
                    videoVersion.setDeleteFlag(1);
                    list.add(videoVersion);
                }
            }
            if(list.size()>0){
                boolean suc = videoVersionService.updateBatchById(list);
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
@RequiresPermissions("/videoVersion/add")
@ResponseBody
public Object rollback(String ids) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<VideoVersion> list = new ArrayList<VideoVersion>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ){
                    VideoVersion videoVersion = new VideoVersion();
                    videoVersion.setId(Long.valueOf(str));
                    videoVersion.setDeleteFlag(0);
                    list.add(videoVersion);
                }
            }
            if(list.size()>0){
                boolean suc = videoVersionService.updateBatchById(list);
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
    @RequiresPermissions("/videoVersion/edit")
    public String editPage(Model model, Long id) {
        VideoVersion videoVersion = videoVersionService.selectById(id);
        model.addAttribute("videoVersion", videoVersion);
        model.addAttribute("method", "edit");
        return "videoVersion/videoVersionEdit";
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
        videoVersion.setUpdateTime(new Date());
        boolean b = videoVersionService.updateById(videoVersion);
        if (b) {
            return renderSuccess("编辑成功！");
        } else {
            return renderError("编辑失败！");
        }
    }
}
