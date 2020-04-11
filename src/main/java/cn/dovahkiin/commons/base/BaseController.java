package cn.dovahkiin.commons.base;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.commons.result.Result;
import cn.dovahkiin.commons.shiro.ShiroUser;
import cn.dovahkiin.commons.utils.*;
import cn.dovahkiin.util.Const;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.IService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.FileEditor;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.baomidou.mybatisplus.plugins.Page;
import cn.dovahkiin.commons.utils.Charsets;
import cn.dovahkiin.commons.utils.StringEscapeEditor;
import cn.dovahkiin.commons.utils.URLUtils;

/**
 * @description：基础 controller
 * @author：zhixuan.wang
 * @date：2015/10/1 14:51
 */

public abstract class BaseController {
    // 控制器本来就是单例，这样似乎更加合理
    protected Logger logger = LogManager.getLogger(getClass());
    private Map<String, Set<Long>> importUsers = new ConcurrentHashMap<>();

    protected synchronized boolean  importOnce(ShiroUser user){
        Set<String> roles = user.getRoles();
        if(roles.contains(Const.Administor_Role_Name)  || roles.contains(Const.optimizerAdministorCN)  ) return Boolean.TRUE;
        String key = Const.simDF.format(new Date());
        Set<Long> values = importUsers.get(key);
        if(values==null)values = new HashSet<>(50);
        if(values.contains(user.getId()))return Boolean.FALSE;
        values.add(user.getId());
        importUsers.put(key,values);
        Set<String> keys = importUsers.keySet();
        keys.forEach(k->{
            if(!key.equals(k))importUsers.remove(k);
        });
        return Boolean.TRUE;
    }
    protected synchronized void  reduceOnce(ShiroUser user){
        Set<String> roles = user.getRoles();
        if(roles.contains(Const.Administor_Role_Name)  || roles.contains(Const.optimizerAdministorCN)  ) return;
        String key = Const.simDF.format(new Date());
        Set<Long> values = importUsers.get(key);
        if(values==null)return ;
        values.remove(user.getId());
        importUsers.put(key,values);
        return ;
    }

    @Autowired
    protected DateConverter dateConverter;
    public void setDateConverter(DateConverter dateConverter) {
        this.dateConverter = dateConverter;
    }
    public DateConverter getDateConverter() {
        return dateConverter;
    }

    @InitBinder
    public void initBinder(ServletRequestDataBinder binder) {
        /**
         * 自动转换日期类型的字段格式
         */
//        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"), true));
//        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm"), true));
//        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
//        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM"), true));

        binder.registerCustomEditor(File.class, new FileEditor());

//        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy/MM/dd"), true));
     //   binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy.MM.dd"), true));
        /**
         * 防止XSS攻击
         */
        binder.registerCustomEditor(String.class, new StringEscapeEditor());
    }

    /**
     * 获取当前登录用户对象
     * @return {ShiroUser}
     */
    public ShiroUser getShiroUser() {
        return (ShiroUser) SecurityUtils.getSubject().getPrincipal();
    }

    public void customizeRegistration(ServletRegistration.Dynamic registration) {
        registration.setMultipartConfig(new MultipartConfigElement("/tmp/uploads")
        );
    }
    /**
     * 获取当前登录用户id
     * @return {Long}
     */
    public Long getUserId() {
        return this.getShiroUser().getId();
    }

    /**
     * 获取当前登录用户名
     * @return {String}
     */
    public String getStaffName() {
        return this.getShiroUser().getName();
    }

    /**
     * ajax失败
     * @param msg 失败的消息
     * @return {Object}
     */
    public Object renderError(String msg) {
        Result result = new Result();
        result.setMsg(msg);
        return result;
    }
    
    /**
     * ajax成功
     * @return {Object}
     */
    public Object renderSuccess() {
        Result result = new Result();
        result.setSuccess(true);
        return result;
    }
    
    /**
     * ajax成功
     * @param msg 消息
     * @return {Object}
     */
    public Object renderSuccess(String msg) {
        Result result = new Result();
        result.setSuccess(true);
        result.setMsg(msg);
        return result;
    }

