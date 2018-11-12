/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : shiro

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2018-10-28 15:53:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) NOT NULL COMMENT '组织名',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `code` varchar(64) NOT NULL COMMENT '编号',
  `icon` varchar(32) DEFAULT NULL COMMENT '图标',
  `pid` bigint(19) DEFAULT NULL COMMENT '父级主键',
  `seq` tinyint(2) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='组织机构';

-- ----------------------------
-- Records of organization
-- ----------------------------
INSERT INTO `organization` VALUES ('1', '总经办', '王家桥', '01', 'glyphicon-lock ', null, '0', '2014-02-19 01:00:00');
INSERT INTO `organization` VALUES ('3', '技术部', '', '02', 'glyphicon-wrench ', null, '1', '2015-10-01 13:10:42');
INSERT INTO `organization` VALUES ('5', '产品部', '', '03', 'glyphicon-send ', null, '2', '2015-12-06 12:15:30');
INSERT INTO `organization` VALUES ('6', '测试组', '', '04', 'glyphicon-headphones ', '3', '0', '2015-12-06 13:12:18');

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '资源名称',
  `url` varchar(100) DEFAULT NULL COMMENT '资源路径',
  `open_mode` varchar(32) DEFAULT NULL COMMENT '打开方式 ajax,iframe',
  `description` varchar(255) DEFAULT NULL COMMENT '资源介绍',
  `icon` varchar(32) DEFAULT NULL COMMENT '资源图标',
  `pid` bigint(19) DEFAULT NULL COMMENT '父级资源id',
  `seq` tinyint(2) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `opened` tinyint(2) NOT NULL DEFAULT '1' COMMENT '打开状态',
  `resource_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '资源类别',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8 COMMENT='资源';

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('1', '权限管理', '', '', '系统管理', 'glyphicon-list icon-purple', null, '1', '0', '1', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('11', '资源管理', '/resource/manager', 'ajax', '资源管理', 'glyphicon-th ', '1', '1', '0', '1', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('12', '角色管理', '/role/manager', 'ajax', '角色管理', 'glyphicon-eye-open ', '1', '2', '0', '1', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('13', '用户管理', '/user/manager', 'ajax', '用户管理', 'glyphicon-user ', '1', '3', '0', '1', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('14', '部门管理', '/organization/manager', 'ajax', '部门管理', 'glyphicon-lock ', '1', '4', '0', '1', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('111', '列表', '/resource/treeGrid', 'ajax', '资源列表', 'glyphicon-list ', '11', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('112', '添加', '/resource/add', 'ajax', '资源添加', 'glyphicon-plus icon-green', '11', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('113', '编辑', '/resource/edit', 'ajax', '资源编辑', 'glyphicon-pencil icon-blue', '11', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('114', '删除', '/resource/delete', 'ajax', '资源删除', 'glyphicon-trash icon-red', '11', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('121', '列表', '/role/dataGrid', 'ajax', '角色列表', 'glyphicon-list ', '12', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('122', '添加', '/role/add', 'ajax', '角色添加', 'glyphicon-plus icon-green', '12', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('123', '编辑', '/role/edit', 'ajax', '角色编辑', 'glyphicon-pencil icon-blue', '12', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('124', '删除', '/role/delete', 'ajax', '角色删除', 'glyphicon-trash icon-red', '12', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('125', '授权', '/role/grant', 'ajax', '角色授权', 'glyphicon-ok icon-green', '12', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('131', '列表', '/user/dataGrid', 'ajax', '用户列表', 'glyphicon-list ', '13', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('132', '添加', '/user/add', 'ajax', '用户添加', 'glyphicon-plus icon-green', '13', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('133', '编辑', '/user/edit', 'ajax', '用户编辑', 'glyphicon-pencil icon-blue', '13', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('134', '删除', '/user/delete', 'ajax', '用户删除', 'glyphicon-trash icon-red', '13', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('141', '列表', '/organization/treeGrid', 'ajax', '用户列表', 'glyphicon-list ', '14', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('142', '添加', '/organization/add', 'ajax', '部门添加', 'glyphicon-plus icon-green', '14', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('143', '编辑', '/organization/edit', 'ajax', '部门编辑', 'glyphicon-pencil icon-blue', '14', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('144', '删除', '/organization/delete', 'ajax', '部门删除', 'glyphicon-trash icon-red', '14', '0', '0', '1', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('221', '日志监控', '', '', null, 'glyphicon-dashboard ', null, '2', '0', '0', '0', '2015-12-01 11:44:20');
INSERT INTO `resource` VALUES ('226', '修改密码', '/user/editPwdPage', 'ajax', null, 'glyphicon-eye-close ', null, '-1', '0', '1', '1', '2015-12-07 20:23:06');
INSERT INTO `resource` VALUES ('227', '登录日志', '/sysLog/manager', 'ajax', null, 'glyphicon-exclamation-sign ', '221', '0', '0', '1', '0', '2016-09-30 22:10:53');
INSERT INTO `resource` VALUES ('228', 'Druid监控', '/druid', 'iframe', null, 'glyphicon-sunglasses ', '221', '0', '0', '1', '0', '2016-09-30 22:12:50');
INSERT INTO `resource` VALUES ('229', '系统图标', '/icons.html', 'ajax', null, 'glyphicon-picture ', '1', '5', '0', '1', '0', '2016-12-24 15:53:47');
INSERT INTO `resource` VALUES ('233', '每日消耗', '/videoCost/manager', 'ajax', null, 'glyphicon-book ', '234', '0', '0', '1', '0', '2018-10-15 13:42:56');
INSERT INTO `resource` VALUES ('234', '成片消耗', '', '', null, 'glyphicon-th-list ', null, '0', '0', '1', '0', '2018-10-15 13:50:29');
INSERT INTO `resource` VALUES ('235', '列表', '/videoCost/dataGrid', 'ajax', null, 'glyphicon-list ', '233', '1', '0', '1', '1', '2018-10-15 14:16:04');
INSERT INTO `resource` VALUES ('236', '添加', '/videoCost/add', 'ajax', null, 'glyphicon-plus icon-green', '233', '2', '0', '1', '1', '2018-10-15 14:16:52');
INSERT INTO `resource` VALUES ('237', '编辑', '/videoCost/edit', 'ajax', null, 'glyphicon-pencil icon-purple', '233', '3', '0', '1', '1', '2018-10-15 14:17:34');
INSERT INTO `resource` VALUES ('238', '删除', '/videoCost/delete', 'ajax', null, 'glyphicon-trash icon-red', '233', '4', '0', '1', '1', '2018-10-15 14:18:55');
INSERT INTO `resource` VALUES ('239', '导入Excel', '/videoCost/importExcel', 'ajax', null, 'glyphicon-open-file icon-blue', '233', '5', '0', '1', '1', '2018-10-15 14:25:10');
INSERT INTO `resource` VALUES ('240', '导出Excel', '/videoCost/exportExcel', 'ajax', null, 'glyphicon-save-file icon-blue', '233', '6', '0', '1', '1', '2018-10-15 14:25:42');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) NOT NULL COMMENT '角色名',
  `seq` tinyint(2) NOT NULL DEFAULT '0' COMMENT '排序号',
  `description` varchar(255) DEFAULT NULL COMMENT '简介',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin', '0', '超级管理员', '0');
INSERT INTO `role` VALUES ('2', 'de', '1', '普通用户', '0');

-- ----------------------------
-- Table structure for role_resource
-- ----------------------------
DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_id` bigint(19) NOT NULL COMMENT '角色id',
  `resource_id` bigint(19) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`id`),
  KEY `idx_role_resource_ids` (`role_id`,`resource_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=785 DEFAULT CHARSET=utf8 COMMENT='角色资源';

-- ----------------------------
-- Records of role_resource
-- ----------------------------
INSERT INTO `role_resource` VALUES ('759', '1', '1');
INSERT INTO `role_resource` VALUES ('760', '1', '11');
INSERT INTO `role_resource` VALUES ('765', '1', '12');
INSERT INTO `role_resource` VALUES ('771', '1', '13');
INSERT INTO `role_resource` VALUES ('776', '1', '14');
INSERT INTO `role_resource` VALUES ('761', '1', '111');
INSERT INTO `role_resource` VALUES ('762', '1', '112');
INSERT INTO `role_resource` VALUES ('763', '1', '113');
INSERT INTO `role_resource` VALUES ('764', '1', '114');
INSERT INTO `role_resource` VALUES ('766', '1', '121');
INSERT INTO `role_resource` VALUES ('767', '1', '122');
INSERT INTO `role_resource` VALUES ('768', '1', '123');
INSERT INTO `role_resource` VALUES ('769', '1', '124');
INSERT INTO `role_resource` VALUES ('770', '1', '125');
INSERT INTO `role_resource` VALUES ('772', '1', '131');
INSERT INTO `role_resource` VALUES ('773', '1', '132');
INSERT INTO `role_resource` VALUES ('774', '1', '133');
INSERT INTO `role_resource` VALUES ('775', '1', '134');
INSERT INTO `role_resource` VALUES ('777', '1', '141');
INSERT INTO `role_resource` VALUES ('778', '1', '142');
INSERT INTO `role_resource` VALUES ('779', '1', '143');
INSERT INTO `role_resource` VALUES ('780', '1', '144');
INSERT INTO `role_resource` VALUES ('782', '1', '221');
INSERT INTO `role_resource` VALUES ('750', '1', '226');
INSERT INTO `role_resource` VALUES ('783', '1', '227');
INSERT INTO `role_resource` VALUES ('784', '1', '228');
INSERT INTO `role_resource` VALUES ('781', '1', '229');
INSERT INTO `role_resource` VALUES ('752', '1', '233');
INSERT INTO `role_resource` VALUES ('751', '1', '234');
INSERT INTO `role_resource` VALUES ('753', '1', '235');
INSERT INTO `role_resource` VALUES ('754', '1', '236');
INSERT INTO `role_resource` VALUES ('755', '1', '237');
INSERT INTO `role_resource` VALUES ('756', '1', '238');
INSERT INTO `role_resource` VALUES ('757', '1', '239');
INSERT INTO `role_resource` VALUES ('758', '1', '240');
INSERT INTO `role_resource` VALUES ('745', '2', '233');
INSERT INTO `role_resource` VALUES ('744', '2', '234');
INSERT INTO `role_resource` VALUES ('746', '2', '235');
INSERT INTO `role_resource` VALUES ('747', '2', '236');
INSERT INTO `role_resource` VALUES ('748', '2', '237');
INSERT INTO `role_resource` VALUES ('749', '2', '238');
INSERT INTO `role_resource` VALUES ('158', '3', '1');
INSERT INTO `role_resource` VALUES ('159', '3', '11');
INSERT INTO `role_resource` VALUES ('164', '3', '12');
INSERT INTO `role_resource` VALUES ('170', '3', '13');
INSERT INTO `role_resource` VALUES ('175', '3', '14');
INSERT INTO `role_resource` VALUES ('160', '3', '111');
INSERT INTO `role_resource` VALUES ('161', '3', '112');
INSERT INTO `role_resource` VALUES ('162', '3', '113');
INSERT INTO `role_resource` VALUES ('163', '3', '114');
INSERT INTO `role_resource` VALUES ('165', '3', '121');
INSERT INTO `role_resource` VALUES ('166', '3', '122');
INSERT INTO `role_resource` VALUES ('167', '3', '123');
INSERT INTO `role_resource` VALUES ('168', '3', '124');
INSERT INTO `role_resource` VALUES ('169', '3', '125');
INSERT INTO `role_resource` VALUES ('171', '3', '131');
INSERT INTO `role_resource` VALUES ('172', '3', '132');
INSERT INTO `role_resource` VALUES ('173', '3', '133');
INSERT INTO `role_resource` VALUES ('174', '3', '134');
INSERT INTO `role_resource` VALUES ('176', '3', '141');
INSERT INTO `role_resource` VALUES ('177', '3', '142');
INSERT INTO `role_resource` VALUES ('178', '3', '143');
INSERT INTO `role_resource` VALUES ('179', '3', '144');
INSERT INTO `role_resource` VALUES ('585', '8', '226');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `login_name` varchar(255) DEFAULT NULL COMMENT '登陆名',
  `role_name` varchar(255) DEFAULT NULL COMMENT '角色名',
  `opt_content` varchar(1024) DEFAULT NULL COMMENT '内容',
  `client_ip` varchar(255) DEFAULT NULL COMMENT '客户端ip',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=783 DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `login_name` varchar(64) NOT NULL COMMENT '登陆名',
  `name` varchar(64) NOT NULL COMMENT '用户名',
  `password` varchar(64) NOT NULL COMMENT '密码',
  `salt` varchar(36) DEFAULT NULL COMMENT '密码加密盐',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '性别',
  `age` tinyint(2) DEFAULT '0' COMMENT '年龄',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `user_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '用户类别',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '用户状态',
  `organization_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属机构',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDx_user_login_name` (`login_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'admin', '05a671c66aefea124cc08b76ea6d30bb', 'test', '0', '25', '18707173376', '0', '0', '1', '2015-12-06 13:14:05');
INSERT INTO `user` VALUES ('15', 'test', 'test', '05a671c66aefea124cc08b76ea6d30bb', 'test', '0', '25', '18707173376', '1', '0', '6', '2015-12-06 13:13:03');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(19) NOT NULL COMMENT '用户id',
  `role_id` bigint(19) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `idx_user_role_ids` (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('60', '1', '1');
INSERT INTO `user_role` VALUES ('61', '1', '2');
INSERT INTO `user_role` VALUES ('62', '1', '7');
INSERT INTO `user_role` VALUES ('65', '1', '8');
INSERT INTO `user_role` VALUES ('68', '15', '2');

-- ----------------------------
-- Table structure for video_cost
-- ----------------------------
DROP TABLE IF EXISTS `video_cost`;
CREATE TABLE `video_cost` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) DEFAULT '0' COMMENT '是否删除',
  `recored_date` date NOT NULL COMMENT '日期',
  `business_department` varchar(100) DEFAULT NULL COMMENT '业务部',
  `product_type` varchar(100) DEFAULT NULL COMMENT '产品类型',
  `customer_name` varchar(64) DEFAULT NULL COMMENT '客户名',
  `industry` varchar(32) DEFAULT NULL COMMENT '行业',
  `demand_sector` varchar(32) DEFAULT NULL COMMENT '需求部门',
  `optimizer` varchar(32) DEFAULT NULL COMMENT '优化师',
  `video_type` varchar(100) DEFAULT NULL COMMENT '视频类型',
  `complete_date` date DEFAULT NULL COMMENT '成片日期',
  `originality` varchar(100) DEFAULT NULL COMMENT '创意',
  `photographer` varchar(100) DEFAULT NULL COMMENT '摄像',
  `editor` varchar(100) DEFAULT NULL COMMENT '剪辑',
  `performer1` varchar(100) DEFAULT NULL COMMENT '演员1',
  `performer2` varchar(100) DEFAULT NULL COMMENT '演员2',
  `performer3` varchar(100) DEFAULT NULL COMMENT '演员3',
  `consumption` double DEFAULT '0' COMMENT '当日消耗',
  `cumulative_consumption` double DEFAULT '0' COMMENT '累计消耗',
  `cumulative_consumption_ranking` int(11) DEFAULT NULL COMMENT '消耗累积排名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='视频成片消耗';

-- ----------------------------
-- Records of video_cost
-- ----------------------------
