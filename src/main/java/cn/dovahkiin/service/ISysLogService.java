package cn.dovahkiin.service;

import com.baomidou.mybatisplus.service.IService;
import cn.dovahkiin.commons.result.PageInfo;
import cn.dovahkiin.model.SysLog;

/**
 *
 * SysLog 表数据服务层接口
 *
 */
public interface ISysLogService extends IService<SysLog> {

    void selectDataGrid(PageInfo pageInfo);

}