    /**
     * ajax成功
     * @param obj 成功时的对象
     * @return {Object}
     */
    public Object renderSuccess(Object obj) {
        Result result = new Result();
        result.setSuccess(true);
        result.setObj(obj);
        return result;
    }
    
    public <T> Page<T> getPage(int current, int size, String sort, String order){
        Page<T> page = new Page<T>(current, size, sort);
        if ("desc".equals(order)) {
            page.setAsc(false);
        } else {
            page.setAsc(true);
        }
        return page;
    }
    
    public <T> PageInfo pageToPageInfo(Page<T> page) {
        PageInfo pageInfo = new PageInfo();
        pageInfo.setRows(page.getRecords());
        pageInfo.setTotal(page.getTotal());
        pageInfo.setOrder(page.getOrderByField());
        return pageInfo;
    }


	/**
	 * redirect跳转
	 * @param url 目标url
	 */
	protected String redirect(String url) {
		return new StringBuilder("redirect:").append(url).toString();
	}
	
	/**
	 * 下载文件
	 * @param file 文件
	 */
	protected ResponseEntity<Resource> download(File file) {
		String fileName = file.getName();
		return download(file, fileName);
	}
	
	/**
	 * 下载
	 * @param file 文件
	 * @param fileName 生成的文件名
	 * @return {ResponseEntity}
	 */
	protected ResponseEntity<Resource> download(File file, String fileName) {
		Resource resource = new FileSystemResource(file);
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		String header = request.getHeader("User-Agent");
		// 避免空指针
		header = header == null ? "" : header.toUpperCase();
		HttpStatus status;
		if (header.contains("MSIE") || header.contains("TRIDENT") || header.contains("EDGE")) {
			fileName = URLUtils.encodeURL(fileName, Charsets.UTF_8);
			status = HttpStatus.OK;
		} else {
			fileName = new String(fileName.getBytes(Charsets.UTF_8), Charsets.ISO_8859_1);
			status = HttpStatus.CREATED;
		}
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDispositionFormData("attachment", fileName);
		return new ResponseEntity<Resource>(resource, headers, status);
	}



    public  <T extends Model>PageInfo dataGrid(T model ,IService<T> iService, Integer page, Integer rows, String sort,String order)  {
        PageInfo pageInfo = new PageInfo(page, rows, sort, order);
        EntityWrapper<T> ew = new EntityWrapper<T>();
        if(model!=null){
            try {
                Method getCode = model.getClass().getMethod("getCode") ;
                Method getName = model.getClass().getMethod("getName") ;
                Method getDeleteFlag = model.getClass().getMethod("getDeleteFlag") ;
                Object code =  getCode.invoke(model);
                Object name =getName.invoke(model);
                Object deleteFlag =getDeleteFlag.invoke(model);
                if(StringUtils.hasText((String) code))ew.like("code","%"+((String) code).trim().replaceAll(" ","")+"%");
                if(StringUtils.hasText((String) name))ew.like("name","%"+((String) name).trim().replaceAll(" ","")+"%");
                if(deleteFlag != null) ew.eq("delete_flag", deleteFlag );
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }

        }
        Page<T> pages = getPage(page, rows, sort, order);
        pages = iService.selectPage(pages, ew);
        pageInfo.setRows(pages.getRecords());
        pageInfo.setTotal(pages.getTotal());
        return pageInfo;
    }

