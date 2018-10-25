package cn.dovahkiin.service.impl;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import cn.dovahkiin.mapper.RoleResourceMapper;
import cn.dovahkiin.model.RoleResource;
import cn.dovahkiin.service.IRoleResourceService;

/**
 *
 * RoleResource 表数据服务层接口实现类
 *
 */
@Service
public class RoleResourceServiceImpl extends ServiceImpl<RoleResourceMapper, RoleResource> implements IRoleResourceService {


}