    public <T extends Model>Object combobox(IService<T> iService) {
        EntityWrapper ew = new EntityWrapper();
        ew.eq("delete_flag", 0 );
        return JSON.toJSON(iService.selectList(ew));
    }
    public static String toLowerCaseFirstOne(String s){
        if(Character.isLowerCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
    }
    public <T extends Model>String addPage(org.springframework.ui.Model model, Long id,IService<T> iService,Class<T> clazz) {
        model.addAttribute("method", "add");
        String className = toLowerCaseFirstOne(clazz.getSimpleName()) ;

        if(id!=null){
            try {
                Method setId = clazz.getMethod("setId", Long.class);
                T mm = iService.selectById(id);
                if(mm!=null){
                    setId.invoke(mm, new Object[]{null});
                    model.addAttribute(className, mm);
                }
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }
        return  className+"/"+className+"Edit";
    }

    /**
     * 默认新增方法
     * @param model 待新增对象
     * @param  iService 对应类的服务组件
     * @description 对象需要有 setCreateTime,setUpdateTime,setDeleteFlag 方法
     * */
    protected  <T extends Model> Object add(@Valid T model,IService<T> iService) {
        try {
            Method setCreateTime = model.getClass().getMethod("setCreateTime",Date.class) ;
            Method setUpdateTime = model.getClass().getMethod("setUpdateTime",Date.class) ;
            Method setDeleteFlag = model.getClass().getMethod("setDeleteFlag",Integer.class) ;
            setCreateTime.invoke(model,new Date());
            setUpdateTime.invoke(model,new Date());
            setDeleteFlag.invoke(model,0);
            boolean b = iService.insert(model);
            if (b) return renderSuccess("添加成功！");
        }catch (NoSuchMethodException e){
            e.printStackTrace();
        }catch (InvocationTargetException e){
            e.printStackTrace();
        }catch (IllegalAccessException e){
            e.printStackTrace();
        }
        return renderError("添加失败！");
    }

    public <T extends Model> Object delete(String ids, Class<T> clazz, IService<T> iService) {
        return updateDeleteFlag(ids,clazz,iService,1);
    }

    public  <T extends Model> Object rollback(String ids, Class<T> clazz, IService<T> iService) {
        return updateDeleteFlag(ids,clazz,iService,0);
    }
    public  <T extends Model> Object updateDeleteFlag(String ids, Class<T> clazz, IService<T> iService,int deleteFlag) {
        if (ids == null) return renderError("失败！");
        try {
            String[] idss = ids.split(",");
            List<T> list = new ArrayList<T>();
            for (String str : idss) {
                if (StringUtils.hasText(str) && StringUtils.isInteger(str)) {
                    T instance = clazz.newInstance();
                    Method setId = clazz.getMethod("setId", Long.class);
                    Method setDeleteFlag = clazz.getMethod("setDeleteFlag", Integer.class);
                    setId.invoke(instance, Long.valueOf(str));
                    setDeleteFlag.invoke(instance, deleteFlag);
                    list.add(instance);
                }
            }
            if (list.size() > 0) {
                boolean suc = iService.updateBatchById(list);
                if (suc) return renderSuccess("成功！");
            }
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return renderError("失败！");
    }

    public <T extends Model> Object deleteForever(String ids,IService<T> iService) {
        if(ids!=null){
            String[] idss = ids.split(",");
            List<Long> list = new ArrayList<Long>();
            EntityWrapper<T> ew = new EntityWrapper<T>();
            for(String str:idss){
                if(StringUtils.hasText(str) && StringUtils.isInteger(str) ) list.add(Long.parseLong(str));
            }
            ew.in("id", list);
            if(list.size()>0){
                boolean suc = iService.delete(ew);
                if(suc)return renderSuccess("删除成功！");
            }
        }
        return renderError("删除失败！");
    }

    public <T extends Model>String editPage(org.springframework.ui.Model model, Long id,Class<T> clazz, IService<T> iService) {
        T object = iService.selectById(id);
        String className =toLowerCaseFirstOne(clazz.getSimpleName()) ;
        model.addAttribute(className, object);
        model.addAttribute("method", "edit");
        return className+"/"+className+"Edit";
    }
    public  <T extends Model>Object edit(@Valid T object,IService<T> iService) {
        try {
            Method setUpdateTime = object.getClass().getMethod("setUpdateTime",Date.class) ;
            setUpdateTime.invoke(object,new Date());
            boolean b = iService.updateById(object);
            if (b) return renderSuccess("编辑成功！");
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return renderError("编辑失败！");
    }

    protected void addCookie(HttpServletResponse response,Cookie cookie){
        response.addCookie(cookie);
    }
    protected void addCookies(HttpServletResponse response,Cookie[] cookies){
        for(Cookie cook :cookies)addCookie(response,cook);
    }

}
