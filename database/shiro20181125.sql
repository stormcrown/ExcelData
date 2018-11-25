/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : shiro

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 25/11/2018 17:30:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户名',
  `originality_id` bigint(20) NULL DEFAULT NULL,
  `complete_date` date NULL DEFAULT NULL,
  `performer3_id` bigint(20) NULL DEFAULT NULL,
  `performer2_id` bigint(20) NULL DEFAULT NULL,
  `performer1_id` bigint(20) NULL DEFAULT NULL,
  `editor_id` bigint(20) NULL DEFAULT NULL,
  `photographer_id` bigint(20) NULL DEFAULT NULL,
  `video_type_id` bigint(20) NULL DEFAULT NULL,
  `product_type_id` bigint(20) NULL DEFAULT NULL,
  `industry_id` bigint(20) NULL DEFAULT NULL,
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户编码',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26742 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for editor
-- ----------------------------
DROP TABLE IF EXISTS `editor`;
CREATE TABLE `editor`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '剪辑师名称',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '剪辑师编码',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3071 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '剪辑师信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for industry
-- ----------------------------
DROP TABLE IF EXISTS `industry`;
CREATE TABLE `industry`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '行业名称',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '行业编码',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7102 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '行业信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for optimizer
-- ----------------------------
DROP TABLE IF EXISTS `optimizer`;
CREATE TABLE `optimizer`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '优化师名称',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '优化师编码',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4618 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优化师信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组织名',
  `simple_names` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `pid` bigint(19) NULL DEFAULT NULL COMMENT '父级主键',
  `seq` tinyint(2) NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组织机构' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of organization
-- ----------------------------
INSERT INTO `organization` VALUES (1, '总经办', NULL, '王家桥', '01', 'glyphicon-lock ', NULL, 0, '2014-02-19 01:00:00');
INSERT INTO `organization` VALUES (3, '技术部', NULL, '', '02', 'glyphicon-wrench ', NULL, 1, '2015-10-01 13:10:42');
INSERT INTO `organization` VALUES (5, '产品部', NULL, '', '03', 'glyphicon-send ', NULL, 2, '2015-12-06 12:15:30');
INSERT INTO `organization` VALUES (6, '业务部', NULL, '', '04', 'glyphicon-headphones ', 3, 0, '2015-12-06 13:12:18');
INSERT INTO `organization` VALUES (7, '社媒事业部', '社媒', NULL, '05', NULL, 6, 0, '2018-11-11 12:44:06');
INSERT INTO `organization` VALUES (8, '微博', NULL, NULL, 'ORG201811111415561382267343', NULL, 6, 0, '2018-11-11 14:15:57');
INSERT INTO `organization` VALUES (9, '全媒体', NULL, NULL, 'ORG201811111416011191351868', NULL, 6, 0, '2018-11-11 14:16:00');
INSERT INTO `organization` VALUES (10, '爱奇艺事业部', '爱奇艺', NULL, 'ORG201811111416112092577361', NULL, 6, 0, '2018-11-11 14:16:01');
INSERT INTO `organization` VALUES (11, 'TSA', NULL, NULL, 'ORG2018111114161611118370563', NULL, 6, 0, '2018-11-11 14:16:16');
INSERT INTO `organization` VALUES (12, '陌陌', NULL, NULL, 'ORG201811111416161869024526', NULL, 6, 0, '2018-11-11 14:16:17');
INSERT INTO `organization` VALUES (13, '陌陌快手', NULL, NULL, 'ORG2018111114161611805893622', NULL, 6, 0, '2018-11-11 14:16:17');
INSERT INTO `organization` VALUES (14, '凯美二部', NULL, NULL, 'ORG201811111416191376033414', NULL, 6, 0, '2018-11-11 14:16:19');
INSERT INTO `organization` VALUES (15, '国际事业部', NULL, NULL, 'ORG201811111416191957357652', NULL, 6, 0, '2018-11-11 14:16:19');
INSERT INTO `organization` VALUES (16, 'KA事业部', NULL, NULL, 'ORG201811111416191404563437', NULL, 6, 0, '2018-11-11 14:16:19');
INSERT INTO `organization` VALUES (17, '趣头条事业部', '趣头条', NULL, 'ORG2018111114162011865101232', NULL, 6, 0, '2018-11-11 14:16:20');
INSERT INTO `organization` VALUES (18, '淘宝客', NULL, NULL, 'ORG201811222042245130831228', NULL, NULL, 0, '2018-11-22 20:42:25');
INSERT INTO `organization` VALUES (19, 'APP', NULL, NULL, 'ORG2018112220422751679565121', NULL, NULL, 0, '2018-11-22 20:42:27');
INSERT INTO `organization` VALUES (20, '教育', NULL, NULL, 'ORG2018112220424051062192723', NULL, NULL, 0, '2018-11-22 20:42:40');
INSERT INTO `organization` VALUES (21, '产品', NULL, NULL, 'ORG201811222042525962355581', NULL, NULL, 0, '2018-11-22 20:42:53');
INSERT INTO `organization` VALUES (22, '健身服务', NULL, NULL, 'ORG201811222042535868506781', NULL, NULL, 0, '2018-11-22 20:42:53');
INSERT INTO `organization` VALUES (23, '企业服务', NULL, NULL, 'ORG2018112220425351901696673', NULL, NULL, 0, '2018-11-22 20:42:53');
INSERT INTO `organization` VALUES (24, '咨询', NULL, NULL, 'ORG2018112220425351934634175', NULL, NULL, 0, '2018-11-22 20:42:53');
INSERT INTO `organization` VALUES (25, '资讯', NULL, NULL, 'ORG2018112220425352112572391', NULL, NULL, 0, '2018-11-22 20:42:53');
INSERT INTO `organization` VALUES (26, '地产', NULL, NULL, 'ORG201811222043951886594175', NULL, NULL, 0, '2018-11-22 20:43:09');
INSERT INTO `organization` VALUES (27, '线下店铺', NULL, NULL, 'ORG20181122204395845946212', NULL, NULL, 0, '2018-11-22 20:43:09');
INSERT INTO `organization` VALUES (28, '线下活动', NULL, NULL, 'ORG201811222043951035196987', NULL, NULL, 0, '2018-11-22 20:43:09');
INSERT INTO `organization` VALUES (29, '电影宣传', NULL, NULL, 'ORG201811222043951938426000', NULL, NULL, 0, '2018-11-22 20:43:09');
INSERT INTO `organization` VALUES (30, '公众号', NULL, NULL, 'ORG20181122204395775395833', NULL, NULL, 0, '2018-11-22 20:43:09');
INSERT INTO `organization` VALUES (31, '产品宣传', NULL, NULL, 'ORG201811222043952066911552', NULL, NULL, 0, '2018-11-22 20:43:09');
INSERT INTO `organization` VALUES (32, '英语培训', NULL, NULL, 'ORG2018112220431151681335500', NULL, NULL, 0, '2018-11-22 20:43:11');
INSERT INTO `organization` VALUES (33, '婚纱摄影', NULL, NULL, 'ORG201811222043145284962185', NULL, NULL, 0, '2018-11-22 20:43:15');
INSERT INTO `organization` VALUES (34, '广告', NULL, NULL, 'ORG2018112220432151936000193', NULL, NULL, 0, '2018-11-22 20:43:22');
INSERT INTO `organization` VALUES (35, '宣传', NULL, NULL, 'ORG201811222043215619379185', NULL, NULL, 0, '2018-11-22 20:43:22');
INSERT INTO `organization` VALUES (36, '加盟', NULL, NULL, 'ORG2018112220432451423629282', NULL, NULL, 0, '2018-11-22 20:43:24');

-- ----------------------------
-- Table structure for originality
-- ----------------------------
DROP TABLE IF EXISTS `originality`;
CREATE TABLE `originality`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创意师名称',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创意师编码',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4941 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '创意师信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for performer
-- ----------------------------
DROP TABLE IF EXISTS `performer`;
CREATE TABLE `performer`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '演员名称',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '演员编码',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2006 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '演员信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for photographer
-- ----------------------------
DROP TABLE IF EXISTS `photographer`;
CREATE TABLE `photographer`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '摄像师名称',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '摄像师编码',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3657 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '摄像师信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_type
-- ----------------------------
DROP TABLE IF EXISTS `product_type`;
CREATE TABLE `product_type`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品类型名称',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品类型编码',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2263 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品类型信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资源名称',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源路径',
  `open_mode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '打开方式 ajax,iframe',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源介绍',
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源图标',
  `pid` bigint(19) NULL DEFAULT NULL COMMENT '父级资源id',
  `seq` tinyint(2) NOT NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '状态',
  `opened` tinyint(2) NOT NULL DEFAULT 1 COMMENT '打开状态',
  `resource_type` tinyint(2) NOT NULL DEFAULT 0 COMMENT '资源类别',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 287 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资源' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES (1, '权限管理', '', '', '系统管理', 'glyphicon-list icon-purple', NULL, 1, 0, 1, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (11, '资源管理', '/resource/manager', 'ajax', '资源管理', 'glyphicon-th ', 1, 1, 0, 1, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (12, '角色管理', '/role/manager', 'ajax', '角色管理', 'glyphicon-eye-open ', 1, 2, 0, 1, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (13, '用户管理', '/user/manager', 'ajax', '用户管理', 'glyphicon-user ', 1, 3, 0, 1, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (14, '部门管理', '/organization/manager', 'ajax', '部门管理', 'glyphicon-lock ', 1, 4, 0, 1, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (111, '列表', '/resource/treeGrid', 'ajax', '资源列表', 'glyphicon-list ', 11, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (112, '添加', '/resource/add', 'ajax', '资源添加', 'glyphicon-plus icon-green', 11, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (113, '编辑', '/resource/edit', 'ajax', '资源编辑', 'glyphicon-pencil icon-blue', 11, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (114, '删除', '/resource/delete', 'ajax', '资源删除', 'glyphicon-trash icon-red', 11, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (121, '列表', '/role/dataGrid', 'ajax', '角色列表', 'glyphicon-list ', 12, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (122, '添加', '/role/add', 'ajax', '角色添加', 'glyphicon-plus icon-green', 12, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (123, '编辑', '/role/edit', 'ajax', '角色编辑', 'glyphicon-pencil icon-blue', 12, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (124, '删除', '/role/delete', 'ajax', '角色删除', 'glyphicon-trash icon-red', 12, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (125, '授权', '/role/grant', 'ajax', '角色授权', 'glyphicon-ok icon-green', 12, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (131, '列表', '/user/dataGrid', 'ajax', '用户列表', 'glyphicon-list ', 13, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (132, '添加', '/user/add', 'ajax', '用户添加', 'glyphicon-plus icon-green', 13, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (133, '编辑', '/user/edit', 'ajax', '用户编辑', 'glyphicon-pencil icon-blue', 13, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (134, '删除', '/user/delete', 'ajax', '用户删除', 'glyphicon-trash icon-red', 13, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (141, '列表', '/organization/treeGrid', 'ajax', '用户列表', 'glyphicon-list ', 14, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (142, '添加', '/organization/add', 'ajax', '部门添加', 'glyphicon-plus icon-green', 14, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (143, '编辑', '/organization/edit', 'ajax', '部门编辑', 'glyphicon-pencil icon-blue', 14, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (144, '删除', '/organization/delete', 'ajax', '部门删除', 'glyphicon-trash icon-red', 14, 0, 0, 1, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (221, '日志监控', '', '', NULL, 'glyphicon-dashboard ', NULL, 2, 0, 0, 0, '2015-12-01 11:44:20');
INSERT INTO `resource` VALUES (226, '修改密码', '/user/editPwdPage', 'ajax', NULL, 'glyphicon-eye-close ', NULL, -1, 0, 1, 1, '2015-12-07 20:23:06');
INSERT INTO `resource` VALUES (227, '登录日志', '/sysLog/manager', 'ajax', NULL, 'glyphicon-exclamation-sign ', 221, 0, 0, 1, 0, '2016-09-30 22:10:53');
INSERT INTO `resource` VALUES (228, 'Druid监控', '/druid', 'iframe', NULL, 'glyphicon-sunglasses ', 221, 0, 0, 1, 0, '2016-09-30 22:12:50');
INSERT INTO `resource` VALUES (229, '系统图标', '/icons.html', 'ajax', NULL, 'glyphicon-picture ', 1, 5, 0, 1, 0, '2016-12-24 15:53:47');
INSERT INTO `resource` VALUES (233, '每日消耗', '/videoCost/manager', 'ajax', NULL, 'glyphicon-cd icon-red', 234, 0, 0, 1, 0, '2018-10-15 13:42:56');
INSERT INTO `resource` VALUES (234, '成片消耗', '', '', NULL, 'glyphicon-tint icon-red', NULL, 0, 0, 1, 0, '2018-10-15 13:50:29');
INSERT INTO `resource` VALUES (235, '列表', '/videoCost/dataGrid', 'ajax', NULL, 'glyphicon-list ', 233, 1, 0, 1, 1, '2018-10-15 14:16:04');
INSERT INTO `resource` VALUES (236, '添加', '/videoCost/add', 'ajax', NULL, 'glyphicon-plus icon-green', 233, 2, 0, 1, 1, '2018-10-15 14:16:52');
INSERT INTO `resource` VALUES (237, '编辑', '/videoCost/edit', 'ajax', NULL, 'glyphicon-pencil icon-purple', 233, 3, 0, 1, 1, '2018-10-15 14:17:34');
INSERT INTO `resource` VALUES (238, '删除', '/videoCost/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 233, 4, 0, 1, 1, '2018-10-15 14:18:55');
INSERT INTO `resource` VALUES (239, '导入Excel', '/videoCost/importExcel', 'ajax', NULL, 'glyphicon-open-file icon-blue', 233, 5, 0, 1, 1, '2018-10-15 14:25:10');
INSERT INTO `resource` VALUES (240, '导出Excel', '/videoCost/exportExcel', 'ajax', NULL, 'glyphicon-save-file icon-blue', 233, 6, 0, 1, 1, '2018-10-15 14:25:42');
INSERT INTO `resource` VALUES (241, '数据字典', '', NULL, NULL, 'glyphicon-book icon-blue', NULL, 0, 0, 1, 0, '2018-11-18 00:35:04');
INSERT INTO `resource` VALUES (242, '客户', '/customer/manager', 'ajax', NULL, 'glyphicon-user icon-green', 241, 0, 0, 1, 0, '2018-11-18 00:36:17');
INSERT INTO `resource` VALUES (243, '列表', '/customer/dataGrid', 'ajax', NULL, 'glyphicon-list icon-green', 242, 0, 0, 1, 1, '2018-11-18 00:49:20');
INSERT INTO `resource` VALUES (244, '添加', '/customer/add', 'ajax', NULL, 'glyphicon-plus icon-green', 242, 1, 0, 1, 1, '2018-11-18 00:50:02');
INSERT INTO `resource` VALUES (245, '编辑', '/customer/edit', 'ajax', NULL, 'glyphicon-pencil icon-green', 242, 2, 0, 1, 1, '2018-11-18 00:50:41');
INSERT INTO `resource` VALUES (246, '删除', '/customer/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 242, 3, 0, 1, 1, '2018-11-18 00:51:40');
INSERT INTO `resource` VALUES (247, '剪辑', '/editor/manager', '', NULL, 'glyphicon-scissors icon-yellow', 241, 1, 0, 1, 0, '2018-11-18 09:24:20');
INSERT INTO `resource` VALUES (248, '列表', '/editor/dataGrid', 'ajax', NULL, 'glyphicon-list icon-green', 247, 0, 0, 1, 1, '2018-11-18 09:25:34');
INSERT INTO `resource` VALUES (249, '添加', '/editor/add', 'ajax', NULL, 'glyphicon-plus icon-green', 247, 1, 0, 1, 1, '2018-11-18 09:26:49');
INSERT INTO `resource` VALUES (250, '编辑', '/editor/edit', 'ajax', NULL, 'glyphicon-pencil icon-blue', 247, 2, 0, 1, 1, '2018-11-18 09:27:40');
INSERT INTO `resource` VALUES (251, '删除', '/editor/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 247, 4, 0, 1, 1, '2018-11-18 09:28:18');
INSERT INTO `resource` VALUES (252, '行业', '/industry/manager', '', NULL, 'glyphicon-tasks icon-green', 241, 2, 0, 1, 0, '2018-11-18 09:30:31');
INSERT INTO `resource` VALUES (253, '列表', '/industry/dataGrid', 'ajax', NULL, 'glyphicon-list icon-green', 252, 0, 0, 1, 1, '2018-11-18 09:31:41');
INSERT INTO `resource` VALUES (254, '添加', '/industry/add', 'ajax', NULL, 'glyphicon-plus icon-green', 252, 1, 0, 1, 1, '2018-11-18 09:32:53');
INSERT INTO `resource` VALUES (255, '编辑', '/industry/edit', 'ajax', NULL, 'glyphicon-pencil icon-blue', 252, 2, 0, 1, 1, '2018-11-18 09:33:33');
INSERT INTO `resource` VALUES (256, '删除', '/industry/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 252, 3, 0, 1, 1, '2018-11-18 09:34:27');
INSERT INTO `resource` VALUES (257, '优化', '/optimizer/manager', '', NULL, 'glyphicon-magnet icon-yellow', 241, 3, 0, 1, 0, '2018-11-18 09:36:59');
INSERT INTO `resource` VALUES (258, '列表', '/optimizer/dataGrid', 'ajax', NULL, 'glyphicon-list icon-purple', 257, 0, 0, 1, 1, '2018-11-18 09:38:35');
INSERT INTO `resource` VALUES (259, '添加', '/optimizer/add', 'ajax', NULL, 'glyphicon-plus icon-green', 257, 1, 0, 1, 1, '2018-11-18 09:39:31');
INSERT INTO `resource` VALUES (260, '编辑', '/optimizer/edit', 'ajax', NULL, 'glyphicon-pencil icon-blue', 257, 2, 0, 1, 1, '2018-11-18 09:40:06');
INSERT INTO `resource` VALUES (261, '删除', '/optimizer/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 257, 3, 0, 1, 1, '2018-11-18 09:40:41');
INSERT INTO `resource` VALUES (262, '创意', '/originality/manager', '', NULL, 'glyphicon-star icon-yellow', 241, 4, 0, 1, 0, '2018-11-18 09:47:16');
INSERT INTO `resource` VALUES (263, '列表', '/originality/dataGrid', 'ajax', NULL, 'glyphicon-list icon-purple', 262, 0, 0, 1, 1, '2018-11-18 09:48:23');
INSERT INTO `resource` VALUES (264, '添加', '/originality/add', 'ajax', NULL, 'glyphicon-plus icon-green', 262, 1, 0, 1, 1, '2018-11-18 09:59:58');
INSERT INTO `resource` VALUES (265, '编辑', '/originality/edit', 'ajax', NULL, 'glyphicon-pencil icon-blue', 262, 2, 0, 1, 1, '2018-11-18 10:00:34');
INSERT INTO `resource` VALUES (266, '删除', '/originality/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 262, 3, 0, 1, 1, '2018-11-18 10:01:31');
INSERT INTO `resource` VALUES (267, '演员', '/performer/manager', '', NULL, 'glyphicon-eye-open icon-yellow', 241, 5, 0, 1, 0, '2018-11-18 10:04:09');
INSERT INTO `resource` VALUES (268, '列表', '/performer/dataGrid', 'ajax', NULL, 'glyphicon-list icon-purple', 267, 0, 0, 1, 1, '2018-11-18 10:06:11');
INSERT INTO `resource` VALUES (269, '添加', '/performer/add', 'ajax', NULL, 'glyphicon-plus icon-green', 267, 1, 0, 1, 1, '2018-11-18 10:06:40');
INSERT INTO `resource` VALUES (270, '编辑', '/performer/edit', 'ajax', NULL, 'glyphicon-pencil icon-blue', 267, 2, 0, 1, 1, '2018-11-18 10:07:20');
INSERT INTO `resource` VALUES (271, '删除', '/performer/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 267, 3, 0, 1, 1, '2018-11-18 10:07:53');
INSERT INTO `resource` VALUES (272, '摄像', '/photographer/manager', '', NULL, 'glyphicon-camera icon-yellow', 241, 6, 0, 1, 0, '2018-11-18 10:09:15');
INSERT INTO `resource` VALUES (273, '列表', '/photographer/dataGrid', 'ajax', NULL, 'glyphicon-list icon-purple', 272, 0, 0, 1, 1, '2018-11-18 10:09:59');
INSERT INTO `resource` VALUES (274, '添加', '/photographer/add', 'ajax', NULL, 'glyphicon-plus icon-green', 272, 1, 0, 1, 1, '2018-11-18 10:10:50');
INSERT INTO `resource` VALUES (275, '编辑', '/photographer/edit', 'ajax', NULL, 'glyphicon-pencil icon-blue', 272, 2, 0, 1, 1, '2018-11-18 10:11:22');
INSERT INTO `resource` VALUES (276, '删除', '/photographer/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 272, 3, 0, 1, 1, '2018-11-18 10:11:52');
INSERT INTO `resource` VALUES (277, '产品类型', '/productType/manager', '', NULL, 'glyphicon-th-large icon-yellow', 241, 7, 0, 1, 0, '2018-11-18 10:17:48');
INSERT INTO `resource` VALUES (278, '列表', '/productType/dataGrid', 'ajax', NULL, 'glyphicon-list icon-purple', 277, 0, 0, 1, 1, '2018-11-18 10:18:53');
INSERT INTO `resource` VALUES (279, '添加', '/productType/add', 'ajax', NULL, 'glyphicon-plus icon-green', 277, 1, 0, 1, 1, '2018-11-18 10:19:30');
INSERT INTO `resource` VALUES (280, '编辑', '/productType/edit', 'ajax', NULL, 'glyphicon-pencil icon-blue', 277, 2, 0, 1, 1, '2018-11-18 10:20:05');
INSERT INTO `resource` VALUES (281, '删除', '/productType/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 277, 3, 0, 1, 1, '2018-11-18 10:20:39');
INSERT INTO `resource` VALUES (282, '视频类别', '/videoType/manager', NULL, NULL, 'glyphicon-film icon-yellow', 241, 8, 0, 1, 0, '2018-11-18 10:24:09');
INSERT INTO `resource` VALUES (283, '列表', '/videoType/dataGrid', 'ajax', NULL, 'glyphicon-list icon-purple', 282, 0, 0, 1, 1, '2018-11-18 10:25:29');
INSERT INTO `resource` VALUES (284, '添加', '/videoType/add', 'ajax', NULL, 'glyphicon-plus icon-green', 282, 1, 0, 1, 1, '2018-11-18 10:26:11');
INSERT INTO `resource` VALUES (285, '编辑', '/videoType/edit', 'ajax', NULL, 'glyphicon-pencil icon-purple', 282, 2, 0, 1, 1, '2018-11-18 10:26:42');
INSERT INTO `resource` VALUES (286, '删除', '/videoType/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 282, 3, 0, 1, 1, '2018-11-18 10:27:16');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名',
  `seq` tinyint(2) NOT NULL DEFAULT 0 COMMENT '排序号',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'admin', 0, '超级管理员', 0);
INSERT INTO `role` VALUES (3, '主管', 0, '超级管理员', 0);

-- ----------------------------
-- Table structure for role_resource
-- ----------------------------
DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_id` bigint(19) NOT NULL COMMENT '角色id',
  `resource_id` bigint(19) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_resource_ids`(`role_id`, `resource_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1102 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色资源' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_resource
-- ----------------------------
INSERT INTO `role_resource` VALUES (995, 1, 1);
INSERT INTO `role_resource` VALUES (996, 1, 11);
INSERT INTO `role_resource` VALUES (1001, 1, 12);
INSERT INTO `role_resource` VALUES (1007, 1, 13);
INSERT INTO `role_resource` VALUES (1012, 1, 14);
INSERT INTO `role_resource` VALUES (997, 1, 111);
INSERT INTO `role_resource` VALUES (998, 1, 112);
INSERT INTO `role_resource` VALUES (999, 1, 113);
INSERT INTO `role_resource` VALUES (1000, 1, 114);
INSERT INTO `role_resource` VALUES (1002, 1, 121);
INSERT INTO `role_resource` VALUES (1003, 1, 122);
INSERT INTO `role_resource` VALUES (1004, 1, 123);
INSERT INTO `role_resource` VALUES (1005, 1, 124);
INSERT INTO `role_resource` VALUES (1006, 1, 125);
INSERT INTO `role_resource` VALUES (1008, 1, 131);
INSERT INTO `role_resource` VALUES (1009, 1, 132);
INSERT INTO `role_resource` VALUES (1010, 1, 133);
INSERT INTO `role_resource` VALUES (1011, 1, 134);
INSERT INTO `role_resource` VALUES (1013, 1, 141);
INSERT INTO `role_resource` VALUES (1014, 1, 142);
INSERT INTO `role_resource` VALUES (1015, 1, 143);
INSERT INTO `role_resource` VALUES (1016, 1, 144);
INSERT INTO `role_resource` VALUES (1018, 1, 221);
INSERT INTO `role_resource` VALUES (940, 1, 226);
INSERT INTO `role_resource` VALUES (1019, 1, 227);
INSERT INTO `role_resource` VALUES (1020, 1, 228);
INSERT INTO `role_resource` VALUES (1017, 1, 229);
INSERT INTO `role_resource` VALUES (942, 1, 233);
INSERT INTO `role_resource` VALUES (941, 1, 234);
INSERT INTO `role_resource` VALUES (943, 1, 235);
INSERT INTO `role_resource` VALUES (944, 1, 236);
INSERT INTO `role_resource` VALUES (945, 1, 237);
INSERT INTO `role_resource` VALUES (946, 1, 238);
INSERT INTO `role_resource` VALUES (947, 1, 239);
INSERT INTO `role_resource` VALUES (948, 1, 240);
INSERT INTO `role_resource` VALUES (949, 1, 241);
INSERT INTO `role_resource` VALUES (950, 1, 242);
INSERT INTO `role_resource` VALUES (951, 1, 243);
INSERT INTO `role_resource` VALUES (952, 1, 244);
INSERT INTO `role_resource` VALUES (953, 1, 245);
INSERT INTO `role_resource` VALUES (954, 1, 246);
INSERT INTO `role_resource` VALUES (955, 1, 247);
INSERT INTO `role_resource` VALUES (956, 1, 248);
INSERT INTO `role_resource` VALUES (957, 1, 249);
INSERT INTO `role_resource` VALUES (958, 1, 250);
INSERT INTO `role_resource` VALUES (959, 1, 251);
INSERT INTO `role_resource` VALUES (960, 1, 252);
INSERT INTO `role_resource` VALUES (961, 1, 253);
INSERT INTO `role_resource` VALUES (962, 1, 254);
INSERT INTO `role_resource` VALUES (963, 1, 255);
INSERT INTO `role_resource` VALUES (964, 1, 256);
INSERT INTO `role_resource` VALUES (965, 1, 257);
INSERT INTO `role_resource` VALUES (966, 1, 258);
INSERT INTO `role_resource` VALUES (967, 1, 259);
INSERT INTO `role_resource` VALUES (968, 1, 260);
INSERT INTO `role_resource` VALUES (969, 1, 261);
INSERT INTO `role_resource` VALUES (970, 1, 262);
INSERT INTO `role_resource` VALUES (971, 1, 263);
INSERT INTO `role_resource` VALUES (972, 1, 264);
INSERT INTO `role_resource` VALUES (973, 1, 265);
INSERT INTO `role_resource` VALUES (974, 1, 266);
INSERT INTO `role_resource` VALUES (975, 1, 267);
INSERT INTO `role_resource` VALUES (976, 1, 268);
INSERT INTO `role_resource` VALUES (977, 1, 269);
INSERT INTO `role_resource` VALUES (978, 1, 270);
INSERT INTO `role_resource` VALUES (979, 1, 271);
INSERT INTO `role_resource` VALUES (980, 1, 272);
INSERT INTO `role_resource` VALUES (981, 1, 273);
INSERT INTO `role_resource` VALUES (982, 1, 274);
INSERT INTO `role_resource` VALUES (983, 1, 275);
INSERT INTO `role_resource` VALUES (984, 1, 276);
INSERT INTO `role_resource` VALUES (985, 1, 277);
INSERT INTO `role_resource` VALUES (986, 1, 278);
INSERT INTO `role_resource` VALUES (987, 1, 279);
INSERT INTO `role_resource` VALUES (988, 1, 280);
INSERT INTO `role_resource` VALUES (989, 1, 281);
INSERT INTO `role_resource` VALUES (990, 1, 282);
INSERT INTO `role_resource` VALUES (991, 1, 283);
INSERT INTO `role_resource` VALUES (992, 1, 284);
INSERT INTO `role_resource` VALUES (993, 1, 285);
INSERT INTO `role_resource` VALUES (994, 1, 286);
INSERT INTO `role_resource` VALUES (745, 2, 233);
INSERT INTO `role_resource` VALUES (744, 2, 234);
INSERT INTO `role_resource` VALUES (746, 2, 235);
INSERT INTO `role_resource` VALUES (747, 2, 236);
INSERT INTO `role_resource` VALUES (748, 2, 237);
INSERT INTO `role_resource` VALUES (749, 2, 238);
INSERT INTO `role_resource` VALUES (1076, 3, 1);
INSERT INTO `role_resource` VALUES (1077, 3, 11);
INSERT INTO `role_resource` VALUES (1082, 3, 12);
INSERT INTO `role_resource` VALUES (1088, 3, 13);
INSERT INTO `role_resource` VALUES (1093, 3, 14);
INSERT INTO `role_resource` VALUES (1078, 3, 111);
INSERT INTO `role_resource` VALUES (1079, 3, 112);
INSERT INTO `role_resource` VALUES (1080, 3, 113);
INSERT INTO `role_resource` VALUES (1081, 3, 114);
INSERT INTO `role_resource` VALUES (1083, 3, 121);
INSERT INTO `role_resource` VALUES (1084, 3, 122);
INSERT INTO `role_resource` VALUES (1085, 3, 123);
INSERT INTO `role_resource` VALUES (1086, 3, 124);
INSERT INTO `role_resource` VALUES (1087, 3, 125);
INSERT INTO `role_resource` VALUES (1089, 3, 131);
INSERT INTO `role_resource` VALUES (1090, 3, 132);
INSERT INTO `role_resource` VALUES (1091, 3, 133);
INSERT INTO `role_resource` VALUES (1092, 3, 134);
INSERT INTO `role_resource` VALUES (1094, 3, 141);
INSERT INTO `role_resource` VALUES (1095, 3, 142);
INSERT INTO `role_resource` VALUES (1096, 3, 143);
INSERT INTO `role_resource` VALUES (1097, 3, 144);
INSERT INTO `role_resource` VALUES (1099, 3, 221);
INSERT INTO `role_resource` VALUES (1021, 3, 226);
INSERT INTO `role_resource` VALUES (1100, 3, 227);
INSERT INTO `role_resource` VALUES (1101, 3, 228);
INSERT INTO `role_resource` VALUES (1098, 3, 229);
INSERT INTO `role_resource` VALUES (1023, 3, 233);
INSERT INTO `role_resource` VALUES (1022, 3, 234);
INSERT INTO `role_resource` VALUES (1024, 3, 235);
INSERT INTO `role_resource` VALUES (1025, 3, 236);
INSERT INTO `role_resource` VALUES (1026, 3, 237);
INSERT INTO `role_resource` VALUES (1027, 3, 238);
INSERT INTO `role_resource` VALUES (1028, 3, 239);
INSERT INTO `role_resource` VALUES (1029, 3, 240);
INSERT INTO `role_resource` VALUES (1030, 3, 241);
INSERT INTO `role_resource` VALUES (1031, 3, 242);
INSERT INTO `role_resource` VALUES (1032, 3, 243);
INSERT INTO `role_resource` VALUES (1033, 3, 244);
INSERT INTO `role_resource` VALUES (1034, 3, 245);
INSERT INTO `role_resource` VALUES (1035, 3, 246);
INSERT INTO `role_resource` VALUES (1036, 3, 247);
INSERT INTO `role_resource` VALUES (1037, 3, 248);
INSERT INTO `role_resource` VALUES (1038, 3, 249);
INSERT INTO `role_resource` VALUES (1039, 3, 250);
INSERT INTO `role_resource` VALUES (1040, 3, 251);
INSERT INTO `role_resource` VALUES (1041, 3, 252);
INSERT INTO `role_resource` VALUES (1042, 3, 253);
INSERT INTO `role_resource` VALUES (1043, 3, 254);
INSERT INTO `role_resource` VALUES (1044, 3, 255);
INSERT INTO `role_resource` VALUES (1045, 3, 256);
INSERT INTO `role_resource` VALUES (1046, 3, 257);
INSERT INTO `role_resource` VALUES (1047, 3, 258);
INSERT INTO `role_resource` VALUES (1048, 3, 259);
INSERT INTO `role_resource` VALUES (1049, 3, 260);
INSERT INTO `role_resource` VALUES (1050, 3, 261);
INSERT INTO `role_resource` VALUES (1051, 3, 262);
INSERT INTO `role_resource` VALUES (1052, 3, 263);
INSERT INTO `role_resource` VALUES (1053, 3, 264);
INSERT INTO `role_resource` VALUES (1054, 3, 265);
INSERT INTO `role_resource` VALUES (1055, 3, 266);
INSERT INTO `role_resource` VALUES (1056, 3, 267);
INSERT INTO `role_resource` VALUES (1057, 3, 268);
INSERT INTO `role_resource` VALUES (1058, 3, 269);
INSERT INTO `role_resource` VALUES (1059, 3, 270);
INSERT INTO `role_resource` VALUES (1060, 3, 271);
INSERT INTO `role_resource` VALUES (1061, 3, 272);
INSERT INTO `role_resource` VALUES (1062, 3, 273);
INSERT INTO `role_resource` VALUES (1063, 3, 274);
INSERT INTO `role_resource` VALUES (1064, 3, 275);
INSERT INTO `role_resource` VALUES (1065, 3, 276);
INSERT INTO `role_resource` VALUES (1066, 3, 277);
INSERT INTO `role_resource` VALUES (1067, 3, 278);
INSERT INTO `role_resource` VALUES (1068, 3, 279);
INSERT INTO `role_resource` VALUES (1069, 3, 280);
INSERT INTO `role_resource` VALUES (1070, 3, 281);
INSERT INTO `role_resource` VALUES (1071, 3, 282);
INSERT INTO `role_resource` VALUES (1072, 3, 283);
INSERT INTO `role_resource` VALUES (1073, 3, 284);
INSERT INTO `role_resource` VALUES (1074, 3, 285);
INSERT INTO `role_resource` VALUES (1075, 3, 286);
INSERT INTO `role_resource` VALUES (585, 8, 226);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `login_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登陆名',
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `opt_content` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `client_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户端ip',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1367 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (391, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=1&_=1539572439049&', '0:0:0:0:0:0:0:1', '2018-10-15 11:09:51');
INSERT INTO `sys_log` VALUES (392, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1539572439051&', '0:0:0:0:0:0:0:1', '2018-10-15 11:10:04');
INSERT INTO `sys_log` VALUES (393, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,230,231,222,223,224,221,227,228,226&', '0:0:0:0:0:0:0:1', '2018-10-15 11:10:16');
INSERT INTO `sys_log` VALUES (394, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:delete,[参数]:id=230&', '0:0:0:0:0:0:0:1', '2018-10-15 11:10:53');
INSERT INTO `sys_log` VALUES (395, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:delete,[参数]:id=231&', '0:0:0:0:0:0:0:1', '2018-10-15 11:11:06');
INSERT INTO `sys_log` VALUES (396, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:delete,[参数]:id=224&', '0:0:0:0:0:0:0:1', '2018-10-15 11:11:10');
INSERT INTO `sys_log` VALUES (397, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:delete,[参数]:id=223&', '0:0:0:0:0:0:0:1', '2018-10-15 11:11:14');
INSERT INTO `sys_log` VALUES (398, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:delete,[参数]:id=222&', '0:0:0:0:0:0:0:1', '2018-10-15 11:11:17');
INSERT INTO `sys_log` VALUES (399, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=1&_=1539573081848&', '0:0:0:0:0:0:0:1', '2018-10-15 11:11:37');
INSERT INTO `sys_log` VALUES (400, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=1&name=权限管理&resourceType=0&url=&openMode=&icon=glyphicon-list icon-blue&seq=0&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-15 11:11:52');
INSERT INTO `sys_log` VALUES (401, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=1&_=1539573081850&', '0:0:0:0:0:0:0:1', '2018-10-15 11:12:00');
INSERT INTO `sys_log` VALUES (402, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=1&name=权限管理&resourceType=0&url=&openMode=&icon=glyphicon-list icon-purple&seq=0&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-15 11:12:08');
INSERT INTO `sys_log` VALUES (403, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-15 13:39:33');
INSERT INTO `sys_log` VALUES (404, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=视频成片消耗&resourceType=0&url=&openMode=无(用于上层菜单)&icon=glyphicon-briefcase icon-green&seq=0&status=0&opened=0&pid=&', '0:0:0:0:0:0:0:1', '2018-10-15 13:41:09');
INSERT INTO `sys_log` VALUES (405, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-15 13:41:46');
INSERT INTO `sys_log` VALUES (406, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=每日消耗&resourceType=0&url=/videoCost/manager&openMode=ajax&icon=glyphicon-book &seq=0&status=0&opened=0&pid=232&', '0:0:0:0:0:0:0:1', '2018-10-15 13:42:56');
INSERT INTO `sys_log` VALUES (407, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=232&_=1539573185114&', '0:0:0:0:0:0:0:1', '2018-10-15 13:43:31');
INSERT INTO `sys_log` VALUES (408, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=232&name=视频成片消耗&resourceType=0&url=&openMode=无(用于上层菜单)&icon=glyphicon-briefcase icon-green&seq=1&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-15 13:43:48');
INSERT INTO `sys_log` VALUES (409, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=232&_=1539582235498&', '0:0:0:0:0:0:0:1', '2018-10-15 13:44:11');
INSERT INTO `sys_log` VALUES (410, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=232&name=视频成片消耗&resourceType=0&url=&openMode=ajax&icon=glyphicon-briefcase icon-green&seq=1&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-15 13:44:15');
INSERT INTO `sys_log` VALUES (411, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=232&_=1539582259623&', '0:0:0:0:0:0:0:1', '2018-10-15 13:44:36');
INSERT INTO `sys_log` VALUES (412, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1539582259626&', '0:0:0:0:0:0:0:1', '2018-10-15 13:45:59');
INSERT INTO `sys_log` VALUES (413, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=233&name=每日消耗&resourceType=1&url=/videoCost/manager&openMode=&icon=glyphicon-book &seq=0&status=0&opened=0&pid=232&', '0:0:0:0:0:0:0:1', '2018-10-15 13:46:04');
INSERT INTO `sys_log` VALUES (414, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=232&_=1539582259627&', '0:0:0:0:0:0:0:1', '2018-10-15 13:46:53');
INSERT INTO `sys_log` VALUES (415, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:delete,[参数]:id=232&', '0:0:0:0:0:0:0:1', '2018-10-15 13:46:58');
INSERT INTO `sys_log` VALUES (416, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1539582259628&', '0:0:0:0:0:0:0:1', '2018-10-15 13:47:10');
INSERT INTO `sys_log` VALUES (417, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=233&name=每日消耗&resourceType=1&url=/videoCost/manager&openMode=&icon=glyphicon-book &seq=0&status=0&opened=0&pid=1&', '0:0:0:0:0:0:0:1', '2018-10-15 13:47:16');
INSERT INTO `sys_log` VALUES (418, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1539582259629&', '0:0:0:0:0:0:0:1', '2018-10-15 13:47:24');
INSERT INTO `sys_log` VALUES (419, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=233&name=每日消耗&resourceType=1&url=/videoCost/manager&openMode=&icon=glyphicon-book &seq=0&status=0&opened=1&pid=1&', '0:0:0:0:0:0:0:1', '2018-10-15 13:47:31');
INSERT INTO `sys_log` VALUES (420, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1539582454444&', '0:0:0:0:0:0:0:1', '2018-10-15 13:47:44');
INSERT INTO `sys_log` VALUES (421, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=233&name=每日消耗&resourceType=1&url=/videoCost/manager&openMode=ajax&icon=glyphicon-book &seq=0&status=0&opened=1&pid=1&', '0:0:0:0:0:0:0:1', '2018-10-15 13:47:48');
INSERT INTO `sys_log` VALUES (422, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1539582470298&', '0:0:0:0:0:0:0:1', '2018-10-15 13:48:13');
INSERT INTO `sys_log` VALUES (423, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=233&name=每日消耗&resourceType=0&url=/videoCost/manager&openMode=ajax&icon=glyphicon-book &seq=0&status=0&opened=1&pid=1&', '0:0:0:0:0:0:0:1', '2018-10-15 13:48:16');
INSERT INTO `sys_log` VALUES (424, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-15 13:49:41');
INSERT INTO `sys_log` VALUES (425, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=成片消耗&resourceType=0&url=&openMode=无(用于上层菜单)&icon=glyphicon-th-list &seq=0&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-15 13:50:29');
INSERT INTO `sys_log` VALUES (426, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1539582470302&', '0:0:0:0:0:0:0:1', '2018-10-15 13:50:38');
INSERT INTO `sys_log` VALUES (427, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=233&name=每日消耗&resourceType=0&url=/videoCost/manager&openMode=ajax&icon=glyphicon-book &seq=0&status=0&opened=1&pid=234&', '0:0:0:0:0:0:0:1', '2018-10-15 13:50:42');
INSERT INTO `sys_log` VALUES (428, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:editPage,[参数]:id=1&_=1539581587692&', '0:0:0:0:0:0:0:1', '2018-10-15 14:11:40');
INSERT INTO `sys_log` VALUES (429, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1539581587693&', '0:0:0:0:0:0:0:1', '2018-10-15 14:11:44');
INSERT INTO `sys_log` VALUES (430, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,234,233,221,227,228,226&', '0:0:0:0:0:0:0:1', '2018-10-15 14:11:50');
INSERT INTO `sys_log` VALUES (431, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=2&_=1539583912984&', '0:0:0:0:0:0:0:1', '2018-10-15 14:12:08');
INSERT INTO `sys_log` VALUES (432, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=2&resourceIds=1,13,131,132,133,234,233,221,227,228&', '0:0:0:0:0:0:0:1', '2018-10-15 14:12:16');
INSERT INTO `sys_log` VALUES (433, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-15 14:14:41');
INSERT INTO `sys_log` VALUES (434, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=1&url=/videoCost/dataGrid&openMode=ajax&icon=glyphicon-list &seq=1&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-15 14:16:04');
INSERT INTO `sys_log` VALUES (435, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-15 14:16:17');
INSERT INTO `sys_log` VALUES (436, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=1&url=/videoCost/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=2&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-15 14:16:52');
INSERT INTO `sys_log` VALUES (437, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-15 14:16:57');
INSERT INTO `sys_log` VALUES (438, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=1&url=&openMode=ajax&icon=glyphicon-pencil icon-green&seq=3&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-15 14:17:34');
INSERT INTO `sys_log` VALUES (439, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=237&_=1539583912993&', '0:0:0:0:0:0:0:1', '2018-10-15 14:17:38');
INSERT INTO `sys_log` VALUES (440, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=237&name=编辑&resourceType=1&url=/videoCost/edit&openMode=ajax&icon=glyphicon-pencil icon-green&seq=3&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-15 14:18:03');
INSERT INTO `sys_log` VALUES (441, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=237&_=1539583912994&', '0:0:0:0:0:0:0:1', '2018-10-15 14:18:10');
INSERT INTO `sys_log` VALUES (442, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=237&name=编辑&resourceType=1&url=/videoCost/edit&openMode=ajax&icon=glyphicon-pencil icon-purple&seq=3&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-15 14:18:15');
INSERT INTO `sys_log` VALUES (443, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-15 14:18:22');
INSERT INTO `sys_log` VALUES (444, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=1&url=&openMode=ajax&icon=glyphicon-trash icon-red&seq=4&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-15 14:18:55');
INSERT INTO `sys_log` VALUES (445, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=238&_=1539583912998&', '0:0:0:0:0:0:0:1', '2018-10-15 14:18:58');
INSERT INTO `sys_log` VALUES (446, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=238&name=删除&resourceType=1&url=/videoCost/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=4&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-15 14:19:09');
INSERT INTO `sys_log` VALUES (447, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-15 14:21:25');
INSERT INTO `sys_log` VALUES (448, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=导入Excel&resourceType=1&url=/videoCost/import&openMode=ajax&icon=glyphicon-align-justify icon-blue&seq=5&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-15 14:24:01');
INSERT INTO `sys_log` VALUES (449, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=导入Excel&resourceType=1&url=/videoCost/import&openMode=ajax&icon=glyphicon-align-justify icon-blue&seq=5&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-15 14:24:05');
INSERT INTO `sys_log` VALUES (450, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-15 14:24:34');
INSERT INTO `sys_log` VALUES (451, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=导入Excel&resourceType=1&url=&openMode=ajax&icon=glyphicon-open-file icon-blue&seq=5&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-15 14:25:10');
INSERT INTO `sys_log` VALUES (452, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-15 14:25:15');
INSERT INTO `sys_log` VALUES (453, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=导出Excel&resourceType=1&url=&openMode=ajax&icon=glyphicon-save-file icon-blue&seq=0&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-15 14:25:42');
INSERT INTO `sys_log` VALUES (454, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=240&_=1539584659715&', '0:0:0:0:0:0:0:1', '2018-10-15 14:25:54');
INSERT INTO `sys_log` VALUES (455, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=240&name=导出Excel&resourceType=1&url=&openMode=ajax&icon=glyphicon-save-file icon-blue&seq=6&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-15 14:25:58');
INSERT INTO `sys_log` VALUES (456, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:editPage,[参数]:id=1&_=1539584659717&', '0:0:0:0:0:0:0:1', '2018-10-15 14:26:22');
INSERT INTO `sys_log` VALUES (457, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:edit,[参数]:id=1&name=admin&seq=0&status=0&description=超级管理员&', '0:0:0:0:0:0:0:1', '2018-10-15 14:26:23');
INSERT INTO `sys_log` VALUES (458, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1539584659718&', '0:0:0:0:0:0:0:1', '2018-10-15 14:26:24');
INSERT INTO `sys_log` VALUES (459, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,234,233,235,236,237,238,239,240,221,227,228,226&', '0:0:0:0:0:0:0:1', '2018-10-15 14:26:36');
INSERT INTO `sys_log` VALUES (460, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPwdPage,[参数]:', NULL, '2018-10-15 15:40:57');
INSERT INTO `sys_log` VALUES (461, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=2&_=1539589902469&', '0:0:0:0:0:0:0:1', '2018-10-15 15:52:41');
INSERT INTO `sys_log` VALUES (462, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:editPage,[参数]:id=2&_=1539589902470&', '0:0:0:0:0:0:0:1', '2018-10-15 15:53:14');
INSERT INTO `sys_log` VALUES (463, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:editPage,[参数]:id=8&_=1539589902471&', '0:0:0:0:0:0:0:1', '2018-10-15 15:53:18');
INSERT INTO `sys_log` VALUES (464, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=8&_=1539589902472&', '0:0:0:0:0:0:0:1', '2018-10-15 15:53:20');
INSERT INTO `sys_log` VALUES (465, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=8&resourceIds=226&', '0:0:0:0:0:0:0:1', '2018-10-15 15:53:46');
INSERT INTO `sys_log` VALUES (466, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=8&_=1539589902473&', '0:0:0:0:0:0:0:1', '2018-10-15 15:53:48');
INSERT INTO `sys_log` VALUES (467, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=8&resourceIds=226&', '0:0:0:0:0:0:0:1', '2018-10-15 15:53:56');
INSERT INTO `sys_log` VALUES (468, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:delete,[参数]:id=8&', '0:0:0:0:0:0:0:1', '2018-10-15 15:54:00');
INSERT INTO `sys_log` VALUES (469, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=7&_=1539589902474&', '0:0:0:0:0:0:0:1', '2018-10-15 15:54:07');
INSERT INTO `sys_log` VALUES (470, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=7&resourceIds=&', '0:0:0:0:0:0:0:1', '2018-10-15 15:54:29');
INSERT INTO `sys_log` VALUES (471, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:delete,[参数]:id=7&', '0:0:0:0:0:0:0:1', '2018-10-15 15:54:32');
INSERT INTO `sys_log` VALUES (472, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=2&_=1539589902475&', '0:0:0:0:0:0:0:1', '2018-10-15 15:54:34');
INSERT INTO `sys_log` VALUES (473, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=2&resourceIds=234,233,235,236,239,240&', '0:0:0:0:0:0:0:1', '2018-10-15 15:55:22');
INSERT INTO `sys_log` VALUES (474, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:editPage,[参数]:id=2&_=1539589902476&', '0:0:0:0:0:0:0:1', '2018-10-15 15:55:25');
INSERT INTO `sys_log` VALUES (475, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:edit,[参数]:id=2&name=de&seq=1&status=0&description=普通用户&', '0:0:0:0:0:0:0:1', '2018-10-15 15:55:40');
INSERT INTO `sys_log` VALUES (476, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1539589902477&', '0:0:0:0:0:0:0:1', '2018-10-15 15:55:43');
INSERT INTO `sys_log` VALUES (477, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,234,233,235,236,237,238,239,240,221,227,228,226&', '0:0:0:0:0:0:0:1', '2018-10-15 15:55:47');
INSERT INTO `sys_log` VALUES (478, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-15 16:45:00');
INSERT INTO `sys_log` VALUES (479, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-15 17:12:39');
INSERT INTO `sys_log` VALUES (480, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-15 17:12:46');
INSERT INTO `sys_log` VALUES (481, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-15 17:12:55');
INSERT INTO `sys_log` VALUES (482, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-16 10:57:23');
INSERT INTO `sys_log` VALUES (483, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 18:18:30');
INSERT INTO `sys_log` VALUES (484, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 18:18:40');
INSERT INTO `sys_log` VALUES (485, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 18:19:07');
INSERT INTO `sys_log` VALUES (486, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:addPage,[参数]:', NULL, '2018-10-18 18:19:16');
INSERT INTO `sys_log` VALUES (487, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 18:54:22');
INSERT INTO `sys_log` VALUES (488, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 19:14:32');
INSERT INTO `sys_log` VALUES (489, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 19:19:43');
INSERT INTO `sys_log` VALUES (490, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 19:20:50');
INSERT INTO `sys_log` VALUES (491, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 19:22:06');
INSERT INTO `sys_log` VALUES (492, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-10-18 21:41:14');
INSERT INTO `sys_log` VALUES (493, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 21:41:23');
INSERT INTO `sys_log` VALUES (494, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=&', '0:0:0:0:0:0:0:1', '2018-10-18 21:41:24');
INSERT INTO `sys_log` VALUES (495, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 21:51:54');
INSERT INTO `sys_log` VALUES (496, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 22:07:55');
INSERT INTO `sys_log` VALUES (497, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 22:13:52');
INSERT INTO `sys_log` VALUES (498, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-09-05 00:00:01&', '0:0:0:0:0:0:0:1', '2018-10-18 22:14:20');
INSERT INTO `sys_log` VALUES (499, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 22:15:54');
INSERT INTO `sys_log` VALUES (500, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-01-01T00:00&', '0:0:0:0:0:0:0:1', '2018-10-18 22:16:08');
INSERT INTO `sys_log` VALUES (501, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 22:16:36');
INSERT INTO `sys_log` VALUES (502, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-01-01&', '0:0:0:0:0:0:0:1', '2018-10-18 22:16:43');
INSERT INTO `sys_log` VALUES (503, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 22:16:48');
INSERT INTO `sys_log` VALUES (504, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=测试日期&productType=&customerName=&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-01-02&', '0:0:0:0:0:0:0:1', '2018-10-18 22:17:04');
INSERT INTO `sys_log` VALUES (505, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 22:31:29');
INSERT INTO `sys_log` VALUES (506, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=测试数据完整&productType=测试数据完整&customerName=测试数据完整&industry=测试数据完整&demandSector=测试数据完整&optimizer=测试数据完整&videoType=测试数据完整&completeDate=2018-10-11&originality=测试数据完整&photographer=测试数据完整&editor=测试数据完整&performer1=测试数据完整&performer2=测试数据完整&performer3=测试数据完整&consumption=55&cumulativeConsumption=555&cumulativeConsumptionRanking=2&recoredDate=2018-10-17&', '0:0:0:0:0:0:0:1', '2018-10-18 22:34:45');
INSERT INTO `sys_log` VALUES (507, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 22:56:24');
INSERT INTO `sys_log` VALUES (508, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 23:03:01');
INSERT INTO `sys_log` VALUES (509, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=&industry=&demandSector=&optimizer=&videoType=&completeDate=2018-10-28&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-28&', '0:0:0:0:0:0:0:1', '2018-10-18 23:03:09');
INSERT INTO `sys_log` VALUES (510, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=15&_=1539871661096&', '0:0:0:0:0:0:0:1', '2018-10-18 23:03:56');
INSERT INTO `sys_log` VALUES (511, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=15&_=1539875458080&', '0:0:0:0:0:0:0:1', '2018-10-18 23:12:17');
INSERT INTO `sys_log` VALUES (512, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539875458081&', '0:0:0:0:0:0:0:1', '2018-10-18 23:16:37');
INSERT INTO `sys_log` VALUES (513, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-18 23:17:46');
INSERT INTO `sys_log` VALUES (514, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539875861946&', '0:0:0:0:0:0:0:1', '2018-10-18 23:17:59');
INSERT INTO `sys_log` VALUES (515, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=14&_=1539875861947&', '0:0:0:0:0:0:0:1', '2018-10-18 23:18:20');
INSERT INTO `sys_log` VALUES (516, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539876133070&', '0:0:0:0:0:0:0:1', '2018-10-18 23:22:19');
INSERT INTO `sys_log` VALUES (517, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539876133071&', '0:0:0:0:0:0:0:1', '2018-10-18 23:22:30');
INSERT INTO `sys_log` VALUES (518, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539876345819&', '0:0:0:0:0:0:0:1', '2018-10-18 23:26:02');
INSERT INTO `sys_log` VALUES (519, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=11&_=1539876345820&', '0:0:0:0:0:0:0:1', '2018-10-18 23:26:15');
INSERT INTO `sys_log` VALUES (520, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 16:15:35');
INSERT INTO `sys_log` VALUES (521, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539936413247&', '0:0:0:0:0:0:0:1', '2018-10-19 16:15:42');
INSERT INTO `sys_log` VALUES (522, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=14&_=1539937053266&', '0:0:0:0:0:0:0:1', '2018-10-19 16:17:58');
INSERT INTO `sys_log` VALUES (523, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539937111145&', '0:0:0:0:0:0:0:1', '2018-10-19 16:18:37');
INSERT INTO `sys_log` VALUES (524, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539937111146&', '0:0:0:0:0:0:0:1', '2018-10-19 16:19:36');
INSERT INTO `sys_log` VALUES (525, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539937111147&', '0:0:0:0:0:0:0:1', '2018-10-19 16:19:49');
INSERT INTO `sys_log` VALUES (526, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539937211033&', '0:0:0:0:0:0:0:1', '2018-10-19 16:21:02');
INSERT INTO `sys_log` VALUES (527, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539937211034&', '0:0:0:0:0:0:0:1', '2018-10-19 16:21:18');
INSERT INTO `sys_log` VALUES (528, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539937293272&', '0:0:0:0:0:0:0:1', '2018-10-19 16:22:53');
INSERT INTO `sys_log` VALUES (529, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539937373955&', '0:0:0:0:0:0:0:1', '2018-10-19 16:23:00');
INSERT INTO `sys_log` VALUES (530, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=10&recoredDate=2018-10-15&', '0:0:0:0:0:0:0:1', '2018-10-19 16:23:17');
INSERT INTO `sys_log` VALUES (531, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539937373956&', '0:0:0:0:0:0:0:1', '2018-10-19 16:23:19');
INSERT INTO `sys_log` VALUES (532, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539937373957&', '0:0:0:0:0:0:0:1', '2018-10-19 16:23:26');
INSERT INTO `sys_log` VALUES (533, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 16:35:43');
INSERT INTO `sys_log` VALUES (534, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 16:44:03');
INSERT INTO `sys_log` VALUES (535, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 16:45:19');
INSERT INTO `sys_log` VALUES (536, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 16:45:55');
INSERT INTO `sys_log` VALUES (537, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 16:48:47');
INSERT INTO `sys_log` VALUES (538, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539939990133&', '0:0:0:0:0:0:0:1', '2018-10-19 17:06:36');
INSERT INTO `sys_log` VALUES (539, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 17:06:38');
INSERT INTO `sys_log` VALUES (540, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 17:08:52');
INSERT INTO `sys_log` VALUES (541, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 17:08:55');
INSERT INTO `sys_log` VALUES (542, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 17:09:05');
INSERT INTO `sys_log` VALUES (543, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 17:24:32');
INSERT INTO `sys_log` VALUES (544, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 17:29:00');
INSERT INTO `sys_log` VALUES (545, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 18:15:58');
INSERT INTO `sys_log` VALUES (546, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 18:18:52');
INSERT INTO `sys_log` VALUES (547, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 18:19:04');
INSERT INTO `sys_log` VALUES (548, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539944340579&', '0:0:0:0:0:0:0:1', '2018-10-19 18:19:20');
INSERT INTO `sys_log` VALUES (549, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1539944340580&', '0:0:0:0:0:0:0:1', '2018-10-19 18:19:27');
INSERT INTO `sys_log` VALUES (550, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 18:19:32');
INSERT INTO `sys_log` VALUES (551, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 18:21:45');
INSERT INTO `sys_log` VALUES (552, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 18:23:51');
INSERT INTO `sys_log` VALUES (553, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 18:25:34');
INSERT INTO `sys_log` VALUES (554, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-19 18:29:42');
INSERT INTO `sys_log` VALUES (555, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 11:23:10');
INSERT INTO `sys_log` VALUES (556, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 11:26:11');
INSERT INTO `sys_log` VALUES (557, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 11:26:24');
INSERT INTO `sys_log` VALUES (558, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.OrganizationController,[方法]:editPage,[参数]:id=3&_=1540092076955&', '0:0:0:0:0:0:0:1', '2018-10-21 11:26:47');
INSERT INTO `sys_log` VALUES (559, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.OrganizationController,[方法]:editPage,[参数]:id=3&_=1540092076956&', '0:0:0:0:0:0:0:1', '2018-10-21 11:28:03');
INSERT INTO `sys_log` VALUES (560, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 11:28:10');
INSERT INTO `sys_log` VALUES (561, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 11:53:24');
INSERT INTO `sys_log` VALUES (562, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 11:54:14');
INSERT INTO `sys_log` VALUES (563, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 11:56:34');
INSERT INTO `sys_log` VALUES (564, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 12:19:07');
INSERT INTO `sys_log` VALUES (565, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 12:21:15');
INSERT INTO `sys_log` VALUES (566, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 12:47:33');
INSERT INTO `sys_log` VALUES (567, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 12:48:54');
INSERT INTO `sys_log` VALUES (568, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=&industry=&demandSector=&optimizer=&videoType=&completeDate=2018-10-21&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-09-05&', '0:0:0:0:0:0:0:1', '2018-10-21 13:40:59');
INSERT INTO `sys_log` VALUES (569, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 13:41:02');
INSERT INTO `sys_log` VALUES (570, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 13:42:51');
INSERT INTO `sys_log` VALUES (571, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 13:45:08');
INSERT INTO `sys_log` VALUES (572, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 13:46:57');
INSERT INTO `sys_log` VALUES (573, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 13:48:00');
INSERT INTO `sys_log` VALUES (574, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-21 13:51:55');
INSERT INTO `sys_log` VALUES (575, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=12&', '0:0:0:0:0:0:0:1', '2018-10-22 08:52:51');
INSERT INTO `sys_log` VALUES (576, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=12&', '0:0:0:0:0:0:0:1', '2018-10-22 08:52:56');
INSERT INTO `sys_log` VALUES (577, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=11&', '0:0:0:0:0:0:0:1', '2018-10-22 08:53:03');
INSERT INTO `sys_log` VALUES (578, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-22 09:01:08');
INSERT INTO `sys_log` VALUES (579, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-22 09:02:05');
INSERT INTO `sys_log` VALUES (580, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=测试数据完整&productType=测试数据完整&customerName=v&industry=测试数据完整&demandSector=测试数据完整&optimizer=测试数据完整&videoType=测试数据完整&completeDate=2018-10-22&originality=测试数据完整&photographer=测试数据完整&editor=测试数据完整&performer1=测试数据完整&performer2=测试数据完整&performer3=测试数据完整&consumption=33&cumulativeConsumption=33&cumulativeConsumptionRanking=1&recoredDate=2018-10-22&', '0:0:0:0:0:0:0:1', '2018-10-22 09:02:45');
INSERT INTO `sys_log` VALUES (581, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-22 09:03:40');
INSERT INTO `sys_log` VALUES (582, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-09-05&', '0:0:0:0:0:0:0:1', '2018-10-22 09:03:43');
INSERT INTO `sys_log` VALUES (583, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=12&', '0:0:0:0:0:0:0:1', '2018-10-22 09:04:21');
INSERT INTO `sys_log` VALUES (584, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=19&', '0:0:0:0:0:0:0:1', '2018-10-22 09:10:05');
INSERT INTO `sys_log` VALUES (585, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=17&', '0:0:0:0:0:0:0:1', '2018-10-22 09:10:09');
INSERT INTO `sys_log` VALUES (586, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=16&', '0:0:0:0:0:0:0:1', '2018-10-22 09:10:12');
INSERT INTO `sys_log` VALUES (587, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=14&', '0:0:0:0:0:0:0:1', '2018-10-22 09:10:15');
INSERT INTO `sys_log` VALUES (588, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=13&', '0:0:0:0:0:0:0:1', '2018-10-22 09:10:18');
INSERT INTO `sys_log` VALUES (589, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=18&_=1540169389523&', '0:0:0:0:0:0:0:1', '2018-10-22 09:10:37');
INSERT INTO `sys_log` VALUES (590, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=18&_=1540169389524&', '0:0:0:0:0:0:0:1', '2018-10-22 09:12:05');
INSERT INTO `sys_log` VALUES (591, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=18&_=1540169389525&', '0:0:0:0:0:0:0:1', '2018-10-22 09:12:26');
INSERT INTO `sys_log` VALUES (592, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=18&_=1540169389526&', '0:0:0:0:0:0:0:1', '2018-10-22 09:12:34');
INSERT INTO `sys_log` VALUES (593, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-22 09:13:02');
INSERT INTO `sys_log` VALUES (594, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=&industry=&demandSector=&optimizer=&videoType=&completeDate=2018-10-22&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-09-05&', '0:0:0:0:0:0:0:1', '2018-10-22 09:13:11');
INSERT INTO `sys_log` VALUES (595, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=20&_=1540169389528&', '0:0:0:0:0:0:0:1', '2018-10-22 09:13:16');
INSERT INTO `sys_log` VALUES (596, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=20&businessDepartment=测试数据完整&productType=测试数据完整&customerName=测试数据完整&industry=测试数据完整&demandSector=测试数据完整&optimizer=测试数据完整&videoType=测试数据完整&completeDate=2018-10-22&originality=测试数据完整&photographer=测试数据完整&editor=测试数据完整&performer1=测试数据完整&performer2=测试数据完整&performer3=测试数据完整&consumption=2&cumulativeConsumption=33&cumulativeConsumptionRanking=1&recoredDate=2018-09-05&', '0:0:0:0:0:0:0:1', '2018-10-22 09:13:56');
INSERT INTO `sys_log` VALUES (597, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=239&_=1540169389530&', '0:0:0:0:0:0:0:1', '2018-10-22 09:15:30');
INSERT INTO `sys_log` VALUES (598, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=239&name=导入Excel&resourceType=1&url=/videoCost/import&openMode=ajax&icon=glyphicon-open-file icon-blue&seq=5&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-22 09:15:47');
INSERT INTO `sys_log` VALUES (599, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=239&_=1540169389531&', '0:0:0:0:0:0:0:1', '2018-10-22 09:15:51');
INSERT INTO `sys_log` VALUES (600, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=239&name=导入Excel&resourceType=1&url=/videoCost/importExcel&openMode=ajax&icon=glyphicon-open-file icon-blue&seq=5&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-22 09:16:45');
INSERT INTO `sys_log` VALUES (601, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1540169389534&', '0:0:0:0:0:0:0:1', '2018-10-22 10:04:36');
INSERT INTO `sys_log` VALUES (602, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,234,233,235,236,237,238,239,240,221,227,228,226&', '0:0:0:0:0:0:0:1', '2018-10-22 10:04:43');
INSERT INTO `sys_log` VALUES (603, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1540174148857&', '0:0:0:0:0:0:0:1', '2018-10-22 10:11:57');
INSERT INTO `sys_log` VALUES (604, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:editPage,[参数]:id=1&_=1540174148858&', '0:0:0:0:0:0:0:1', '2018-10-22 10:12:05');
INSERT INTO `sys_log` VALUES (605, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=1&_=1540174148860&', '0:0:0:0:0:0:0:1', '2018-10-22 10:12:19');
INSERT INTO `sys_log` VALUES (606, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=239&_=1540174148864&', '0:0:0:0:0:0:0:1', '2018-10-22 10:14:42');
INSERT INTO `sys_log` VALUES (607, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=239&_=1540174148865&', '0:0:0:0:0:0:0:1', '2018-10-22 10:16:11');
INSERT INTO `sys_log` VALUES (608, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=239&_=1540174747175&', '0:0:0:0:0:0:0:1', '2018-10-22 10:23:09');
INSERT INTO `sys_log` VALUES (609, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=239&name=导入Excel&resourceType=1&url=/videoCost/importExcel&openMode=ajax&icon=glyphicon-open-file icon-blue&seq=5&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-22 10:23:20');
INSERT INTO `sys_log` VALUES (610, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=20&_=1540214807087&', '0:0:0:0:0:0:0:1', '2018-10-22 21:29:32');
INSERT INTO `sys_log` VALUES (611, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=240&_=1540214807090&', '0:0:0:0:0:0:0:1', '2018-10-22 21:30:01');
INSERT INTO `sys_log` VALUES (612, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=240&name=导出Excel&resourceType=1&url=/videoCost/exportExcel&openMode=ajax&icon=glyphicon-save-file icon-blue&seq=6&status=0&opened=1&pid=233&', '0:0:0:0:0:0:0:1', '2018-10-22 21:30:31');
INSERT INTO `sys_log` VALUES (613, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1540215409891&', '0:0:0:0:0:0:0:1', '2018-10-22 21:42:11');
INSERT INTO `sys_log` VALUES (614, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,234,233,235,236,237,238,221,227,228,226&', '0:0:0:0:0:0:0:1', '2018-10-22 21:42:19');
INSERT INTO `sys_log` VALUES (615, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1540215822950&', '0:0:0:0:0:0:0:1', '2018-10-22 21:46:09');
INSERT INTO `sys_log` VALUES (616, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=2&_=1540215822951&', '0:0:0:0:0:0:0:1', '2018-10-22 21:46:17');
INSERT INTO `sys_log` VALUES (617, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=2&resourceIds=234,233,235,236&', '0:0:0:0:0:0:0:1', '2018-10-22 21:46:23');
INSERT INTO `sys_log` VALUES (618, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-22 21:46:27');
INSERT INTO `sys_log` VALUES (619, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-22 21:46:55');
INSERT INTO `sys_log` VALUES (620, 'test', 'test', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-22 21:47:17');
INSERT INTO `sys_log` VALUES (621, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=15&_=1540216048413&', '0:0:0:0:0:0:0:1', '2018-10-22 21:47:40');
INSERT INTO `sys_log` VALUES (622, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:edit,[参数]:id=15&loginName=test&name=test&password=&sex=0&age=25&userType=1&organizationId=6&roleIds=1&phone=18707173376&status=0&', '0:0:0:0:0:0:0:1', '2018-10-22 21:47:47');
INSERT INTO `sys_log` VALUES (623, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-22 21:47:50');
INSERT INTO `sys_log` VALUES (624, 'test', 'test', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1540216085837&', '0:0:0:0:0:0:0:1', '2018-10-22 21:48:17');
INSERT INTO `sys_log` VALUES (625, 'test', 'test', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,234,233,235,236,237,238,239,240,221,227,228,226&', '0:0:0:0:0:0:0:1', '2018-10-22 21:48:24');
INSERT INTO `sys_log` VALUES (626, 'test', 'test', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=2&_=1540216085838&', '0:0:0:0:0:0:0:1', '2018-10-22 21:48:26');
INSERT INTO `sys_log` VALUES (627, 'test', 'test', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=2&resourceIds=234,233,235,236,237,238,239,240&', '0:0:0:0:0:0:0:1', '2018-10-22 21:48:34');
INSERT INTO `sys_log` VALUES (628, 'test', 'test', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-22 21:48:42');
INSERT INTO `sys_log` VALUES (629, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=15&_=1540358807890&', '0:0:0:0:0:0:0:1', '2018-10-24 13:30:17');
INSERT INTO `sys_log` VALUES (630, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=23&_=1540358807891&', '0:0:0:0:0:0:0:1', '2018-10-24 13:30:25');
INSERT INTO `sys_log` VALUES (631, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:14:13');
INSERT INTO `sys_log` VALUES (632, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:18:51');
INSERT INTO `sys_log` VALUES (633, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-24 18:20:09');
INSERT INTO `sys_log` VALUES (634, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:20:26');
INSERT INTO `sys_log` VALUES (635, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:21:22');
INSERT INTO `sys_log` VALUES (636, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:47:16');
INSERT INTO `sys_log` VALUES (637, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=测试数据完整&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-24&', '0:0:0:0:0:0:0:1', '2018-10-24 18:47:32');
INSERT INTO `sys_log` VALUES (638, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:47:47');
INSERT INTO `sys_log` VALUES (639, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=测试数据完整&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10.24&', '0:0:0:0:0:0:0:1', '2018-10-24 18:48:05');
INSERT INTO `sys_log` VALUES (640, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:48:34');
INSERT INTO `sys_log` VALUES (641, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:51:40');
INSERT INTO `sys_log` VALUES (642, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:53:24');
INSERT INTO `sys_log` VALUES (643, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:55:49');
INSERT INTO `sys_log` VALUES (644, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:57:25');
INSERT INTO `sys_log` VALUES (645, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:58:34');
INSERT INTO `sys_log` VALUES (646, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=测试数据完整&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=846.02&cumulativeConsumption=577535.01&cumulativeConsumptionRanking=894&recoredDate=2018-10-24&', '0:0:0:0:0:0:0:1', '2018-10-24 18:59:03');
INSERT INTO `sys_log` VALUES (647, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 18:59:19');
INSERT INTO `sys_log` VALUES (648, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 19:07:48');
INSERT INTO `sys_log` VALUES (649, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=测试数据完整&industry=&demandSector=&optimizer=&videoType=&completeDate=2014-2-30&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-24&', '0:0:0:0:0:0:0:1', '2018-10-24 19:08:19');
INSERT INTO `sys_log` VALUES (650, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=测试数据完整&industry=&demandSector=&optimizer=&videoType=&completeDate=2014-2-30&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-24&', '0:0:0:0:0:0:0:1', '2018-10-24 19:23:49');
INSERT INTO `sys_log` VALUES (651, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1270&_=1540376421675&', '0:0:0:0:0:0:0:1', '2018-10-24 19:33:18');
INSERT INTO `sys_log` VALUES (652, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1270&_=1540376421676&', '0:0:0:0:0:0:0:1', '2018-10-24 19:35:22');
INSERT INTO `sys_log` VALUES (653, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1270&_=1540381203566&', '0:0:0:0:0:0:0:1', '2018-10-24 19:40:14');
INSERT INTO `sys_log` VALUES (654, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1270&_=1540381203567&', '0:0:0:0:0:0:0:1', '2018-10-24 19:44:17');
INSERT INTO `sys_log` VALUES (655, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 20:16:33');
INSERT INTO `sys_log` VALUES (656, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:businessDepartment=&productType=&customerName=测试数据完整&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-24&', '0:0:0:0:0:0:0:1', '2018-10-24 20:16:50');
INSERT INTO `sys_log` VALUES (657, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1270&_=1540383383271&', '0:0:0:0:0:0:0:1', '2018-10-24 20:17:13');
INSERT INTO `sys_log` VALUES (658, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1270&_=1540383383272&', '0:0:0:0:0:0:0:1', '2018-10-24 20:18:19');
INSERT INTO `sys_log` VALUES (659, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1270&_=1540383383273&', '0:0:0:0:0:0:0:1', '2018-10-24 20:19:13');
INSERT INTO `sys_log` VALUES (660, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1270&_=1540383383274&', '0:0:0:0:0:0:0:1', '2018-10-24 20:19:34');
INSERT INTO `sys_log` VALUES (661, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540384918959&', '0:0:0:0:0:0:0:1', '2018-10-24 20:42:05');
INSERT INTO `sys_log` VALUES (662, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540384918960&', '0:0:0:0:0:0:0:1', '2018-10-24 20:47:08');
INSERT INTO `sys_log` VALUES (663, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540384918961&', '0:0:0:0:0:0:0:1', '2018-10-24 20:49:15');
INSERT INTO `sys_log` VALUES (664, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540384918962&', '0:0:0:0:0:0:0:1', '2018-10-24 20:50:05');
INSERT INTO `sys_log` VALUES (665, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=11&_=1540384918963&', '0:0:0:0:0:0:0:1', '2018-10-24 20:53:03');
INSERT INTO `sys_log` VALUES (666, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540384918965&', '0:0:0:0:0:0:0:1', '2018-10-24 21:08:22');
INSERT INTO `sys_log` VALUES (667, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=229&_=1540384918968&', '0:0:0:0:0:0:0:1', '2018-10-24 21:12:02');
INSERT INTO `sys_log` VALUES (668, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=229&name=系统图标&resourceType=0&url=/icons.html&openMode=ajax&icon=glyphicon-picture &seq=0&status=0&opened=1&pid=1&', '0:0:0:0:0:0:0:1', '2018-10-24 21:12:09');
INSERT INTO `sys_log` VALUES (669, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=229&_=1540384918969&', '0:0:0:0:0:0:0:1', '2018-10-24 21:12:28');
INSERT INTO `sys_log` VALUES (670, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=229&name=系统图标&resourceType=0&url=/icons.html&openMode=ajax&icon=glyphicon-picture &seq=5&status=0&opened=1&pid=1&', '0:0:0:0:0:0:0:1', '2018-10-24 21:12:34');
INSERT INTO `sys_log` VALUES (671, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=234&_=1540384918970&', '0:0:0:0:0:0:0:1', '2018-10-24 21:15:09');
INSERT INTO `sys_log` VALUES (672, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=234&name=成片消耗&resourceType=0&url=&openMode=&icon=glyphicon-th-list &seq=1&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-24 21:15:12');
INSERT INTO `sys_log` VALUES (673, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=221&_=1540384918971&', '0:0:0:0:0:0:0:1', '2018-10-24 21:15:21');
INSERT INTO `sys_log` VALUES (674, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=221&name=日志监控&resourceType=0&url=&openMode=&icon=glyphicon-dashboard &seq=2&status=0&opened=0&pid=&', '0:0:0:0:0:0:0:1', '2018-10-24 21:15:25');
INSERT INTO `sys_log` VALUES (675, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=226&_=1540384918972&', '0:0:0:0:0:0:0:1', '2018-10-24 21:15:34');
INSERT INTO `sys_log` VALUES (676, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=226&name=修改密码&resourceType=1&url=/user/editPwdPage&openMode=ajax&icon=glyphicon-eye-close &seq=-1&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-24 21:15:41');
INSERT INTO `sys_log` VALUES (677, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=234&_=1540384918973&', '0:0:0:0:0:0:0:1', '2018-10-24 21:16:04');
INSERT INTO `sys_log` VALUES (678, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=234&name=成片消耗&resourceType=0&url=&openMode=&icon=glyphicon-th-list &seq=0&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-24 21:16:06');
INSERT INTO `sys_log` VALUES (679, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=1&_=1540384918974&', '0:0:0:0:0:0:0:1', '2018-10-24 21:16:11');
INSERT INTO `sys_log` VALUES (680, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=1&name=权限管理&resourceType=0&url=&openMode=&icon=glyphicon-list icon-purple&seq=1&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-10-24 21:16:14');
INSERT INTO `sys_log` VALUES (681, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:editPage,[参数]:id=2&_=1540384918984&', '0:0:0:0:0:0:0:1', '2018-10-24 21:48:59');
INSERT INTO `sys_log` VALUES (682, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=2&_=1540384918985&', '0:0:0:0:0:0:0:1', '2018-10-24 21:49:01');
INSERT INTO `sys_log` VALUES (683, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=2&resourceIds=234,233,235,236,237,238&', '0:0:0:0:0:0:0:1', '2018-10-24 21:49:07');
INSERT INTO `sys_log` VALUES (684, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-24 21:49:11');
INSERT INTO `sys_log` VALUES (685, 'test', 'test', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=15&_=1540389056714&', '0:0:0:0:0:0:0:1', '2018-10-24 21:51:17');
INSERT INTO `sys_log` VALUES (686, 'test', 'test', '[类名]:cn.dovahkiin.controller.UserController,[方法]:edit,[参数]:id=15&loginName=test&name=test&password=&sex=0&age=25&userType=1&organizationId=6&roleIds=2&phone=18707173376&status=0&', '0:0:0:0:0:0:0:1', '2018-10-24 21:51:23');
INSERT INTO `sys_log` VALUES (687, 'test', 'test', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-24 21:51:35');
INSERT INTO `sys_log` VALUES (688, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=1&_=1540389105128&', '0:0:0:0:0:0:0:1', '2018-10-24 21:51:58');
INSERT INTO `sys_log` VALUES (689, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=2&_=1540389105130&', '0:0:0:0:0:0:0:1', '2018-10-24 21:52:07');
INSERT INTO `sys_log` VALUES (690, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=2&resourceIds=234,233,235,236,237,238&', '0:0:0:0:0:0:0:1', '2018-10-24 21:52:15');
INSERT INTO `sys_log` VALUES (691, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-24 21:52:18');
INSERT INTO `sys_log` VALUES (692, 'test', 'test', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-24 22:08:31');
INSERT INTO `sys_log` VALUES (693, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=226&_=1540390119664&', '0:0:0:0:0:0:0:1', '2018-10-24 22:39:31');
INSERT INTO `sys_log` VALUES (694, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1540390119674&', '0:0:0:0:0:0:0:1', '2018-10-24 23:02:31');
INSERT INTO `sys_log` VALUES (695, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=226,234,233,235,236,237,238,239,240,1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,229,221,227,228&', '0:0:0:0:0:0:0:1', '2018-10-24 23:02:38');
INSERT INTO `sys_log` VALUES (696, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-24 23:02:50');
INSERT INTO `sys_log` VALUES (697, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540393662984&', '0:0:0:0:0:0:0:1', '2018-10-24 23:09:30');
INSERT INTO `sys_log` VALUES (698, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:23:51');
INSERT INTO `sys_log` VALUES (699, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:25:25');
INSERT INTO `sys_log` VALUES (700, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:31:02');
INSERT INTO `sys_log` VALUES (701, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:32:36');
INSERT INTO `sys_log` VALUES (702, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:33:10');
INSERT INTO `sys_log` VALUES (703, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:35:39');
INSERT INTO `sys_log` VALUES (704, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:37:38');
INSERT INTO `sys_log` VALUES (705, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:39:36');
INSERT INTO `sys_log` VALUES (706, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:39:48');
INSERT INTO `sys_log` VALUES (707, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:39:53');
INSERT INTO `sys_log` VALUES (708, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:41:11');
INSERT INTO `sys_log` VALUES (709, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:41:24');
INSERT INTO `sys_log` VALUES (710, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:41:28');
INSERT INTO `sys_log` VALUES (711, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:41:36');
INSERT INTO `sys_log` VALUES (712, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:42:00');
INSERT INTO `sys_log` VALUES (713, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:42:43');
INSERT INTO `sys_log` VALUES (714, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540393663011&', '0:0:0:0:0:0:0:1', '2018-10-24 23:42:59');
INSERT INTO `sys_log` VALUES (715, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:', NULL, '2018-10-24 23:43:04');
INSERT INTO `sys_log` VALUES (716, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540393663014&', '0:0:0:0:0:0:0:1', '2018-10-24 23:51:25');
INSERT INTO `sys_log` VALUES (717, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540393663016&', '0:0:0:0:0:0:0:1', '2018-10-24 23:57:27');
INSERT INTO `sys_log` VALUES (718, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=12&_=1540393663017&', '0:0:0:0:0:0:0:1', '2018-10-24 23:59:52');
INSERT INTO `sys_log` VALUES (719, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=11&_=1540393663019&', '0:0:0:0:0:0:0:1', '2018-10-25 00:00:13');
INSERT INTO `sys_log` VALUES (720, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=11&businessDepartment=社媒事业部&productType=淘宝客&customerName=白菜挖挖菌002&industry=淘宝客&demandSector=社媒&optimizer=付婷婷&videoType=录屏类&completeDate=2018-10-25&originality=柏吉祥&photographer=——&editor=——&performer1=——&performer2=——&performer3=——&consumption=1.00&cumulativeConsumption=391.92&cumulativeConsumptionRanking=&recoredDate=2018-10-25&', '0:0:0:0:0:0:0:1', '2018-10-25 00:00:18');
INSERT INTO `sys_log` VALUES (721, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=11&_=1540393663020&', '0:0:0:0:0:0:0:1', '2018-10-25 00:00:27');
INSERT INTO `sys_log` VALUES (722, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540397242264&', '0:0:0:0:0:0:0:1', '2018-10-25 00:07:28');
INSERT INTO `sys_log` VALUES (723, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment=&productType=&customerName=测试新增&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-25&', '0:0:0:0:0:0:0:1', '2018-10-25 00:07:49');
INSERT INTO `sys_log` VALUES (724, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2532&_=1540397242265&', '0:0:0:0:0:0:0:1', '2018-10-25 00:08:00');
INSERT INTO `sys_log` VALUES (725, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2533&_=1540397242266&', '0:0:0:0:0:0:0:1', '2018-10-25 00:08:05');
INSERT INTO `sys_log` VALUES (726, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=2533&businessDepartment=&productType=&customerName=测试新增-测试修改&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-25&', '0:0:0:0:0:0:0:1', '2018-10-25 00:08:14');
INSERT INTO `sys_log` VALUES (727, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540397242267&', '0:0:0:0:0:0:0:1', '2018-10-25 00:08:17');
INSERT INTO `sys_log` VALUES (728, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment=&productType=&customerName=再次测试新增&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-25&', '0:0:0:0:0:0:0:1', '2018-10-25 00:08:28');
INSERT INTO `sys_log` VALUES (729, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=2534&', '0:0:0:0:0:0:0:1', '2018-10-25 00:08:38');
INSERT INTO `sys_log` VALUES (730, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2533&_=1540397242268&', '0:0:0:0:0:0:0:1', '2018-10-25 00:08:45');
INSERT INTO `sys_log` VALUES (731, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2532&_=1540397242269&', '0:0:0:0:0:0:0:1', '2018-10-25 00:10:45');
INSERT INTO `sys_log` VALUES (732, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2531&_=1540397242270&', '0:0:0:0:0:0:0:1', '2018-10-25 00:10:49');
INSERT INTO `sys_log` VALUES (733, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2530&_=1540397242271&', '0:0:0:0:0:0:0:1', '2018-10-25 00:10:57');
INSERT INTO `sys_log` VALUES (734, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540397242272&', '0:0:0:0:0:0:0:1', '2018-10-25 00:11:14');
INSERT INTO `sys_log` VALUES (735, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540397242274&', '0:0:0:0:0:0:0:1', '2018-10-25 00:14:23');
INSERT INTO `sys_log` VALUES (736, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=11&_=1540397242275&', '0:0:0:0:0:0:0:1', '2018-10-25 00:14:38');
INSERT INTO `sys_log` VALUES (737, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540397242277&', '0:0:0:0:0:0:0:1', '2018-10-25 00:16:15');
INSERT INTO `sys_log` VALUES (738, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540397242278&', '0:0:0:0:0:0:0:1', '2018-10-25 00:16:21');
INSERT INTO `sys_log` VALUES (739, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540398534786&', '0:0:0:0:0:0:0:1', '2018-10-25 00:30:45');
INSERT INTO `sys_log` VALUES (740, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment=&productType=&customerName=测试日期&industry=&demandSector=&optimizer=&videoType=&completeDate=2018-10-10&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-11&', '0:0:0:0:0:0:0:1', '2018-10-25 00:31:01');
INSERT INTO `sys_log` VALUES (741, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540398534787&', '0:0:0:0:0:0:0:1', '2018-10-25 00:31:18');
INSERT INTO `sys_log` VALUES (742, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540398534788&', '0:0:0:0:0:0:0:1', '2018-10-25 00:31:36');
INSERT INTO `sys_log` VALUES (743, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment=&productType=&customerName=测试数据完整&industry=&demandSector=&optimizer=&videoType=&completeDate=2018-10-9&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-30&', '0:0:0:0:0:0:0:1', '2018-10-25 00:31:50');
INSERT INTO `sys_log` VALUES (744, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540398534790&', '0:0:0:0:0:0:0:1', '2018-10-25 00:33:02');
INSERT INTO `sys_log` VALUES (745, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment=&productType=&customerName=v&industry=&demandSector=&optimizer=&videoType=&completeDate=2018-10-10&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-17&', '0:0:0:0:0:0:0:1', '2018-10-25 00:33:10');
INSERT INTO `sys_log` VALUES (746, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540398534791&', '0:0:0:0:0:0:0:1', '2018-10-25 00:34:10');
INSERT INTO `sys_log` VALUES (747, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540433666972&', '0:0:0:0:0:0:0:1', '2018-10-25 10:14:37');
INSERT INTO `sys_log` VALUES (748, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540433666973&', '0:0:0:0:0:0:0:1', '2018-10-25 10:14:45');
INSERT INTO `sys_log` VALUES (749, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540433666975&', '0:0:0:0:0:0:0:1', '2018-10-25 10:14:52');
INSERT INTO `sys_log` VALUES (750, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=10&businessDepartment=&productType=&customerName=测试数据完整&industry=&demandSector=&optimizer=&videoType=&completeDate=2018-10-25&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-10&', '0:0:0:0:0:0:0:1', '2018-10-25 10:14:56');
INSERT INTO `sys_log` VALUES (751, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540433666976&', '0:0:0:0:0:0:0:1', '2018-10-25 10:15:05');
INSERT INTO `sys_log` VALUES (752, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=11&_=1540433666977&', '0:0:0:0:0:0:0:1', '2018-10-25 10:19:30');
INSERT INTO `sys_log` VALUES (753, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540437776714&', '0:0:0:0:0:0:0:1', '2018-10-25 11:23:07');
INSERT INTO `sys_log` VALUES (754, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=11&_=1540437776715&', '0:0:0:0:0:0:0:1', '2018-10-25 11:23:10');
INSERT INTO `sys_log` VALUES (755, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540437776716&', '0:0:0:0:0:0:0:1', '2018-10-25 11:23:12');
INSERT INTO `sys_log` VALUES (756, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540437776718&', '0:0:0:0:0:0:0:1', '2018-10-25 11:26:10');
INSERT INTO `sys_log` VALUES (757, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540437776719&', '0:0:0:0:0:0:0:1', '2018-10-25 11:26:17');
INSERT INTO `sys_log` VALUES (758, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=10&businessDepartment=&productType=&customerName=测试数据完整&industry=&demandSector=&optimizer=&videoType=&completeDate=2018-10-25&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-25&', '0:0:0:0:0:0:0:1', '2018-10-25 11:26:41');
INSERT INTO `sys_log` VALUES (759, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=11&_=1540437776720&', '0:0:0:0:0:0:0:1', '2018-10-25 11:26:42');
INSERT INTO `sys_log` VALUES (760, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540437776721&', '0:0:0:0:0:0:0:1', '2018-10-25 11:26:48');
INSERT INTO `sys_log` VALUES (761, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540437776723&', '0:0:0:0:0:0:0:1', '2018-10-25 11:27:18');
INSERT INTO `sys_log` VALUES (762, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1540437776727&', '0:0:0:0:0:0:0:1', '2018-10-25 11:29:22');
INSERT INTO `sys_log` VALUES (763, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-25 11:29:51');
INSERT INTO `sys_log` VALUES (764, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-25 11:30:08');
INSERT INTO `sys_log` VALUES (765, 'test', 'test', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-10-25 11:30:22');
INSERT INTO `sys_log` VALUES (766, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540438586209&', '0:0:0:0:0:0:0:1', '2018-10-25 11:37:00');
INSERT INTO `sys_log` VALUES (767, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=10&_=1540438586210&', '0:0:0:0:0:0:0:1', '2018-10-25 11:37:05');
INSERT INTO `sys_log` VALUES (768, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=11&', '0:0:0:0:0:0:0:1', '2018-10-25 11:37:11');
INSERT INTO `sys_log` VALUES (769, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=10&', '0:0:0:0:0:0:0:1', '2018-10-25 11:37:14');
INSERT INTO `sys_log` VALUES (770, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=226&_=1540451249157&', '0:0:0:0:0:0:0:1', '2018-10-25 15:15:04');
INSERT INTO `sys_log` VALUES (771, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540453729616&', '0:0:0:0:0:0:0:1', '2018-10-25 15:50:04');
INSERT INTO `sys_log` VALUES (772, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment=&productType=&customerName=白菜挖挖菌002&industry=&demandSector=&optimizer=&videoType=&completeDate=&originality=&photographer=&editor=&performer1=&performer2=&performer3=&consumption=&cumulativeConsumption=&cumulativeConsumptionRanking=&recoredDate=2018-10-1&', '0:0:0:0:0:0:0:1', '2018-10-25 15:50:12');
INSERT INTO `sys_log` VALUES (773, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540711325603&', '0:0:0:0:0:0:0:1', '2018-10-28 15:25:54');
INSERT INTO `sys_log` VALUES (774, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1540711325604&', '0:0:0:0:0:0:0:1', '2018-10-28 15:25:58');
INSERT INTO `sys_log` VALUES (775, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2045&_=1540711325608&', '0:0:0:0:0:0:0:1', '2018-10-28 15:32:36');
INSERT INTO `sys_log` VALUES (776, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2045&_=1540711325609&', '0:0:0:0:0:0:0:1', '2018-10-28 15:32:45');
INSERT INTO `sys_log` VALUES (777, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=2045&businessDepartment=&productType=&customerName=趣头条-吃东西对比横版&industry=APP&demandSector=全媒体&optimizer=查文钊&videoType=场景类&completeDate=2018-10-28&originality=刘子豪&photographer=陈文杰&editor=刘子豪&performer1=王靖雅&performer2=陈丽敏&performer3=&consumption=1548.59&cumulativeConsumption=163930.36&cumulativeConsumptionRanking=&recoredDate=2018-10-28&', '0:0:0:0:0:0:0:1', '2018-10-28 15:32:53');
INSERT INTO `sys_log` VALUES (778, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=14&_=1540712743503&', '0:0:0:0:0:0:0:1', '2018-10-28 15:49:51');
INSERT INTO `sys_log` VALUES (779, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:delete,[参数]:id=14&', '0:0:0:0:0:0:0:1', '2018-10-28 15:49:54');
INSERT INTO `sys_log` VALUES (780, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:delete,[参数]:id=13&', '0:0:0:0:0:0:0:1', '2018-10-28 15:49:57');
INSERT INTO `sys_log` VALUES (781, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=1&_=1540712743504&', '0:0:0:0:0:0:0:1', '2018-10-28 15:50:04');
INSERT INTO `sys_log` VALUES (782, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=2&_=1540712743509&', '0:0:0:0:0:0:0:1', '2018-10-28 15:51:01');
INSERT INTO `sys_log` VALUES (783, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1541211642431&', '0:0:0:0:0:0:0:1', '2018-11-03 10:46:05');
INSERT INTO `sys_log` VALUES (784, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:id=2025&', '0:0:0:0:0:0:0:1', '2018-11-11 22:56:51');
INSERT INTO `sys_log` VALUES (785, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1541948129457&', '0:0:0:0:0:0:0:1', '2018-11-11 23:10:52');
INSERT INTO `sys_log` VALUES (786, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542419602663&', '0:0:0:0:0:0:0:1', '2018-11-17 10:15:56');
INSERT INTO `sys_log` VALUES (787, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542419602664&', '0:0:0:0:0:0:0:1', '2018-11-17 10:16:09');
INSERT INTO `sys_log` VALUES (788, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542421223218&', '0:0:0:0:0:0:0:1', '2018-11-17 10:20:48');
INSERT INTO `sys_log` VALUES (789, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542430536214&', '0:0:0:0:0:0:0:1', '2018-11-17 12:57:51');
INSERT INTO `sys_log` VALUES (790, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383351&', '0:0:0:0:0:0:0:1', '2018-11-17 13:59:55');
INSERT INTO `sys_log` VALUES (791, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383352&', '0:0:0:0:0:0:0:1', '2018-11-17 14:00:33');
INSERT INTO `sys_log` VALUES (792, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383353&', '0:0:0:0:0:0:0:1', '2018-11-17 14:15:58');
INSERT INTO `sys_log` VALUES (793, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383354&', '0:0:0:0:0:0:0:1', '2018-11-17 14:16:36');
INSERT INTO `sys_log` VALUES (794, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383356&', '0:0:0:0:0:0:0:1', '2018-11-17 14:43:29');
INSERT INTO `sys_log` VALUES (795, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383357&', '0:0:0:0:0:0:0:1', '2018-11-17 14:44:40');
INSERT INTO `sys_log` VALUES (796, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383358&', '0:0:0:0:0:0:0:1', '2018-11-17 14:45:37');
INSERT INTO `sys_log` VALUES (797, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383359&', '0:0:0:0:0:0:0:1', '2018-11-17 14:47:36');
INSERT INTO `sys_log` VALUES (798, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383360&', '0:0:0:0:0:0:0:1', '2018-11-17 14:48:19');
INSERT INTO `sys_log` VALUES (799, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383361&', '0:0:0:0:0:0:0:1', '2018-11-17 14:50:50');
INSERT INTO `sys_log` VALUES (800, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383362&', '0:0:0:0:0:0:0:1', '2018-11-17 14:51:21');
INSERT INTO `sys_log` VALUES (801, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383363&', '0:0:0:0:0:0:0:1', '2018-11-17 14:52:29');
INSERT INTO `sys_log` VALUES (802, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383364&', '0:0:0:0:0:0:0:1', '2018-11-17 14:54:24');
INSERT INTO `sys_log` VALUES (803, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542434383365&', '0:0:0:0:0:0:0:1', '2018-11-17 14:55:46');
INSERT INTO `sys_log` VALUES (804, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542437853516&', '0:0:0:0:0:0:0:1', '2018-11-17 14:57:45');
INSERT INTO `sys_log` VALUES (805, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542437853517&', '0:0:0:0:0:0:0:1', '2018-11-17 14:57:57');
INSERT INTO `sys_log` VALUES (806, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542440372572&', '0:0:0:0:0:0:0:1', '2018-11-17 15:39:36');
INSERT INTO `sys_log` VALUES (807, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542440372573&', '0:0:0:0:0:0:0:1', '2018-11-17 15:51:02');
INSERT INTO `sys_log` VALUES (808, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542440372574&', '0:0:0:0:0:0:0:1', '2018-11-17 15:52:42');
INSERT INTO `sys_log` VALUES (809, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441255348&', '0:0:0:0:0:0:0:1', '2018-11-17 15:54:36');
INSERT INTO `sys_log` VALUES (810, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441255349&', '0:0:0:0:0:0:0:1', '2018-11-17 15:54:51');
INSERT INTO `sys_log` VALUES (811, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441255350&', '0:0:0:0:0:0:0:1', '2018-11-17 15:55:08');
INSERT INTO `sys_log` VALUES (812, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441255351&', '0:0:0:0:0:0:0:1', '2018-11-17 15:55:38');
INSERT INTO `sys_log` VALUES (813, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441255352&', '0:0:0:0:0:0:0:1', '2018-11-17 15:55:46');
INSERT INTO `sys_log` VALUES (814, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441255353&', '0:0:0:0:0:0:0:1', '2018-11-17 15:56:58');
INSERT INTO `sys_log` VALUES (815, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441460006&', '0:0:0:0:0:0:0:1', '2018-11-17 16:00:10');
INSERT INTO `sys_log` VALUES (816, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441460007&', '0:0:0:0:0:0:0:1', '2018-11-17 16:01:28');
INSERT INTO `sys_log` VALUES (817, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441460008&', '0:0:0:0:0:0:0:1', '2018-11-17 16:01:46');
INSERT INTO `sys_log` VALUES (818, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441726521&', '0:0:0:0:0:0:0:1', '2018-11-17 16:02:21');
INSERT INTO `sys_log` VALUES (819, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441726522&', '0:0:0:0:0:0:0:1', '2018-11-17 16:02:56');
INSERT INTO `sys_log` VALUES (820, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441726523&', '0:0:0:0:0:0:0:1', '2018-11-17 16:03:10');
INSERT INTO `sys_log` VALUES (821, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441726524&', '0:0:0:0:0:0:0:1', '2018-11-17 16:03:56');
INSERT INTO `sys_log` VALUES (822, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441726525&', '0:0:0:0:0:0:0:1', '2018-11-17 16:05:15');
INSERT INTO `sys_log` VALUES (823, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441726526&', '0:0:0:0:0:0:0:1', '2018-11-17 16:05:56');
INSERT INTO `sys_log` VALUES (824, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441726527&', '0:0:0:0:0:0:0:1', '2018-11-17 16:11:55');
INSERT INTO `sys_log` VALUES (825, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542441726528&', '0:0:0:0:0:0:0:1', '2018-11-17 16:14:47');
INSERT INTO `sys_log` VALUES (826, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542442823746&', '0:0:0:0:0:0:0:1', '2018-11-17 16:20:28');
INSERT INTO `sys_log` VALUES (827, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542442823747&', '0:0:0:0:0:0:0:1', '2018-11-17 16:20:42');
INSERT INTO `sys_log` VALUES (828, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443070151&', '0:0:0:0:0:0:0:1', '2018-11-17 16:24:34');
INSERT INTO `sys_log` VALUES (829, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443070152&', '0:0:0:0:0:0:0:1', '2018-11-17 16:24:53');
INSERT INTO `sys_log` VALUES (830, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443070153&', '0:0:0:0:0:0:0:1', '2018-11-17 16:27:51');
INSERT INTO `sys_log` VALUES (831, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443070154&', '0:0:0:0:0:0:0:1', '2018-11-17 16:29:29');
INSERT INTO `sys_log` VALUES (832, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733163&', '0:0:0:0:0:0:0:1', '2018-11-17 16:35:40');
INSERT INTO `sys_log` VALUES (833, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733164&', '0:0:0:0:0:0:0:1', '2018-11-17 16:55:33');
INSERT INTO `sys_log` VALUES (834, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733165&', '0:0:0:0:0:0:0:1', '2018-11-17 16:57:20');
INSERT INTO `sys_log` VALUES (835, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733166&', '0:0:0:0:0:0:0:1', '2018-11-17 17:03:36');
INSERT INTO `sys_log` VALUES (836, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733167&', '0:0:0:0:0:0:0:1', '2018-11-17 17:05:39');
INSERT INTO `sys_log` VALUES (837, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733168&', '0:0:0:0:0:0:0:1', '2018-11-17 17:12:24');
INSERT INTO `sys_log` VALUES (838, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733169&', '0:0:0:0:0:0:0:1', '2018-11-17 17:14:32');
INSERT INTO `sys_log` VALUES (839, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733170&', '0:0:0:0:0:0:0:1', '2018-11-17 17:16:56');
INSERT INTO `sys_log` VALUES (840, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733171&', '0:0:0:0:0:0:0:1', '2018-11-17 17:18:51');
INSERT INTO `sys_log` VALUES (841, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=&productType.id=&customer.id=10288&industry.id=&demandSector.id=&optimizer.id=&videoType.id=&completeDate=&originality.id=&photographer.id=&editor.id=&performer1.id=&performer2.id=&performer3.id=&consumption=&recoredDate=2018-11-15&', '0:0:0:0:0:0:0:1', '2018-11-17 17:18:59');
INSERT INTO `sys_log` VALUES (842, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=&productType.id=&customer.id=10288&industry.id=&demandSector.id=&optimizer.id=&videoType.id=&completeDate=&originality.id=&photographer.id=&editor.id=&performer1.id=&performer2.id=1738&performer3.id=&consumption=&recoredDate=2018-11-15&', '0:0:0:0:0:0:0:1', '2018-11-17 17:19:23');
INSERT INTO `sys_log` VALUES (843, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=&productType.id=&customer.id=10288&industry.id=&demandSector.id=&optimizer.id=&videoType.id=&completeDate=&originality.id=&photographer.id=&editor.id=&performer1.id=&performer2.id=1738&performer3.id=&consumption=&recoredDate=2018-11-15&', '0:0:0:0:0:0:0:1', '2018-11-17 17:21:15');
INSERT INTO `sys_log` VALUES (844, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=&productType.id=&customer.id=10288&industry.id=&demandSector.id=&optimizer.id=&videoType.id=&completeDate=&originality.id=&photographer.id=&editor.id=&performer1.id=&performer2.id=1738&performer3.id=&consumption=&recoredDate=2018-11-15&', '0:0:0:0:0:0:0:1', '2018-11-17 17:21:20');
INSERT INTO `sys_log` VALUES (845, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=&productType.id=&customer.id=10288&industry.id=&demandSector.id=&optimizer.id=&videoType.id=&completeDate=&originality.id=&photographer.id=&editor.id=&performer1.id=&performer2.id=1738&performer3.id=&consumption=&recoredDate=2018-11-15&', '0:0:0:0:0:0:0:1', '2018-11-17 17:22:13');
INSERT INTO `sys_log` VALUES (846, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733172&', '0:0:0:0:0:0:0:1', '2018-11-17 17:24:38');
INSERT INTO `sys_log` VALUES (847, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=&productType.id=&customer.id=10288&industry.id=&demandSector.id=&optimizer.id=&videoType.id=&completeDate=&originality.id=&photographer.id=&editor.id=&performer1.id=&performer2.id=&performer3.id=&consumption=&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 17:24:51');
INSERT INTO `sys_log` VALUES (848, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=&productType.id=&customer.id=10288&industry.id=&demandSector.id=&optimizer.id=&videoType.id=&completeDate=&originality.id=&photographer.id=&editor.id=&performer1.id=&performer2.id=&performer3.id=&consumption=&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 17:25:24');
INSERT INTO `sys_log` VALUES (849, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542443733174&', '0:0:0:0:0:0:0:1', '2018-11-17 17:29:08');
INSERT INTO `sys_log` VALUES (850, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1361&_=1542443733175&', '0:0:0:0:0:0:0:1', '2018-11-17 17:29:12');
INSERT INTO `sys_log` VALUES (851, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542451386931&', '0:0:0:0:0:0:0:1', '2018-11-17 18:43:16');
INSERT INTO `sys_log` VALUES (852, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1294&_=1542451386932&', '0:0:0:0:0:0:0:1', '2018-11-17 18:44:16');
INSERT INTO `sys_log` VALUES (853, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542451386933&', '0:0:0:0:0:0:0:1', '2018-11-17 18:44:22');
INSERT INTO `sys_log` VALUES (854, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=5&productType.id=1991&customer.id=10304&industry.id=3332&demandSector.id=6&optimizer.id=3662&videoType.id=3380&completeDate=2018-11-17&originality.id=3618&photographer.id=2922&editor.id=2752&performer1.id=1738&performer2.id=1737&performer3.id=1738&consumption=12.00&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 18:45:01');
INSERT INTO `sys_log` VALUES (855, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542451386934&', '0:0:0:0:0:0:0:1', '2018-11-17 18:48:19');
INSERT INTO `sys_log` VALUES (856, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=5&productType.id=1992&customer.id=10290&industry.id=3331&demandSector.id=5&optimizer.id=3662&videoType.id=3379&completeDate=2018-11-30&originality.id=3618&photographer.id=2923&editor.id=2752&performer1.id=1737&performer2.id=1738&performer3.id=1738&consumption=15.00&recoredDate=2018-11-30&', '0:0:0:0:0:0:0:1', '2018-11-17 18:48:55');
INSERT INTO `sys_log` VALUES (857, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542451386935&', '0:0:0:0:0:0:0:1', '2018-11-17 18:50:24');
INSERT INTO `sys_log` VALUES (858, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=3&productType.id=1991&customer.id=10290&industry.id=3335&demandSector.id=6&optimizer.id=3663&videoType.id=3379&completeDate=2018-11-17&originality.id=3617&photographer.id=2922&editor.id=2750&performer1.id=1738&performer2.id=1737&performer3.id=1739&consumption=12345.00&recoredDate=2018-11-30&', '0:0:0:0:0:0:0:1', '2018-11-17 18:51:01');
INSERT INTO `sys_log` VALUES (859, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2534&_=1542451386936&', '0:0:0:0:0:0:0:1', '2018-11-17 18:51:36');
INSERT INTO `sys_log` VALUES (860, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1271&_=1542451386937&', '0:0:0:0:0:0:0:1', '2018-11-17 18:53:05');
INSERT INTO `sys_log` VALUES (861, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2534&_=1542451386938&', '0:0:0:0:0:0:0:1', '2018-11-17 18:53:45');
INSERT INTO `sys_log` VALUES (862, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2534&_=1542451386939&', '0:0:0:0:0:0:0:1', '2018-11-17 19:02:30');
INSERT INTO `sys_log` VALUES (863, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2534&_=1542451386940&', '0:0:0:0:0:0:0:1', '2018-11-17 19:03:01');
INSERT INTO `sys_log` VALUES (864, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2533&_=1542451386941&', '0:0:0:0:0:0:0:1', '2018-11-17 19:06:48');
INSERT INTO `sys_log` VALUES (865, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542451386942&', '0:0:0:0:0:0:0:1', '2018-11-17 19:13:33');
INSERT INTO `sys_log` VALUES (866, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:_=1542451386945&', '0:0:0:0:0:0:0:1', '2018-11-17 19:19:10');
INSERT INTO `sys_log` VALUES (867, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542451386947&', '0:0:0:0:0:0:0:1', '2018-11-17 19:23:37');
INSERT INTO `sys_log` VALUES (868, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542453956797&', '0:0:0:0:0:0:0:1', '2018-11-17 19:26:05');
INSERT INTO `sys_log` VALUES (869, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1613&_=1542453956798&', '0:0:0:0:0:0:0:1', '2018-11-17 19:26:13');
INSERT INTO `sys_log` VALUES (870, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542453956799&', '0:0:0:0:0:0:0:1', '2018-11-17 19:26:23');
INSERT INTO `sys_log` VALUES (871, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542453956800&', '0:0:0:0:0:0:0:1', '2018-11-17 19:26:33');
INSERT INTO `sys_log` VALUES (872, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542453956801&', '0:0:0:0:0:0:0:1', '2018-11-17 19:26:42');
INSERT INTO `sys_log` VALUES (873, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542453956802&', '0:0:0:0:0:0:0:1', '2018-11-17 19:26:53');
INSERT INTO `sys_log` VALUES (874, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542453956803&', '0:0:0:0:0:0:0:1', '2018-11-17 19:27:08');
INSERT INTO `sys_log` VALUES (875, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542453956804&', '0:0:0:0:0:0:0:1', '2018-11-17 19:27:27');
INSERT INTO `sys_log` VALUES (876, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1418&_=1542453956806&', '0:0:0:0:0:0:0:1', '2018-11-17 19:27:40');
INSERT INTO `sys_log` VALUES (877, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542453956807&', '0:0:0:0:0:0:0:1', '2018-11-17 19:28:01');
INSERT INTO `sys_log` VALUES (878, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542453956808&', '0:0:0:0:0:0:0:1', '2018-11-17 19:28:38');
INSERT INTO `sys_log` VALUES (879, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1418&_=1542453956809&', '0:0:0:0:0:0:0:1', '2018-11-17 19:29:28');
INSERT INTO `sys_log` VALUES (880, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1418&_=1542453956810&', '0:0:0:0:0:0:0:1', '2018-11-17 19:29:45');
INSERT INTO `sys_log` VALUES (881, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542453956811&', '0:0:0:0:0:0:0:1', '2018-11-17 19:30:31');
INSERT INTO `sys_log` VALUES (882, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1548&_=1542457060461&', '0:0:0:0:0:0:0:1', '2018-11-17 20:17:53');
INSERT INTO `sys_log` VALUES (883, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542457060462&', '0:0:0:0:0:0:0:1', '2018-11-17 20:18:20');
INSERT INTO `sys_log` VALUES (884, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542457060463&', '0:0:0:0:0:0:0:1', '2018-11-17 20:18:33');
INSERT INTO `sys_log` VALUES (885, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542457060464&', '0:0:0:0:0:0:0:1', '2018-11-17 20:18:44');
INSERT INTO `sys_log` VALUES (886, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1565&_=1542457060466&', '0:0:0:0:0:0:0:1', '2018-11-17 20:18:59');
INSERT INTO `sys_log` VALUES (887, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542457060468&', '0:0:0:0:0:0:0:1', '2018-11-17 20:23:36');
INSERT INTO `sys_log` VALUES (888, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542457060469&', '0:0:0:0:0:0:0:1', '2018-11-17 20:24:10');
INSERT INTO `sys_log` VALUES (889, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542457060470&', '0:0:0:0:0:0:0:1', '2018-11-17 20:24:20');
INSERT INTO `sys_log` VALUES (890, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=2069&_=1542457060472&', '0:0:0:0:0:0:0:1', '2018-11-17 20:25:17');
INSERT INTO `sys_log` VALUES (891, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542457060474&', '0:0:0:0:0:0:0:1', '2018-11-17 20:26:27');
INSERT INTO `sys_log` VALUES (892, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542457060475&', '0:0:0:0:0:0:0:1', '2018-11-17 20:26:34');
INSERT INTO `sys_log` VALUES (893, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1535&_=1542457060476&', '0:0:0:0:0:0:0:1', '2018-11-17 20:26:48');
INSERT INTO `sys_log` VALUES (894, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1535&_=1542457060477&', '0:0:0:0:0:0:0:1', '2018-11-17 20:26:53');
INSERT INTO `sys_log` VALUES (895, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458216524&', '0:0:0:0:0:0:0:1', '2018-11-17 20:37:03');
INSERT INTO `sys_log` VALUES (896, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458680041&', '0:0:0:0:0:0:0:1', '2018-11-17 20:44:50');
INSERT INTO `sys_log` VALUES (897, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728216&', '0:0:0:0:0:0:0:1', '2018-11-17 20:45:36');
INSERT INTO `sys_log` VALUES (898, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728218&', '0:0:0:0:0:0:0:1', '2018-11-17 20:48:27');
INSERT INTO `sys_log` VALUES (899, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728219&', '0:0:0:0:0:0:0:1', '2018-11-17 20:48:41');
INSERT INTO `sys_log` VALUES (900, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728220&', '0:0:0:0:0:0:0:1', '2018-11-17 20:48:50');
INSERT INTO `sys_log` VALUES (901, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728223&', '0:0:0:0:0:0:0:1', '2018-11-17 20:51:11');
INSERT INTO `sys_log` VALUES (902, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1972&_=1542458728224&', '0:0:0:0:0:0:0:1', '2018-11-17 20:51:15');
INSERT INTO `sys_log` VALUES (903, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728225&', '0:0:0:0:0:0:0:1', '2018-11-17 20:51:22');
INSERT INTO `sys_log` VALUES (904, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728226&', '0:0:0:0:0:0:0:1', '2018-11-17 21:02:02');
INSERT INTO `sys_log` VALUES (905, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728227&', '0:0:0:0:0:0:0:1', '2018-11-17 21:02:07');
INSERT INTO `sys_log` VALUES (906, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728228&', '0:0:0:0:0:0:0:1', '2018-11-17 21:02:20');
INSERT INTO `sys_log` VALUES (907, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1819&_=1542458728230&', '0:0:0:0:0:0:0:1', '2018-11-17 21:03:25');
INSERT INTO `sys_log` VALUES (908, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728232&', '0:0:0:0:0:0:0:1', '2018-11-17 21:04:04');
INSERT INTO `sys_log` VALUES (909, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728233&', '0:0:0:0:0:0:0:1', '2018-11-17 21:04:21');
INSERT INTO `sys_log` VALUES (910, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728234&', '0:0:0:0:0:0:0:1', '2018-11-17 21:04:30');
INSERT INTO `sys_log` VALUES (911, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728235&', '0:0:0:0:0:0:0:1', '2018-11-17 21:04:53');
INSERT INTO `sys_log` VALUES (912, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728239&', '0:0:0:0:0:0:0:1', '2018-11-17 21:20:42');
INSERT INTO `sys_log` VALUES (913, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1390&_=1542458728240&', '0:0:0:0:0:0:0:1', '2018-11-17 21:20:47');
INSERT INTO `sys_log` VALUES (914, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=1390&businessDepartment.id=7&productType.id=1990&customer.id=10404&industry.id=3329&demandSector.id=7&optimizer.id=3667&videoType.id=3379&completeDate=2018-11-17&originality.id=3629&photographer.id=2919&editor.id=2752&performer1.id=1737&performer2.id=1737&performer3.id=1738&consumption=0.00&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 21:20:57');
INSERT INTO `sys_log` VALUES (915, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1637&_=1542458728241&', '0:0:0:0:0:0:0:1', '2018-11-17 21:21:10');
INSERT INTO `sys_log` VALUES (916, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1816&_=1542458728243&', '0:0:0:0:0:0:0:1', '2018-11-17 21:21:52');
INSERT INTO `sys_log` VALUES (917, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:add,[参数]:id=&businessDepartment.id=3&productType.id=1989&customer.id=10813&industry.id=3329&demandSector.id=4440&optimizer.id=3674&videoType.id=3379&completeDate=2018-11-17&originality.id=3623&photographer.id=2919&editor.id=2750&performer1.id=1737&performer2.id=1737&performer3.id=1737&consumption=0.00&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 21:22:02');
INSERT INTO `sys_log` VALUES (918, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1738&_=1542458728244&', '0:0:0:0:0:0:0:1', '2018-11-17 21:22:12');
INSERT INTO `sys_log` VALUES (919, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728245&', '0:0:0:0:0:0:0:1', '2018-11-17 21:22:18');
INSERT INTO `sys_log` VALUES (920, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728246&', '0:0:0:0:0:0:0:1', '2018-11-17 21:23:55');
INSERT INTO `sys_log` VALUES (921, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1390&_=1542458728247&', '0:0:0:0:0:0:0:1', '2018-11-17 21:24:00');
INSERT INTO `sys_log` VALUES (922, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=1390&businessDepartment.id=7&productType.id=1990&customer.id=10404&industry.id=3329&demandSector.id=7&optimizer.id=3667&videoType.id=3379&completeDate=2018-11-17&originality.id=3629&photographer.id=2919&editor.id=2752&performer1.id=1736&performer2.id=1737&performer3.id=1737&consumption=0.00&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 21:24:12');
INSERT INTO `sys_log` VALUES (923, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2114&_=1542461291385&', '0:0:0:0:0:0:0:1', '2018-11-17 21:31:09');
INSERT INTO `sys_log` VALUES (924, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=2114&businessDepartment.id=&productType.id=1993&customer.id=11082&industry.id=3329&demandSector.id=4440&optimizer.id=3697&videoType.id=3379&completeDate=2018-11-17&originality.id=3618&photographer.id=2919&editor.id=2751&performer1.id=1737&performer2.id=1738&performer3.id=1738&consumption=0.00&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 21:31:20');
INSERT INTO `sys_log` VALUES (925, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=2114&businessDepartment.id=&productType.id=1993&customer.id=11082&industry.id=3329&demandSector.id=4440&optimizer.id=3697&videoType.id=3379&completeDate=2018-11-17&originality.id=3618&photographer.id=2919&editor.id=2751&performer1.id=1737&performer2.id=1738&performer3.id=1738&consumption=0.00&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 21:33:19');
INSERT INTO `sys_log` VALUES (926, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=2114&businessDepartment.id=&productType.id=1993&customer.id=11082&industry.id=3329&demandSector.id=4440&optimizer.id=3697&videoType.id=3379&completeDate=2018-11-17&originality.id=3618&photographer.id=2919&editor.id=2751&performer1.id=1737&performer2.id=1738&performer3.id=1738&consumption=0.00&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 21:34:46');
INSERT INTO `sys_log` VALUES (927, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1777&_=1542461678338&', '0:0:0:0:0:0:0:1', '2018-11-17 21:34:58');
INSERT INTO `sys_log` VALUES (928, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=1777&businessDepartment.id=1&productType.id=1989&customer.id=10784&industry.id=3329&demandSector.id=4440&optimizer.id=3698&videoType.id=3379&completeDate=2018-11-17&originality.id=3619&photographer.id=2919&editor.id=2749&performer1.id=1740&performer2.id=1736&performer3.id=1738&consumption=0.00&recoredDate=2018-11-30&', '0:0:0:0:0:0:0:1', '2018-11-17 21:35:20');
INSERT INTO `sys_log` VALUES (929, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2045&_=1542461678339&', '0:0:0:0:0:0:0:1', '2018-11-17 21:35:41');
INSERT INTO `sys_log` VALUES (930, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=2045&businessDepartment.id=3&productType.id=1990&customer.id=10460&industry.id=3329&demandSector.id=4440&optimizer.id=3674&videoType.id=3379&completeDate=2018-11-17&originality.id=3638&photographer.id=2928&editor.id=2757&performer1.id=1737&performer2.id=1741&performer3.id=1737&consumption=154832.59&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 21:35:49');
INSERT INTO `sys_log` VALUES (931, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=2045&_=1542461678340&', '0:0:0:0:0:0:0:1', '2018-11-17 21:35:54');
INSERT INTO `sys_log` VALUES (932, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=2045&businessDepartment.id=3&productType.id=1990&customer.id=10460&industry.id=3329&demandSector.id=4440&optimizer.id=3674&videoType.id=3379&completeDate=2018-11-17&originality.id=3638&photographer.id=2928&editor.id=2757&performer1.id=1737&performer2.id=1741&performer3.id=1737&consumption=154832.60&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 21:36:01');
INSERT INTO `sys_log` VALUES (933, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1685&_=1542461678344&', '0:0:0:0:0:0:0:1', '2018-11-17 21:46:50');
INSERT INTO `sys_log` VALUES (934, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=1685&businessDepartment.id=4441&productType.id=1989&customer.id=10696&industry.id=3328&demandSector.id=4442&optimizer.id=3687&videoType.id=3377&completeDate=2018-11-17&originality.id=3650&photographer.id=2928&editor.id=2755&performer1.id=1737&performer2.id=&performer3.id=&consumption=16344.70&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 21:46:55');
INSERT INTO `sys_log` VALUES (935, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1685&_=1542461678345&', '0:0:0:0:0:0:0:1', '2018-11-17 21:47:27');
INSERT INTO `sys_log` VALUES (936, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=1685&businessDepartment.id=4441&productType.id=1989&customer.id=10696&industry.id=3328&demandSector.id=4442&optimizer.id=3687&videoType.id=3377&completeDate=2018-11-17&originality.id=3650&photographer.id=2928&editor.id=2755&performer1.id=1737&performer2.id=1738&performer3.id=1737&consumption=16344.70&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 21:47:34');
INSERT INTO `sys_log` VALUES (937, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=2082&_=1542461678346&', '0:0:0:0:0:0:0:1', '2018-11-17 21:47:43');
INSERT INTO `sys_log` VALUES (938, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1684&_=1542461678347&', '0:0:0:0:0:0:0:1', '2018-11-17 22:08:38');
INSERT INTO `sys_log` VALUES (939, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:ids=undefined2534,2534,2534,2534,2534,2534,2534,2534,2534,2534,&', '0:0:0:0:0:0:0:1', '2018-11-17 22:43:56');
INSERT INTO `sys_log` VALUES (940, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:ids=undefined2534,2534,2534,2534,2534,2534,2534,2534,2534,2534,&', '0:0:0:0:0:0:0:1', '2018-11-17 22:48:25');
INSERT INTO `sys_log` VALUES (941, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:ids=undefined2534,2534,2534,2534,2534,2534,2534,2534,2534,2534,&', '0:0:0:0:0:0:0:1', '2018-11-17 22:49:02');
INSERT INTO `sys_log` VALUES (942, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:ids=2534,2534,2534,2534,2534,2534,2534,2534,2534,2534,&', '0:0:0:0:0:0:0:1', '2018-11-17 22:50:47');
INSERT INTO `sys_log` VALUES (943, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:ids=2533,2533,2533,2533,2533,2533,2533,2533,2533,2533,&', '0:0:0:0:0:0:0:1', '2018-11-17 22:51:27');
INSERT INTO `sys_log` VALUES (944, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:ids=1777,1271,1272,1273,1274,1275,1276,1277,1278,1279,&', '0:0:0:0:0:0:0:1', '2018-11-17 22:52:49');
INSERT INTO `sys_log` VALUES (945, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:ids=1280,1281,1282,1283,1284,1285,1286,1287,1288,1289,&', '0:0:0:0:0:0:0:1', '2018-11-17 22:52:58');
INSERT INTO `sys_log` VALUES (946, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:ids=1292,1293,1294,&', '0:0:0:0:0:0:0:1', '2018-11-17 22:54:19');
INSERT INTO `sys_log` VALUES (947, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:delete,[参数]:ids=1290,1291,1295,1296,1297,1298,1299,1300,1301,1302,&', '0:0:0:0:0:0:0:1', '2018-11-17 22:55:21');
INSERT INTO `sys_log` VALUES (948, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1312&_=1542466094407&', '0:0:0:0:0:0:0:1', '2018-11-17 22:58:53');
INSERT INTO `sys_log` VALUES (949, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1304&_=1542466094409&', '0:0:0:0:0:0:0:1', '2018-11-17 23:06:17');
INSERT INTO `sys_log` VALUES (950, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1304&_=1542466094411&', '0:0:0:0:0:0:0:1', '2018-11-17 23:07:00');
INSERT INTO `sys_log` VALUES (951, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1304&_=1542466094412&', '0:0:0:0:0:0:0:1', '2018-11-17 23:07:28');
INSERT INTO `sys_log` VALUES (952, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1304&_=1542466094413&', '0:0:0:0:0:0:0:1', '2018-11-17 23:09:07');
INSERT INTO `sys_log` VALUES (953, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:edit,[参数]:id=1390&businessDepartment.id=7&productType.id=1990&customer.id=10404&industry.id=3329&demandSector.id=7&optimizer.id=3667&videoType.id=3379&completeDate=2018-11-17&originality.id=3629&photographer.id=2919&editor.id=2752&performer1.id=1736&performer2.id=1737&performer3.id=1737&consumption=0.00&recoredDate=2018-11-17&', '0:0:0:0:0:0:0:1', '2018-11-17 23:26:24');
INSERT INTO `sys_log` VALUES (954, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1305&_=1542470364358&', '0:0:0:0:0:0:0:1', '2018-11-18 00:07:23');
INSERT INTO `sys_log` VALUES (955, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1305&_=1542470364359&', '0:0:0:0:0:0:0:1', '2018-11-18 00:07:28');
INSERT INTO `sys_log` VALUES (956, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542470364360&', '0:0:0:0:0:0:0:1', '2018-11-18 00:07:36');
INSERT INTO `sys_log` VALUES (957, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1306&_=1542470364361&', '0:0:0:0:0:0:0:1', '2018-11-18 00:08:33');
INSERT INTO `sys_log` VALUES (958, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1307&_=1542470364363&', '0:0:0:0:0:0:0:1', '2018-11-18 00:12:23');
INSERT INTO `sys_log` VALUES (959, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1307&_=1542470364364&', '0:0:0:0:0:0:0:1', '2018-11-18 00:13:00');
INSERT INTO `sys_log` VALUES (960, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542470364365&', '0:0:0:0:0:0:0:1', '2018-11-18 00:13:04');
INSERT INTO `sys_log` VALUES (961, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=1307&_=1542470364366&', '0:0:0:0:0:0:0:1', '2018-11-18 00:13:16');
INSERT INTO `sys_log` VALUES (962, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542470364367&', '0:0:0:0:0:0:0:1', '2018-11-18 00:13:36');
INSERT INTO `sys_log` VALUES (963, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542470364368&', '0:0:0:0:0:0:0:1', '2018-11-18 00:16:58');
INSERT INTO `sys_log` VALUES (964, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542470364369&', '0:0:0:0:0:0:0:1', '2018-11-18 00:24:34');
INSERT INTO `sys_log` VALUES (965, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542470364370&', '0:0:0:0:0:0:0:1', '2018-11-18 00:25:16');
INSERT INTO `sys_log` VALUES (966, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542470364371&', '0:0:0:0:0:0:0:1', '2018-11-18 00:26:17');
INSERT INTO `sys_log` VALUES (967, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542470364373&', '0:0:0:0:0:0:0:1', '2018-11-18 00:26:25');
INSERT INTO `sys_log` VALUES (968, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542470364374&', '0:0:0:0:0:0:0:1', '2018-11-18 00:26:51');
INSERT INTO `sys_log` VALUES (969, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1304&_=1542470364375&', '0:0:0:0:0:0:0:1', '2018-11-18 00:26:57');
INSERT INTO `sys_log` VALUES (970, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1303&_=1542470364377&', '0:0:0:0:0:0:0:1', '2018-11-18 00:27:04');
INSERT INTO `sys_log` VALUES (971, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1303&_=1542470364378&', '0:0:0:0:0:0:0:1', '2018-11-18 00:27:09');
INSERT INTO `sys_log` VALUES (972, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728248&', '0:0:0:0:0:0:0:1', '2018-11-18 00:28:32');
INSERT INTO `sys_log` VALUES (973, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728249&', '0:0:0:0:0:0:0:1', '2018-11-18 00:28:54');
INSERT INTO `sys_log` VALUES (974, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728250&', '0:0:0:0:0:0:0:1', '2018-11-18 00:29:35');
INSERT INTO `sys_log` VALUES (975, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542458728252&', '0:0:0:0:0:0:0:1', '2018-11-18 00:29:41');
INSERT INTO `sys_log` VALUES (976, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1303&_=1542458728253&', '0:0:0:0:0:0:0:1', '2018-11-18 00:29:46');
INSERT INTO `sys_log` VALUES (977, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1305&_=1542458728254&', '0:0:0:0:0:0:0:1', '2018-11-18 00:30:00');
INSERT INTO `sys_log` VALUES (978, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 00:33:13');
INSERT INTO `sys_log` VALUES (979, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=234&_=1542470364382&', '0:0:0:0:0:0:0:1', '2018-11-18 00:34:08');
INSERT INTO `sys_log` VALUES (980, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 00:34:16');
INSERT INTO `sys_log` VALUES (981, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=数据字典&resourceType=0&url=&openMode=无(用于上层菜单)&icon=glyphicon-book icon-blue&seq=0&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-11-18 00:35:04');
INSERT INTO `sys_log` VALUES (982, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 00:35:15');
INSERT INTO `sys_log` VALUES (983, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=客户管理&resourceType=0&url=/customer/manager&openMode=iframe&icon=glyphicon-user icon-green&seq=0&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 00:36:17');
INSERT INTO `sys_log` VALUES (984, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=242&_=1542470364389&', '0:0:0:0:0:0:0:1', '2018-11-18 00:36:36');
INSERT INTO `sys_log` VALUES (985, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=242&name=客户管理&resourceType=0&url=/customer/manager&openMode=ajax&icon=glyphicon-user icon-green&seq=0&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 00:36:42');
INSERT INTO `sys_log` VALUES (986, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=242&_=1542470364392&', '0:0:0:0:0:0:0:1', '2018-11-18 00:37:23');
INSERT INTO `sys_log` VALUES (987, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1542472792455&', '0:0:0:0:0:0:0:1', '2018-11-18 00:40:09');
INSERT INTO `sys_log` VALUES (988, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=226,234,233,235,236,237,238,239,240,241,242,1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,229,221,227,228&', '0:0:0:0:0:0:0:1', '2018-11-18 00:40:15');
INSERT INTO `sys_log` VALUES (989, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=242&_=1542472792463&', '0:0:0:0:0:0:0:1', '2018-11-18 00:48:11');
INSERT INTO `sys_log` VALUES (990, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 00:48:18');
INSERT INTO `sys_log` VALUES (991, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=0&url=/customer/dataGrid&openMode=ajax&icon=glyphicon-list icon-green&seq=0&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 00:49:20');
INSERT INTO `sys_log` VALUES (992, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 00:49:28');
INSERT INTO `sys_log` VALUES (993, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=0&url=/customer/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 00:50:02');
INSERT INTO `sys_log` VALUES (994, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 00:50:09');
INSERT INTO `sys_log` VALUES (995, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=0&url=/videoCost/edit&openMode=ajax&icon=glyphicon-pencil icon-green&seq=0&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 00:50:40');
INSERT INTO `sys_log` VALUES (996, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=245&_=1542472792470&', '0:0:0:0:0:0:0:1', '2018-11-18 00:50:48');
INSERT INTO `sys_log` VALUES (997, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=245&name=编辑&resourceType=0&url=/videoCost/edit&openMode=&icon=glyphicon-pencil icon-green&seq=2&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 00:50:51');
INSERT INTO `sys_log` VALUES (998, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 00:50:57');
INSERT INTO `sys_log` VALUES (999, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=0&url=/videoCost/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 00:51:40');
INSERT INTO `sys_log` VALUES (1000, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1542472792474&', '0:0:0:0:0:0:0:1', '2018-11-18 00:51:55');
INSERT INTO `sys_log` VALUES (1001, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=226,234,233,235,236,237,238,239,240,241,242,243,244,245,246,1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,229,221,227,228&', '0:0:0:0:0:0:0:1', '2018-11-18 00:52:06');
INSERT INTO `sys_log` VALUES (1002, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:', NULL, '2018-11-18 01:04:18');
INSERT INTO `sys_log` VALUES (1003, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1542474239951&', '0:0:0:0:0:0:0:1', '2018-11-18 01:04:24');
INSERT INTO `sys_log` VALUES (1004, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=244&_=1542474239955&', '0:0:0:0:0:0:0:1', '2018-11-18 01:04:52');
INSERT INTO `sys_log` VALUES (1005, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=244&name=添加&resourceType=1&url=/customer/add&openMode=&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 01:04:57');
INSERT INTO `sys_log` VALUES (1006, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=243&_=1542474239956&', '0:0:0:0:0:0:0:1', '2018-11-18 01:05:07');
INSERT INTO `sys_log` VALUES (1007, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=243&name=列表&resourceType=1&url=/customer/dataGrid&openMode=&icon=glyphicon-list icon-green&seq=0&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 01:05:10');
INSERT INTO `sys_log` VALUES (1008, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=245&_=1542474239957&', '0:0:0:0:0:0:0:1', '2018-11-18 01:05:15');
INSERT INTO `sys_log` VALUES (1009, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=245&name=编辑&resourceType=1&url=/videoCost/edit&openMode=&icon=glyphicon-pencil icon-green&seq=2&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 01:05:18');
INSERT INTO `sys_log` VALUES (1010, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=246&_=1542474239958&', '0:0:0:0:0:0:0:1', '2018-11-18 01:05:19');
INSERT INTO `sys_log` VALUES (1011, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=246&name=删除&resourceType=1&url=/videoCost/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 01:05:25');
INSERT INTO `sys_log` VALUES (1012, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1542474239959&', '0:0:0:0:0:0:0:1', '2018-11-18 01:05:33');
INSERT INTO `sys_log` VALUES (1013, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1542504010414&', '0:0:0:0:0:0:0:1', '2018-11-18 09:21:03');
INSERT INTO `sys_log` VALUES (1014, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:21:27');
INSERT INTO `sys_log` VALUES (1015, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=剪辑&resourceType=0&url=/editor/manager&openMode=ajax&icon=glyphicon-film icon-green&seq=0&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 09:24:20');
INSERT INTO `sys_log` VALUES (1016, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:24:29');
INSERT INTO `sys_log` VALUES (1017, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=1&url=/editor/dataGrid&openMode=ajax&icon=glyphicon-list icon-green&seq=0&status=0&opened=1&pid=247&', '0:0:0:0:0:0:0:1', '2018-11-18 09:25:34');
INSERT INTO `sys_log` VALUES (1018, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:25:51');
INSERT INTO `sys_log` VALUES (1019, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=1&url=/editor/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=247&', '0:0:0:0:0:0:0:1', '2018-11-18 09:26:49');
INSERT INTO `sys_log` VALUES (1020, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:26:55');
INSERT INTO `sys_log` VALUES (1021, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=0&url=/editor/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=2&status=0&opened=1&pid=247&', '0:0:0:0:0:0:0:1', '2018-11-18 09:27:40');
INSERT INTO `sys_log` VALUES (1022, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:27:44');
INSERT INTO `sys_log` VALUES (1023, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=0&url=/editor/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=4&status=0&opened=1&pid=247&', '0:0:0:0:0:0:0:1', '2018-11-18 09:28:18');
INSERT INTO `sys_log` VALUES (1024, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=243&_=1542504010427&', '0:0:0:0:0:0:0:1', '2018-11-18 09:28:33');
INSERT INTO `sys_log` VALUES (1025, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=243&name=列表&resourceType=1&url=/customer/dataGrid&openMode=ajax&icon=glyphicon-list icon-green&seq=0&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 09:28:37');
INSERT INTO `sys_log` VALUES (1026, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=244&_=1542504010428&', '0:0:0:0:0:0:0:1', '2018-11-18 09:28:38');
INSERT INTO `sys_log` VALUES (1027, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=244&name=添加&resourceType=1&url=/customer/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 09:28:41');
INSERT INTO `sys_log` VALUES (1028, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=245&_=1542504010429&', '0:0:0:0:0:0:0:1', '2018-11-18 09:28:43');
INSERT INTO `sys_log` VALUES (1029, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=245&name=编辑&resourceType=1&url=/videoCost/edit&openMode=ajax&icon=glyphicon-pencil icon-green&seq=2&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-18 09:28:46');
INSERT INTO `sys_log` VALUES (1030, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=250&_=1542504010430&', '0:0:0:0:0:0:0:1', '2018-11-18 09:28:52');
INSERT INTO `sys_log` VALUES (1031, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=250&name=编辑&resourceType=0&url=/editor/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=2&status=0&opened=1&pid=247&', '0:0:0:0:0:0:0:1', '2018-11-18 09:28:55');
INSERT INTO `sys_log` VALUES (1032, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=251&_=1542504010431&', '0:0:0:0:0:0:0:1', '2018-11-18 09:28:57');
INSERT INTO `sys_log` VALUES (1033, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=251&name=删除&resourceType=0&url=/editor/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=4&status=0&opened=1&pid=247&', '0:0:0:0:0:0:0:1', '2018-11-18 09:29:00');
INSERT INTO `sys_log` VALUES (1034, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:29:07');
INSERT INTO `sys_log` VALUES (1035, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=行业&resourceType=0&url=/industry/manager&openMode=无(用于上层菜单)&icon=glyphicon-tasks icon-green&seq=0&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 09:30:31');
INSERT INTO `sys_log` VALUES (1036, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:30:42');
INSERT INTO `sys_log` VALUES (1037, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=1&url=/industry/dataGrid&openMode=ajax&icon=glyphicon-list icon-green&seq=0&status=0&opened=1&pid=252&', '0:0:0:0:0:0:0:1', '2018-11-18 09:31:41');
INSERT INTO `sys_log` VALUES (1038, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:31:46');
INSERT INTO `sys_log` VALUES (1039, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=1&url=/industry/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=0&status=0&opened=1&pid=252&', '0:0:0:0:0:0:0:1', '2018-11-18 09:32:53');
INSERT INTO `sys_log` VALUES (1040, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:32:56');
INSERT INTO `sys_log` VALUES (1041, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=0&url=/industry/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=0&status=0&opened=1&pid=252&', '0:0:0:0:0:0:0:1', '2018-11-18 09:33:33');
INSERT INTO `sys_log` VALUES (1042, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:33:51');
INSERT INTO `sys_log` VALUES (1043, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=1&url=/industry/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=0&status=0&opened=1&pid=252&', '0:0:0:0:0:0:0:1', '2018-11-18 09:34:27');
INSERT INTO `sys_log` VALUES (1044, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=256&_=1542504010442&', '0:0:0:0:0:0:0:1', '2018-11-18 09:34:33');
INSERT INTO `sys_log` VALUES (1045, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=256&name=删除&resourceType=1&url=/industry/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=252&', '0:0:0:0:0:0:0:1', '2018-11-18 09:34:36');
INSERT INTO `sys_log` VALUES (1046, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=255&_=1542504010443&', '0:0:0:0:0:0:0:1', '2018-11-18 09:34:39');
INSERT INTO `sys_log` VALUES (1047, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=255&name=编辑&resourceType=0&url=/industry/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=2&status=0&opened=1&pid=252&', '0:0:0:0:0:0:0:1', '2018-11-18 09:34:46');
INSERT INTO `sys_log` VALUES (1048, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=254&_=1542504010444&', '0:0:0:0:0:0:0:1', '2018-11-18 09:34:49');
INSERT INTO `sys_log` VALUES (1049, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=254&name=添加&resourceType=1&url=/industry/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=252&', '0:0:0:0:0:0:0:1', '2018-11-18 09:34:51');
INSERT INTO `sys_log` VALUES (1050, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=255&_=1542504010445&', '0:0:0:0:0:0:0:1', '2018-11-18 09:35:01');
INSERT INTO `sys_log` VALUES (1051, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=255&name=编辑&resourceType=1&url=/industry/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=2&status=0&opened=1&pid=252&', '0:0:0:0:0:0:0:1', '2018-11-18 09:35:04');
INSERT INTO `sys_log` VALUES (1052, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=250&_=1542504010446&', '0:0:0:0:0:0:0:1', '2018-11-18 09:35:11');
INSERT INTO `sys_log` VALUES (1053, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=250&name=编辑&resourceType=1&url=/editor/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=2&status=0&opened=1&pid=247&', '0:0:0:0:0:0:0:1', '2018-11-18 09:35:13');
INSERT INTO `sys_log` VALUES (1054, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=251&_=1542504010447&', '0:0:0:0:0:0:0:1', '2018-11-18 09:35:17');
INSERT INTO `sys_log` VALUES (1055, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=251&name=删除&resourceType=1&url=/editor/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=4&status=0&opened=1&pid=247&', '0:0:0:0:0:0:0:1', '2018-11-18 09:35:20');
INSERT INTO `sys_log` VALUES (1056, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:35:25');
INSERT INTO `sys_log` VALUES (1057, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=优化&resourceType=0&url=/optimizer/manager&openMode=ajax&icon=glyphicon-magnet icon-yellow&seq=0&status=0&opened=0&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 09:36:59');
INSERT INTO `sys_log` VALUES (1058, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=247&_=1542504010450&', '0:0:0:0:0:0:0:1', '2018-11-18 09:37:13');
INSERT INTO `sys_log` VALUES (1059, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=247&name=剪辑&resourceType=0&url=/editor/manager&openMode=&icon=glyphicon-film icon-green&seq=1&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 09:37:17');
INSERT INTO `sys_log` VALUES (1060, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=252&_=1542504010451&', '0:0:0:0:0:0:0:1', '2018-11-18 09:37:26');
INSERT INTO `sys_log` VALUES (1061, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=252&name=行业&resourceType=0&url=/industry/manager&openMode=&icon=glyphicon-tasks icon-green&seq=2&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 09:37:29');
INSERT INTO `sys_log` VALUES (1062, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=257&_=1542504010452&', '0:0:0:0:0:0:0:1', '2018-11-18 09:37:40');
INSERT INTO `sys_log` VALUES (1063, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=257&name=优化&resourceType=0&url=/optimizer/manager&openMode=&icon=glyphicon-magnet icon-yellow&seq=3&status=0&opened=0&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 09:37:44');
INSERT INTO `sys_log` VALUES (1064, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:37:49');
INSERT INTO `sys_log` VALUES (1065, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=1&url=/optimizer/dataGrid&openMode=ajax&icon=glyphicon-list icon-purple&seq=0&status=0&opened=1&pid=257&', '0:0:0:0:0:0:0:1', '2018-11-18 09:38:35');
INSERT INTO `sys_log` VALUES (1066, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:38:38');
INSERT INTO `sys_log` VALUES (1067, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=1&url=/optimizer/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=257&', '0:0:0:0:0:0:0:1', '2018-11-18 09:39:31');
INSERT INTO `sys_log` VALUES (1068, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:39:35');
INSERT INTO `sys_log` VALUES (1069, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=1&url=/optimizer/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=2&status=0&opened=1&pid=257&', '0:0:0:0:0:0:0:1', '2018-11-18 09:40:06');
INSERT INTO `sys_log` VALUES (1070, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:40:09');
INSERT INTO `sys_log` VALUES (1071, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=1&url=/optimizer/add&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=257&', '0:0:0:0:0:0:0:1', '2018-11-18 09:40:41');
INSERT INTO `sys_log` VALUES (1072, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:40:52');
INSERT INTO `sys_log` VALUES (1073, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:45:38');
INSERT INTO `sys_log` VALUES (1074, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=创意&resourceType=0&url=/originality/manager&openMode=ajax&icon=glyphicon-star icon-green&seq=4&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 09:47:16');
INSERT INTO `sys_log` VALUES (1075, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:47:20');
INSERT INTO `sys_log` VALUES (1076, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=262&_=1542504010465&', '0:0:0:0:0:0:0:1', '2018-11-18 09:47:25');
INSERT INTO `sys_log` VALUES (1077, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=262&name=创意&resourceType=0&url=/originality/manager&openMode=&icon=glyphicon-star icon-yellow&seq=4&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 09:47:39');
INSERT INTO `sys_log` VALUES (1078, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:47:41');
INSERT INTO `sys_log` VALUES (1079, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=1&url=/originality/dataGrid&openMode=ajax&icon=glyphicon-list icon-purple&seq=0&status=0&opened=1&pid=262&', '0:0:0:0:0:0:0:1', '2018-11-18 09:48:23');
INSERT INTO `sys_log` VALUES (1080, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 09:59:18');
INSERT INTO `sys_log` VALUES (1081, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=1&url=/originality/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=262&', '0:0:0:0:0:0:0:1', '2018-11-18 09:59:58');
INSERT INTO `sys_log` VALUES (1082, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:00:03');
INSERT INTO `sys_log` VALUES (1083, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=1&url=/originality/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=2&status=0&opened=1&pid=262&', '0:0:0:0:0:0:0:1', '2018-11-18 10:00:34');
INSERT INTO `sys_log` VALUES (1084, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:00:37');
INSERT INTO `sys_log` VALUES (1085, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=1&url=/originality/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=262&', '0:0:0:0:0:0:0:1', '2018-11-18 10:01:31');
INSERT INTO `sys_log` VALUES (1086, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:02:08');
INSERT INTO `sys_log` VALUES (1087, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=演员&resourceType=0&url=/performer/manager&openMode=无(用于上层菜单)&icon=glyphicon-eye-open icon-yellow&seq=5&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-11-18 10:04:09');
INSERT INTO `sys_log` VALUES (1088, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=267&_=1542504010477&', '0:0:0:0:0:0:0:1', '2018-11-18 10:04:22');
INSERT INTO `sys_log` VALUES (1089, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=267&name=演员&resourceType=0&url=/performer/manager&openMode=&icon=glyphicon-eye-open icon-yellow&seq=5&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 10:04:26');
INSERT INTO `sys_log` VALUES (1090, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=247&_=1542504010478&', '0:0:0:0:0:0:0:1', '2018-11-18 10:04:30');
INSERT INTO `sys_log` VALUES (1091, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=247&name=剪辑&resourceType=0&url=/editor/manager&openMode=&icon=glyphicon-scissors icon-yellow&seq=1&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 10:04:44');
INSERT INTO `sys_log` VALUES (1092, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:04:57');
INSERT INTO `sys_log` VALUES (1093, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=1&url=/performer/dataGrid&openMode=ajax&icon=glyphicon-list icon-purple&seq=0&status=0&opened=1&pid=267&', '0:0:0:0:0:0:0:1', '2018-11-18 10:06:11');
INSERT INTO `sys_log` VALUES (1094, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:06:15');
INSERT INTO `sys_log` VALUES (1095, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=1&url=/performer/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=267&', '0:0:0:0:0:0:0:1', '2018-11-18 10:06:40');
INSERT INTO `sys_log` VALUES (1096, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:06:46');
INSERT INTO `sys_log` VALUES (1097, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=1&url=/performer/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=2&status=0&opened=1&pid=267&', '0:0:0:0:0:0:0:1', '2018-11-18 10:07:20');
INSERT INTO `sys_log` VALUES (1098, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:07:26');
INSERT INTO `sys_log` VALUES (1099, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=1&url=/performer/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=267&', '0:0:0:0:0:0:0:1', '2018-11-18 10:07:53');
INSERT INTO `sys_log` VALUES (1100, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:07:57');
INSERT INTO `sys_log` VALUES (1101, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=摄像&resourceType=0&url=/photographer/manager&openMode=无(用于上层菜单)&icon=glyphicon-film icon-yellow&seq=6&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 10:09:15');
INSERT INTO `sys_log` VALUES (1102, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:09:23');
INSERT INTO `sys_log` VALUES (1103, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=1&url=/photographer/dataGrid&openMode=ajax&icon=glyphicon-list icon-purple&seq=0&status=0&opened=1&pid=272&', '0:0:0:0:0:0:0:1', '2018-11-18 10:09:59');
INSERT INTO `sys_log` VALUES (1104, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:10:17');
INSERT INTO `sys_log` VALUES (1105, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=1&url=/photographer/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=272&', '0:0:0:0:0:0:0:1', '2018-11-18 10:10:50');
INSERT INTO `sys_log` VALUES (1106, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:10:52');
INSERT INTO `sys_log` VALUES (1107, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=1&url=/photographer/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=2&status=0&opened=1&pid=272&', '0:0:0:0:0:0:0:1', '2018-11-18 10:11:22');
INSERT INTO `sys_log` VALUES (1108, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:11:26');
INSERT INTO `sys_log` VALUES (1109, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=1&url=/photographer/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=272&', '0:0:0:0:0:0:0:1', '2018-11-18 10:11:52');
INSERT INTO `sys_log` VALUES (1110, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:16:23');
INSERT INTO `sys_log` VALUES (1111, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=产品类型&resourceType=0&url=/productType/manager&openMode=无(用于上层菜单)&icon=glyphicon-th-large icon-yellow&seq=0&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 10:17:48');
INSERT INTO `sys_log` VALUES (1112, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=277&_=1542504010500&', '0:0:0:0:0:0:0:1', '2018-11-18 10:18:02');
INSERT INTO `sys_log` VALUES (1113, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=277&name=产品类型&resourceType=0&url=/productType/manager&openMode=&icon=glyphicon-th-large icon-yellow&seq=7&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 10:18:05');
INSERT INTO `sys_log` VALUES (1114, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:18:12');
INSERT INTO `sys_log` VALUES (1115, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=1&url=/productType/dataGrid&openMode=ajax&icon=glyphicon-list icon-purple&seq=0&status=0&opened=1&pid=277&', '0:0:0:0:0:0:0:1', '2018-11-18 10:18:53');
INSERT INTO `sys_log` VALUES (1116, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:18:56');
INSERT INTO `sys_log` VALUES (1117, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=1&url=/productType/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=277&', '0:0:0:0:0:0:0:1', '2018-11-18 10:19:30');
INSERT INTO `sys_log` VALUES (1118, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:19:35');
INSERT INTO `sys_log` VALUES (1119, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=1&url=/productType/edit&openMode=ajax&icon=glyphicon-pencil icon-blue&seq=2&status=0&opened=1&pid=277&', '0:0:0:0:0:0:0:1', '2018-11-18 10:20:05');
INSERT INTO `sys_log` VALUES (1120, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:20:08');
INSERT INTO `sys_log` VALUES (1121, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=1&url=/productType/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=277&', '0:0:0:0:0:0:0:1', '2018-11-18 10:20:39');
INSERT INTO `sys_log` VALUES (1122, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=242&_=1542504010509&', '0:0:0:0:0:0:0:1', '2018-11-18 10:22:12');
INSERT INTO `sys_log` VALUES (1123, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=242&name=客户&resourceType=0&url=/customer/manager&openMode=ajax&icon=glyphicon-user icon-green&seq=0&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 10:22:15');
INSERT INTO `sys_log` VALUES (1124, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:22:27');
INSERT INTO `sys_log` VALUES (1125, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=视频类别&resourceType=0&url=/videoType/manager&openMode=无(用于上层菜单)&icon=glyphicon-film icon-yellow&seq=8&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 10:24:09');
INSERT INTO `sys_log` VALUES (1126, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=272&_=1542504010512&', '0:0:0:0:0:0:0:1', '2018-11-18 10:24:15');
INSERT INTO `sys_log` VALUES (1127, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=272&name=摄像&resourceType=0&url=/photographer/manager&openMode=&icon=glyphicon-camera icon-yellow&seq=6&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 10:24:21');
INSERT INTO `sys_log` VALUES (1128, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:24:26');
INSERT INTO `sys_log` VALUES (1129, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=列表&resourceType=1&url=/videoType/dataGrid&openMode=ajax&icon=glyphicon-list icon-purple&seq=0&status=0&opened=1&pid=282&', '0:0:0:0:0:0:0:1', '2018-11-18 10:25:29');
INSERT INTO `sys_log` VALUES (1130, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:25:32');
INSERT INTO `sys_log` VALUES (1131, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=添加&resourceType=1&url=/videoType/add&openMode=ajax&icon=glyphicon-plus icon-green&seq=1&status=0&opened=1&pid=282&', '0:0:0:0:0:0:0:1', '2018-11-18 10:26:11');
INSERT INTO `sys_log` VALUES (1132, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:26:16');
INSERT INTO `sys_log` VALUES (1133, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=编辑&resourceType=1&url=/videoType/edit&openMode=ajax&icon=glyphicon-pencil icon-purple&seq=2&status=0&opened=1&pid=282&', '0:0:0:0:0:0:0:1', '2018-11-18 10:26:42');
INSERT INTO `sys_log` VALUES (1134, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:addPage,[参数]:', NULL, '2018-11-18 10:26:49');
INSERT INTO `sys_log` VALUES (1135, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:add,[参数]:name=删除&resourceType=0&url=/videoType/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=282&', '0:0:0:0:0:0:0:1', '2018-11-18 10:27:16');
INSERT INTO `sys_log` VALUES (1136, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=286&_=1542504010522&', '0:0:0:0:0:0:0:1', '2018-11-18 10:27:24');
INSERT INTO `sys_log` VALUES (1137, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=286&name=删除&resourceType=1&url=/videoType/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=282&', '0:0:0:0:0:0:0:1', '2018-11-18 10:27:31');
INSERT INTO `sys_log` VALUES (1138, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1542508849413&', '0:0:0:0:0:0:0:1', '2018-11-18 10:41:15');
INSERT INTO `sys_log` VALUES (1139, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=226,234,233,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,229,221,227,228&', '0:0:0:0:0:0:0:1', '2018-11-18 10:41:50');
INSERT INTO `sys_log` VALUES (1140, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11437&_=1542513520927&', '0:0:0:0:0:0:0:1', '2018-11-18 12:03:30');
INSERT INTO `sys_log` VALUES (1141, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11437&_=1542513520928&', '0:0:0:0:0:0:0:1', '2018-11-18 12:03:53');
INSERT INTO `sys_log` VALUES (1142, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542513520931&', '0:0:0:0:0:0:0:1', '2018-11-18 12:06:40');
INSERT INTO `sys_log` VALUES (1143, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542513520932&', '0:0:0:0:0:0:0:1', '2018-11-18 12:08:35');
INSERT INTO `sys_log` VALUES (1144, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542513520935&', '0:0:0:0:0:0:0:1', '2018-11-18 12:21:59');
INSERT INTO `sys_log` VALUES (1145, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11432&_=1542513520936&', '0:0:0:0:0:0:0:1', '2018-11-18 12:22:05');
INSERT INTO `sys_log` VALUES (1146, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11436&_=1542515086167&', '0:0:0:0:0:0:0:1', '2018-11-18 12:25:27');
INSERT INTO `sys_log` VALUES (1147, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542515086168&', '0:0:0:0:0:0:0:1', '2018-11-18 12:25:35');
INSERT INTO `sys_log` VALUES (1148, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542515086169&', '0:0:0:0:0:0:0:1', '2018-11-18 12:25:56');
INSERT INTO `sys_log` VALUES (1149, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11437&_=1542515086170&', '0:0:0:0:0:0:0:1', '2018-11-18 12:26:00');
INSERT INTO `sys_log` VALUES (1150, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542515506232&', '0:0:0:0:0:0:0:1', '2018-11-18 12:31:53');
INSERT INTO `sys_log` VALUES (1151, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11437&_=1542515506233&', '0:0:0:0:0:0:0:1', '2018-11-18 12:31:57');
INSERT INTO `sys_log` VALUES (1152, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11437&_=1542515641813&', '0:0:0:0:0:0:0:1', '2018-11-18 12:34:10');
INSERT INTO `sys_log` VALUES (1153, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11432&_=1542515641815&', '0:0:0:0:0:0:0:1', '2018-11-18 12:40:44');
INSERT INTO `sys_log` VALUES (1154, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542515641816&', '0:0:0:0:0:0:0:1', '2018-11-18 12:40:53');
INSERT INTO `sys_log` VALUES (1155, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542515641817&', '0:0:0:0:0:0:0:1', '2018-11-18 12:40:59');
INSERT INTO `sys_log` VALUES (1156, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11436&_=1542515641818&', '0:0:0:0:0:0:0:1', '2018-11-18 12:41:02');
INSERT INTO `sys_log` VALUES (1157, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542515641819&', '0:0:0:0:0:0:0:1', '2018-11-18 12:41:06');
INSERT INTO `sys_log` VALUES (1158, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11432&_=1542515641820&', '0:0:0:0:0:0:0:1', '2018-11-18 12:41:22');
INSERT INTO `sys_log` VALUES (1159, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11436&_=1542515618629&', '0:0:0:0:0:0:0:1', '2018-11-18 12:42:18');
INSERT INTO `sys_log` VALUES (1160, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11436&_=1542515618630&', '0:0:0:0:0:0:0:1', '2018-11-18 12:42:24');
INSERT INTO `sys_log` VALUES (1161, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11436&_=1542515618631&', '0:0:0:0:0:0:0:1', '2018-11-18 12:42:29');
INSERT INTO `sys_log` VALUES (1162, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542515618633&', '0:0:0:0:0:0:0:1', '2018-11-18 12:44:06');
INSERT INTO `sys_log` VALUES (1163, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11432&_=1542515618634&', '0:0:0:0:0:0:0:1', '2018-11-18 12:44:09');
INSERT INTO `sys_log` VALUES (1164, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:add,[参数]:id=&code=CUS201811111925591444346112&name=优借-动画版0&', '0:0:0:0:0:0:0:1', '2018-11-18 12:44:14');
INSERT INTO `sys_log` VALUES (1165, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11437&_=1542515618636&', '0:0:0:0:0:0:0:1', '2018-11-18 12:47:54');
INSERT INTO `sys_log` VALUES (1166, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542515618637&', '0:0:0:0:0:0:0:1', '2018-11-18 12:48:03');
INSERT INTO `sys_log` VALUES (1167, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11432&_=1542515618638&', '0:0:0:0:0:0:0:1', '2018-11-18 12:48:06');
INSERT INTO `sys_log` VALUES (1168, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:add,[参数]:id=&code=CUS201811111925591444346112&name=优借-动画版0&', '0:0:0:0:0:0:0:1', '2018-11-18 12:48:10');
INSERT INTO `sys_log` VALUES (1169, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11432&_=1542516646486&', '0:0:0:0:0:0:0:1', '2018-11-18 12:50:51');
INSERT INTO `sys_log` VALUES (1170, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:add,[参数]:id=&code=CUS201811111925591444346112&name=优借-动画版0&', '0:0:0:0:0:0:0:1', '2018-11-18 12:50:56');
INSERT INTO `sys_log` VALUES (1171, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11432&_=1542516646487&', '0:0:0:0:0:0:0:1', '2018-11-18 12:51:15');
INSERT INTO `sys_log` VALUES (1172, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:add,[参数]:id=&code=CUS2018111119255922&name=优借-动画版0&', '0:0:0:0:0:0:0:1', '2018-11-18 12:51:24');
INSERT INTO `sys_log` VALUES (1173, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11462&_=1542516981908&', '0:0:0:0:0:0:0:1', '2018-11-18 12:56:43');
INSERT INTO `sys_log` VALUES (1174, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11432&_=1542516981910&', '0:0:0:0:0:0:0:1', '2018-11-18 12:56:59');
INSERT INTO `sys_log` VALUES (1175, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11436&_=1542516981911&', '0:0:0:0:0:0:0:1', '2018-11-18 12:57:03');
INSERT INTO `sys_log` VALUES (1176, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542516981912&', '0:0:0:0:0:0:0:1', '2018-11-18 12:57:07');
INSERT INTO `sys_log` VALUES (1177, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:editPage,[参数]:id=2763&_=1542517416025&', '0:0:0:0:0:0:0:1', '2018-11-18 13:03:49');
INSERT INTO `sys_log` VALUES (1178, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:addPage,[参数]:id=2763&_=1542517416026&', '0:0:0:0:0:0:0:1', '2018-11-18 13:03:52');
INSERT INTO `sys_log` VALUES (1179, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:editPage,[参数]:id=2761&_=1542517416028&', '0:0:0:0:0:0:0:1', '2018-11-18 13:04:12');
INSERT INTO `sys_log` VALUES (1180, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:editPage,[参数]:id=2761&_=1542517416029&', '0:0:0:0:0:0:0:1', '2018-11-18 13:04:15');
INSERT INTO `sys_log` VALUES (1181, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:edit,[参数]:id=2761&code=EDI201811111925561823647972&name=刘子涵0&', '0:0:0:0:0:0:0:1', '2018-11-18 13:04:20');
INSERT INTO `sys_log` VALUES (1182, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:delete,[参数]:ids=2763&', '0:0:0:0:0:0:0:1', '2018-11-18 13:04:40');
INSERT INTO `sys_log` VALUES (1183, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-11-18 13:07:06');
INSERT INTO `sys_log` VALUES (1184, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=234&_=1542517632947&', '0:0:0:0:0:0:0:1', '2018-11-18 13:07:59');
INSERT INTO `sys_log` VALUES (1185, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=257&_=1542517632948&', '0:0:0:0:0:0:0:1', '2018-11-18 13:08:13');
INSERT INTO `sys_log` VALUES (1186, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=257&name=优化&resourceType=0&url=/optimizer/manager&openMode=&icon=glyphicon-magnet icon-yellow&seq=3&status=0&opened=1&pid=241&', '0:0:0:0:0:0:0:1', '2018-11-18 13:08:20');
INSERT INTO `sys_log` VALUES (1187, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:addPage,[参数]:', NULL, '2018-11-18 13:08:52');
INSERT INTO `sys_log` VALUES (1188, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:add,[参数]:loginName=LZT1&name=骆长涛&password=123456&sex=0&age=30&userType=0&organizationId=4446&roleIds=1&phone=&status=0&', '0:0:0:0:0:0:0:1', '2018-11-18 13:10:00');
INSERT INTO `sys_log` VALUES (1189, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-11-18 13:10:04');
INSERT INTO `sys_log` VALUES (1190, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1542517810895&', '0:0:0:0:0:0:0:1', '2018-11-18 13:11:03');
INSERT INTO `sys_log` VALUES (1191, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=1&resourceIds=226,234,233,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,229,221,227,228&', '0:0:0:0:0:0:0:1', '2018-11-18 13:11:22');
INSERT INTO `sys_log` VALUES (1192, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-11-18 13:11:29');
INSERT INTO `sys_log` VALUES (1193, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:editPage,[参数]:id=2763&_=1542518398897&', '0:0:0:0:0:0:0:1', '2018-11-18 13:20:11');
INSERT INTO `sys_log` VALUES (1194, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:addPage,[参数]:id=2763&_=1542518398898&', '0:0:0:0:0:0:0:1', '2018-11-18 13:20:16');
INSERT INTO `sys_log` VALUES (1195, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:addPage,[参数]:id=2763&_=1542518398899&', '0:0:0:0:0:0:0:1', '2018-11-18 13:20:24');
INSERT INTO `sys_log` VALUES (1196, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:add,[参数]:id=&code=CUS20181&name=黄寒祎&', '0:0:0:0:0:0:0:1', '2018-11-18 13:20:36');
INSERT INTO `sys_log` VALUES (1197, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:editPage,[参数]:id=2763&_=1542518398900&', '0:0:0:0:0:0:0:1', '2018-11-18 13:20:39');
INSERT INTO `sys_log` VALUES (1198, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:edit,[参数]:id=2763&code=EDI20181111192559119003034&name=黄寒祎0&', '0:0:0:0:0:0:0:1', '2018-11-18 13:20:43');
INSERT INTO `sys_log` VALUES (1199, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:delete,[参数]:ids=2763&', '0:0:0:0:0:0:0:1', '2018-11-18 13:21:03');
INSERT INTO `sys_log` VALUES (1200, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:delete,[参数]:ids=2763&', '0:0:0:0:0:0:0:1', '2018-11-18 13:21:51');
INSERT INTO `sys_log` VALUES (1201, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:delete,[参数]:ids=2763&', '0:0:0:0:0:0:0:1', '2018-11-18 13:22:36');
INSERT INTO `sys_log` VALUES (1202, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:delete,[参数]:ids=2762&', '0:0:0:0:0:0:0:1', '2018-11-18 13:26:56');
INSERT INTO `sys_log` VALUES (1203, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542518398908&', '0:0:0:0:0:0:0:1', '2018-11-18 13:50:55');
INSERT INTO `sys_log` VALUES (1204, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:delete,[参数]:ids=2763&', '0:0:0:0:0:0:0:1', '2018-11-18 13:51:48');
INSERT INTO `sys_log` VALUES (1205, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:editPage,[参数]:id=2763&_=1542518398910&', '0:0:0:0:0:0:0:1', '2018-11-18 13:52:06');
INSERT INTO `sys_log` VALUES (1206, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.OriginalityController,[方法]:delete,[参数]:ids=3675&', '0:0:0:0:0:0:0:1', '2018-11-18 14:09:35');
INSERT INTO `sys_log` VALUES (1207, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.PerformerController,[方法]:delete,[参数]:ids=1749&', '0:0:0:0:0:0:0:1', '2018-11-18 14:15:30');
INSERT INTO `sys_log` VALUES (1208, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.PerformerController,[方法]:delete,[参数]:ids=1749,1750,1748,1746,1747,1741,1742,1743,1744,1745,1736,1737,1738,1739,1740,&', '0:0:0:0:0:0:0:1', '2018-11-18 14:15:37');
INSERT INTO `sys_log` VALUES (1209, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.PerformerController,[方法]:delete,[参数]:ids=1749,1750,1748,1746,1747,1741,1742,1743,1744,1745,1736,1737,1738,1739,1740,&', '0:0:0:0:0:0:0:1', '2018-11-18 14:15:49');
INSERT INTO `sys_log` VALUES (1210, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=11462&_=1542524001765&', '0:0:0:0:0:0:0:1', '2018-11-18 15:00:56');
INSERT INTO `sys_log` VALUES (1211, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.IndustryController,[方法]:addPage,[参数]:id=3344&_=1542524001766&', '0:0:0:0:0:0:0:1', '2018-11-18 15:01:00');
INSERT INTO `sys_log` VALUES (1212, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.IndustryController,[方法]:editPage,[参数]:id=3343&_=1542524001767&', '0:0:0:0:0:0:0:1', '2018-11-18 15:01:03');
INSERT INTO `sys_log` VALUES (1213, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1542524478409&', '0:0:0:0:0:0:0:1', '2018-11-18 15:01:46');
INSERT INTO `sys_log` VALUES (1214, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:delete,[参数]:id=2&', '0:0:0:0:0:0:0:1', '2018-11-18 15:01:58');
INSERT INTO `sys_log` VALUES (1215, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=1&_=1542524478410&', '0:0:0:0:0:0:0:1', '2018-11-18 15:02:01');
INSERT INTO `sys_log` VALUES (1216, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-11-18 15:02:24');
INSERT INTO `sys_log` VALUES (1217, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:addPage,[参数]:', NULL, '2018-11-18 15:02:39');
INSERT INTO `sys_log` VALUES (1218, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:add,[参数]:name=主管&seq=0&status=0&description=超级管理员&', '0:0:0:0:0:0:0:1', '2018-11-18 15:02:58');
INSERT INTO `sys_log` VALUES (1219, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=3&_=1542524548897&', '0:0:0:0:0:0:0:1', '2018-11-18 15:03:00');
INSERT INTO `sys_log` VALUES (1220, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grant,[参数]:id=3&resourceIds=226,234,233,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,1,11,111,112,113,114,12,121,122,123,124,125,13,131,132,133,134,14,141,142,143,144,229,221,227,228&', '0:0:0:0:0:0:0:1', '2018-11-18 15:04:12');
INSERT INTO `sys_log` VALUES (1221, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=1&_=1542524548899&', '0:0:0:0:0:0:0:1', '2018-11-18 15:04:25');
INSERT INTO `sys_log` VALUES (1222, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.UserController,[方法]:edit,[参数]:id=1&loginName=admin&name=admin&password=&sex=0&age=25&userType=0&organizationId=1&roleIds=1&phone=18707173376&status=0&', '0:0:0:0:0:0:0:1', '2018-11-18 15:04:31');
INSERT INTO `sys_log` VALUES (1223, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=16&_=1542524548900&', '0:0:0:0:0:0:0:1', '2018-11-18 15:04:36');
INSERT INTO `sys_log` VALUES (1224, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.UserController,[方法]:edit,[参数]:id=16&loginName=LZT1&name=骆长涛&password=&sex=0&age=30&userType=0&organizationId=4446&roleIds=1&phone=&status=0&', '0:0:0:0:0:0:0:1', '2018-11-18 15:04:40');
INSERT INTO `sys_log` VALUES (1225, 'LZT1', 'LZT1', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-11-18 15:04:49');
INSERT INTO `sys_log` VALUES (1226, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.EditorController,[方法]:delete,[参数]:ids=2764,2760,&', '0:0:0:0:0:0:0:1', '2018-11-18 15:21:51');
INSERT INTO `sys_log` VALUES (1227, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1542527981359&', '0:0:0:0:0:0:0:1', '2018-11-18 16:10:08');
INSERT INTO `sys_log` VALUES (1228, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=233&_=1542527981364&', '0:0:0:0:0:0:0:1', '2018-11-18 16:12:54');
INSERT INTO `sys_log` VALUES (1229, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=233&name=每日消耗&resourceType=0&url=/videoCost/manager&openMode=ajax&icon=glyphicon-cd icon-red&seq=0&status=0&opened=1&pid=234&', '0:0:0:0:0:0:0:1', '2018-11-18 16:13:14');
INSERT INTO `sys_log` VALUES (1230, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=234&_=1542527981366&', '0:0:0:0:0:0:0:1', '2018-11-18 16:13:20');
INSERT INTO `sys_log` VALUES (1231, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=234&name=成片消耗&resourceType=0&url=&openMode=&icon=glyphicon-tint icon-red&seq=0&status=0&opened=1&pid=&', '0:0:0:0:0:0:0:1', '2018-11-18 16:13:32');
INSERT INTO `sys_log` VALUES (1232, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=2409&_=1542550869397&', '0:0:0:0:0:0:0:1', '2018-11-18 22:30:27');
INSERT INTO `sys_log` VALUES (1233, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542550869398&', '0:0:0:0:0:0:0:1', '2018-11-18 22:30:37');
INSERT INTO `sys_log` VALUES (1234, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=2045&_=1542550869399&', '0:0:0:0:0:0:0:1', '2018-11-18 22:30:41');
INSERT INTO `sys_log` VALUES (1235, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=2045&_=1542550869400&', '0:0:0:0:0:0:0:1', '2018-11-18 22:31:15');
INSERT INTO `sys_log` VALUES (1236, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=1447&_=1542550869401&', '0:0:0:0:0:0:0:1', '2018-11-18 22:31:20');
INSERT INTO `sys_log` VALUES (1237, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=3&_=1542609191530&', '0:0:0:0:0:0:0:1', '2018-11-19 14:33:52');
INSERT INTO `sys_log` VALUES (1238, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:delete,[参数]:id=16&', '0:0:0:0:0:0:0:1', '2018-11-19 14:34:10');
INSERT INTO `sys_log` VALUES (1239, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:addPage,[参数]:', NULL, '2018-11-19 14:34:12');
INSERT INTO `sys_log` VALUES (1240, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.UserController,[方法]:add,[参数]:loginName=CQCQ&name=编辑&password=test&sex=0&age=&userType=1&organizationId=1&roleIds=3&phone=&status=0&', '0:0:0:0:0:0:0:1', '2018-11-19 14:34:55');
INSERT INTO `sys_log` VALUES (1241, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-11-19 14:34:59');
INSERT INTO `sys_log` VALUES (1242, 'CQCQ', 'CQCQ', '[类名]:cn.dovahkiin.controller.RoleController,[方法]:grantPage,[参数]:id=3&_=1542609306296&', '0:0:0:0:0:0:0:1', '2018-11-19 14:35:22');
INSERT INTO `sys_log` VALUES (1243, 'CQCQ', 'CQCQ', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=17&_=1542609306298&', '0:0:0:0:0:0:0:1', '2018-11-19 14:35:48');
INSERT INTO `sys_log` VALUES (1244, 'CQCQ', 'CQCQ', '[类名]:cn.dovahkiin.controller.UserController,[方法]:editPage,[参数]:id=17&_=1542609306300&', '0:0:0:0:0:0:0:1', '2018-11-19 14:36:09');
INSERT INTO `sys_log` VALUES (1245, 'CQCQ', 'CQCQ', '[类名]:cn.dovahkiin.controller.LoginController,[方法]:logout,[参数]:', NULL, '2018-11-19 14:36:17');
INSERT INTO `sys_log` VALUES (1246, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=245&_=1542609384525&', '0:0:0:0:0:0:0:1', '2018-11-19 14:37:52');
INSERT INTO `sys_log` VALUES (1247, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=245&_=1542609384526&', '0:0:0:0:0:0:0:1', '2018-11-19 14:38:12');
INSERT INTO `sys_log` VALUES (1248, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=245&name=编辑&resourceType=1&url=/customer/edit&openMode=ajax&icon=glyphicon-pencil icon-green&seq=2&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-19 14:38:35');
INSERT INTO `sys_log` VALUES (1249, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=246&_=1542609384527&', '0:0:0:0:0:0:0:1', '2018-11-19 14:38:39');
INSERT INTO `sys_log` VALUES (1250, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=246&name=删除&resourceType=1&url=/customer/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=242&', '0:0:0:0:0:0:0:1', '2018-11-19 14:38:53');
INSERT INTO `sys_log` VALUES (1251, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:editPage,[参数]:id=261&_=1542609384528&', '0:0:0:0:0:0:0:1', '2018-11-19 14:39:06');
INSERT INTO `sys_log` VALUES (1252, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.ResourceController,[方法]:edit,[参数]:id=261&name=删除&resourceType=1&url=/optimizer/delete&openMode=ajax&icon=glyphicon-trash icon-red&seq=3&status=0&opened=1&pid=257&', '0:0:0:0:0:0:0:1', '2018-11-19 14:39:14');
INSERT INTO `sys_log` VALUES (1253, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542611062638&', '0:0:0:0:0:0:0:1', '2018-11-19 15:04:58');
INSERT INTO `sys_log` VALUES (1254, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542611062639&', '0:0:0:0:0:0:0:1', '2018-11-19 15:05:13');
INSERT INTO `sys_log` VALUES (1255, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=18501&_=1542611062640&', '0:0:0:0:0:0:0:1', '2018-11-19 15:05:23');
INSERT INTO `sys_log` VALUES (1256, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=18511&_=1542611062641&', '0:0:0:0:0:0:0:1', '2018-11-19 15:05:29');
INSERT INTO `sys_log` VALUES (1257, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542611062642&', '0:0:0:0:0:0:0:1', '2018-11-19 15:05:33');
INSERT INTO `sys_log` VALUES (1258, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=18500&_=1542612273143&', '0:0:0:0:0:0:0:1', '2018-11-19 15:24:39');
INSERT INTO `sys_log` VALUES (1259, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=18511&_=1542612609075&', '0:0:0:0:0:0:0:1', '2018-11-19 15:30:14');
INSERT INTO `sys_log` VALUES (1260, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542631570001&', '0:0:0:0:0:0:0:1', '2018-11-19 20:52:22');
INSERT INTO `sys_log` VALUES (1261, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542631570002&', '0:0:0:0:0:0:0:1', '2018-11-19 20:56:57');
INSERT INTO `sys_log` VALUES (1262, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542689429219&', '0:0:0:0:0:0:0:1', '2018-11-20 12:50:38');
INSERT INTO `sys_log` VALUES (1263, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542898388102&', '0:0:0:0:0:0:0:1', '2018-11-22 22:55:12');
INSERT INTO `sys_log` VALUES (1264, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.OptimizerController,[方法]:addPage,[参数]:id=&_=1542979390249&', '0:0:0:0:0:0:0:1', '2018-11-23 21:26:28');
INSERT INTO `sys_log` VALUES (1265, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542979390252&', '0:0:0:0:0:0:0:1', '2018-11-23 21:36:08');
INSERT INTO `sys_log` VALUES (1266, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542979390254&', '0:0:0:0:0:0:0:1', '2018-11-23 21:37:16');
INSERT INTO `sys_log` VALUES (1267, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542979390255&', '0:0:0:0:0:0:0:1', '2018-11-23 21:37:41');
INSERT INTO `sys_log` VALUES (1268, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542979390256&', '0:0:0:0:0:0:0:1', '2018-11-23 21:37:45');
INSERT INTO `sys_log` VALUES (1269, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15324&_=1542979390257&', '0:0:0:0:0:0:0:1', '2018-11-23 21:38:20');
INSERT INTO `sys_log` VALUES (1270, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15324&_=1542979390258&', '0:0:0:0:0:0:0:1', '2018-11-23 21:41:14');
INSERT INTO `sys_log` VALUES (1271, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542979390259&', '0:0:0:0:0:0:0:1', '2018-11-23 22:17:45');
INSERT INTO `sys_log` VALUES (1272, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542979390260&', '0:0:0:0:0:0:0:1', '2018-11-23 22:18:09');
INSERT INTO `sys_log` VALUES (1273, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542979390261&', '0:0:0:0:0:0:0:1', '2018-11-23 22:18:42');
INSERT INTO `sys_log` VALUES (1274, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542979390262&', '0:0:0:0:0:0:0:1', '2018-11-23 22:18:50');
INSERT INTO `sys_log` VALUES (1275, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1542979390263&', '0:0:0:0:0:0:0:1', '2018-11-23 22:18:53');
INSERT INTO `sys_log` VALUES (1276, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542989695082&', '0:0:0:0:0:0:0:1', '2018-11-24 00:15:01');
INSERT INTO `sys_log` VALUES (1277, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542989695083&', '0:0:0:0:0:0:0:1', '2018-11-24 00:17:52');
INSERT INTO `sys_log` VALUES (1278, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542989695084&', '0:0:0:0:0:0:0:1', '2018-11-24 00:19:07');
INSERT INTO `sys_log` VALUES (1279, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1542989695086&', '0:0:0:0:0:0:0:1', '2018-11-24 00:20:12');
INSERT INTO `sys_log` VALUES (1280, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:add,[参数]:id=&code=CUSTOM20&name=大疆&productType.id=2246&industry.id=7084&videoType.id=3845&completeDate=2018-11-24&originality.id=4879&photographer.id=3618&editor.id=3057&performer1.id=1992&performer2.id=1992&performer3.id=1993&', '0:0:0:0:0:0:0:1', '2018-11-24 00:21:04');
INSERT INTO `sys_log` VALUES (1281, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1543024569333&', '0:0:0:0:0:0:0:1', '2018-11-24 10:03:47');
INSERT INTO `sys_log` VALUES (1282, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26740&_=1543024569334&', '0:0:0:0:0:0:0:1', '2018-11-24 10:04:25');
INSERT INTO `sys_log` VALUES (1283, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=25739&_=1543027299103&', '0:0:0:0:0:0:0:1', '2018-11-24 10:41:47');
INSERT INTO `sys_log` VALUES (1284, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=25739&_=1543027299104&', '0:0:0:0:0:0:0:1', '2018-11-24 10:41:52');
INSERT INTO `sys_log` VALUES (1285, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=25714&_=1543027299105&', '0:0:0:0:0:0:0:1', '2018-11-24 10:41:58');
INSERT INTO `sys_log` VALUES (1286, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=25739&_=1543027299106&', '0:0:0:0:0:0:0:1', '2018-11-24 10:43:40');
INSERT INTO `sys_log` VALUES (1287, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=25739&_=1543027299107&', '0:0:0:0:0:0:0:1', '2018-11-24 10:43:54');
INSERT INTO `sys_log` VALUES (1288, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=25739&code=CUS201811222334545116123997&name=趣头条-吃东西对比横版&productType.id=2249&industry.id=7084&videoType.id=3847&completeDate=2018-11-24&originality.id=4900&photographer.id=3624&editor.id=3064&performer1.id=1992&performer2.id=1996&performer3.id=1992&', '0:0:0:0:0:0:0:1', '2018-11-24 10:43:58');
INSERT INTO `sys_log` VALUES (1289, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=25739&_=1543027299108&', '0:0:0:0:0:0:0:1', '2018-11-24 10:44:02');
INSERT INTO `sys_log` VALUES (1290, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26280&_=1543027299109&', '0:0:0:0:0:0:0:1', '2018-11-24 10:44:14');
INSERT INTO `sys_log` VALUES (1291, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26280&_=1543027299110&', '0:0:0:0:0:0:0:1', '2018-11-24 10:44:44');
INSERT INTO `sys_log` VALUES (1292, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26280&code=CUS20181122233525108038598&name=趣头条-三人采访横版&productType.id=&industry.id=7084&videoType.id=3847&completeDate=2018-11-24&originality.id=4898&photographer.id=3625&editor.id=3064&performer1.id=2001&performer2.id=1992&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 10:44:47');
INSERT INTO `sys_log` VALUES (1293, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=25723&_=1543027709683&', '0:0:0:0:0:0:0:1', '2018-11-24 10:48:48');
INSERT INTO `sys_log` VALUES (1294, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26280&_=1543027709684&', '0:0:0:0:0:0:0:1', '2018-11-24 10:48:56');
INSERT INTO `sys_log` VALUES (1295, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26280&code=CUS20181122233525108038598&name=趣头条-三人采访横版&productType.id=&industry.id=7084&videoType.id=3847&completeDate=2018-11-24&originality.id=4898&photographer.id=3625&editor.id=3064&performer1.id=2001&performer2.id=1992&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 10:49:04');
INSERT INTO `sys_log` VALUES (1296, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26280&_=1543027709685&', '0:0:0:0:0:0:0:1', '2018-11-24 10:49:47');
INSERT INTO `sys_log` VALUES (1297, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26280&code=CUS20181122233525108038598&name=趣头条-三人采访横版&productType.id=2246&industry.id=7084&videoType.id=3847&completeDate=2018-11-24&originality.id=4898&photographer.id=3625&editor.id=3064&performer1.id=2001&performer2.id=1992&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 10:50:32');
INSERT INTO `sys_log` VALUES (1298, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26280&_=1543027709686&', '0:0:0:0:0:0:0:1', '2018-11-24 10:50:54');
INSERT INTO `sys_log` VALUES (1299, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26280&code=CUS20181122233525108038598&name=趣头条-三人采访横版&productType.id=&industry.id=7084&videoType.id=3847&completeDate=2018-11-24&originality.id=4898&photographer.id=3625&editor.id=3064&performer1.id=2001&performer2.id=1992&performer3.id=1997&', '0:0:0:0:0:0:0:1', '2018-11-24 10:51:00');
INSERT INTO `sys_log` VALUES (1300, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=26329&_=1543030437443&', '0:0:0:0:0:0:0:1', '2018-11-24 11:34:06');
INSERT INTO `sys_log` VALUES (1301, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=26639&_=1543030437444&', '0:0:0:0:0:0:0:1', '2018-11-24 11:34:14');
INSERT INTO `sys_log` VALUES (1302, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26740&_=1543030437445&', '0:0:0:0:0:0:0:1', '2018-11-24 11:34:21');
INSERT INTO `sys_log` VALUES (1303, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26740&code=CUSTOM20&name=大疆&productType.id=2246&industry.id=7084&videoType.id=3845&completeDate=2018-11-24&originality.id=4879&photographer.id=3618&editor.id=3057&performer1.id=1992&performer2.id=1992&performer3.id=1992&', '0:0:0:0:0:0:0:1', '2018-11-24 11:34:29');
INSERT INTO `sys_log` VALUES (1304, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26740&_=1543030437446&', '0:0:0:0:0:0:0:1', '2018-11-24 11:34:39');
INSERT INTO `sys_log` VALUES (1305, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26740&code=CUSTOM20&name=大疆&productType.id=2246&industry.id=7084&videoType.id=3845&completeDate=2018-11-24&originality.id=4879&photographer.id=3618&editor.id=3057&performer1.id=1992&performer2.id=1992&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 11:34:45');
INSERT INTO `sys_log` VALUES (1306, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26740&_=1543030437447&', '0:0:0:0:0:0:0:1', '2018-11-24 11:34:55');
INSERT INTO `sys_log` VALUES (1307, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26740&code=CUSTOM20&name=大疆&productType.id=2246&industry.id=7084&videoType.id=3845&completeDate=2018-11-24&originality.id=4879&photographer.id=3618&editor.id=3057&performer1.id=1992&performer2.id=1992&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 11:35:06');
INSERT INTO `sys_log` VALUES (1308, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26740&_=1543030437448&', '0:0:0:0:0:0:0:1', '2018-11-24 11:35:11');
INSERT INTO `sys_log` VALUES (1309, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1543030437449&', '0:0:0:0:0:0:0:1', '2018-11-24 11:35:52');
INSERT INTO `sys_log` VALUES (1310, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:add,[参数]:id=&code=CUSTOM203&name=删除&productType.id=2246&industry.id=7087&videoType.id=3846&completeDate=2018-11-24&originality.id=4879&photographer.id=3617&editor.id=3058&performer1.id=1992&performer2.id=2000&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 11:36:24');
INSERT INTO `sys_log` VALUES (1311, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26741&_=1543030437450&', '0:0:0:0:0:0:0:1', '2018-11-24 11:36:31');
INSERT INTO `sys_log` VALUES (1312, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26741&code=CUSTOM203&name=删除&productType.id=2246&industry.id=7087&videoType.id=3846&completeDate=2018-11-24&originality.id=4879&photographer.id=3617&editor.id=3058&performer1.id=1992&performer2.id=2000&performer3.id=2001&', '0:0:0:0:0:0:0:1', '2018-11-24 11:36:39');
INSERT INTO `sys_log` VALUES (1313, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26741&_=1543030437451&', '0:0:0:0:0:0:0:1', '2018-11-24 11:38:32');
INSERT INTO `sys_log` VALUES (1314, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26741&code=CUSTOM203A&name=删除A&productType.id=2246&industry.id=7087&videoType.id=3846&completeDate=2018-11-24&originality.id=4879&photographer.id=3617&editor.id=3058&performer1.id=1992&performer2.id=2000&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 11:38:37');
INSERT INTO `sys_log` VALUES (1315, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26741&_=1543030437452&', '0:0:0:0:0:0:0:1', '2018-11-24 11:40:05');
INSERT INTO `sys_log` VALUES (1316, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26741&code=CUSTOM203&name=删除a&productType.id=2246&industry.id=7087&videoType.id=3846&completeDate=2018-11-24&originality.id=4879&photographer.id=3617&editor.id=3058&performer1.id=1992&performer2.id=2000&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 11:40:09');
INSERT INTO `sys_log` VALUES (1317, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26741&_=1543030894000&', '0:0:0:0:0:0:0:1', '2018-11-24 11:41:46');
INSERT INTO `sys_log` VALUES (1318, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26741&code=CUSTOM203&name=删除A&productType.id=2246&industry.id=7087&videoType.id=3846&completeDate=2018-11-24&originality.id=4879&photographer.id=3617&editor.id=3058&performer1.id=1992&performer2.id=2000&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 11:41:52');
INSERT INTO `sys_log` VALUES (1319, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26741&_=1543030894001&', '0:0:0:0:0:0:0:1', '2018-11-24 11:42:59');
INSERT INTO `sys_log` VALUES (1320, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26741&code=CUSTOM203A&name=删除&productType.id=2246&industry.id=7087&videoType.id=3846&completeDate=2018-11-24&originality.id=4879&photographer.id=3617&editor.id=3058&performer1.id=1992&performer2.id=2000&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 11:43:04');
INSERT INTO `sys_log` VALUES (1321, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26741&_=1543030894002&', '0:0:0:0:0:0:0:1', '2018-11-24 11:43:46');
INSERT INTO `sys_log` VALUES (1322, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26741&code=CUSTOM203啊&name=删除啊&productType.id=2246&industry.id=7087&videoType.id=3846&completeDate=2018-11-24&originality.id=4879&photographer.id=3617&editor.id=3058&performer1.id=1992&performer2.id=2000&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 11:43:52');
INSERT INTO `sys_log` VALUES (1323, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26741&_=1543032054771&', '0:0:0:0:0:0:0:1', '2018-11-24 12:01:08');
INSERT INTO `sys_log` VALUES (1324, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26741&code=CUSTOM203A&name=删除A&productType.id=2246&industry.id=7087&videoType.id=3846&completeDate=2018-11-24&originality.id=4879&photographer.id=3617&editor.id=3058&performer1.id=1992&performer2.id=2000&performer3.id=1991&', '0:0:0:0:0:0:0:1', '2018-11-24 12:01:16');
INSERT INTO `sys_log` VALUES (1325, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26741&_=1543032054772&', '0:0:0:0:0:0:0:1', '2018-11-24 12:01:21');
INSERT INTO `sys_log` VALUES (1326, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26741&code=CUSTOM203A&name=删除A&productType.id=2248&industry.id=7084&videoType.id=3845&completeDate=2018-11-23&originality.id=4877&photographer.id=3617&editor.id=3056&performer1.id=2004&performer2.id=2003&performer3.id=1996&', '0:0:0:0:0:0:0:1', '2018-11-24 12:01:51');
INSERT INTO `sys_log` VALUES (1327, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:delete,[参数]:ids=26741,26740,26281,26280,26639,26638,26217,26296,26375,26454,26004,26083,26466,26545,26624,26703,26221,26300,26379,25929,&', '0:0:0:0:0:0:0:1', '2018-11-24 12:02:08');
INSERT INTO `sys_log` VALUES (1328, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:delete,[参数]:ids=26741,26281,26740,26280,26638,26639,26217,26296,26454,26379,26624,26083,26375,26545,26703,26004,26221,26300,26466,25929,&', '0:0:0:0:0:0:0:1', '2018-11-24 12:02:19');
INSERT INTO `sys_log` VALUES (1329, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:delete,[参数]:ids=26741,&', '0:0:0:0:0:0:0:1', '2018-11-24 12:02:38');
INSERT INTO `sys_log` VALUES (1330, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15319&_=1543032054774&', '0:0:0:0:0:0:0:1', '2018-11-24 12:04:57');
INSERT INTO `sys_log` VALUES (1331, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15319&_=1543032054775&', '0:0:0:0:0:0:0:1', '2018-11-24 12:27:18');
INSERT INTO `sys_log` VALUES (1332, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15319&_=1543032054776&', '0:0:0:0:0:0:0:1', '2018-11-24 12:33:28');
INSERT INTO `sys_log` VALUES (1333, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=25739&_=1543032054779&', '0:0:0:0:0:0:0:1', '2018-11-24 12:34:19');
INSERT INTO `sys_log` VALUES (1334, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543032054780&', '0:0:0:0:0:0:0:1', '2018-11-24 12:34:58');
INSERT INTO `sys_log` VALUES (1335, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15327&_=1543032054782&', '0:0:0:0:0:0:0:1', '2018-11-24 12:35:12');
INSERT INTO `sys_log` VALUES (1336, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15327&_=1543032054783&', '0:0:0:0:0:0:0:1', '2018-11-24 12:47:58');
INSERT INTO `sys_log` VALUES (1337, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15327&_=1543032054784&', '0:0:0:0:0:0:0:1', '2018-11-24 12:58:44');
INSERT INTO `sys_log` VALUES (1338, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15327&_=1543032054785&', '0:0:0:0:0:0:0:1', '2018-11-24 13:01:38');
INSERT INTO `sys_log` VALUES (1339, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15327&_=1543032054786&', '0:0:0:0:0:0:0:1', '2018-11-24 13:02:48');
INSERT INTO `sys_log` VALUES (1340, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15327&_=1543032054787&', '0:0:0:0:0:0:0:1', '2018-11-24 13:10:58');
INSERT INTO `sys_log` VALUES (1341, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15327&_=1543032054788&', '0:0:0:0:0:0:0:1', '2018-11-24 13:11:36');
INSERT INTO `sys_log` VALUES (1342, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=15327&_=1543032054789&', '0:0:0:0:0:0:0:1', '2018-11-24 13:26:04');
INSERT INTO `sys_log` VALUES (1343, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:editPage,[参数]:id=26741&_=1543032054791&', '0:0:0:0:0:0:0:1', '2018-11-24 13:27:54');
INSERT INTO `sys_log` VALUES (1344, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:edit,[参数]:id=26741&code=CUSTOM203A&name=删除A&productType.id=2248&industry.id=7084&videoType.id=3845&completeDate=&originality.id=4877&photographer.id=3617&editor.id=3056&performer1.id=2004&performer2.id=2003&performer3.id=1996&', '0:0:0:0:0:0:0:1', '2018-11-24 13:27:59');
INSERT INTO `sys_log` VALUES (1345, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15327&_=1543032054792&', '0:0:0:0:0:0:0:1', '2018-11-24 13:28:05');
INSERT INTO `sys_log` VALUES (1346, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543037301726&', '0:0:0:0:0:0:0:1', '2018-11-24 13:28:25');
INSERT INTO `sys_log` VALUES (1347, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543037301728&', '0:0:0:0:0:0:0:1', '2018-11-24 13:28:48');
INSERT INTO `sys_log` VALUES (1348, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543037301729&', '0:0:0:0:0:0:0:1', '2018-11-24 13:31:14');
INSERT INTO `sys_log` VALUES (1349, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543037301730&', '0:0:0:0:0:0:0:1', '2018-11-24 13:31:46');
INSERT INTO `sys_log` VALUES (1350, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543037301731&', '0:0:0:0:0:0:0:1', '2018-11-24 13:32:11');
INSERT INTO `sys_log` VALUES (1351, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543037301732&', '0:0:0:0:0:0:0:1', '2018-11-24 13:32:28');
INSERT INTO `sys_log` VALUES (1352, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=25739&_=1543039610290&', '0:0:0:0:0:0:0:1', '2018-11-24 14:07:04');
INSERT INTO `sys_log` VALUES (1353, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15319&_=1543039610292&', '0:0:0:0:0:0:0:1', '2018-11-24 14:07:13');
INSERT INTO `sys_log` VALUES (1354, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15319&_=1543039610293&', '0:0:0:0:0:0:0:1', '2018-11-24 14:10:38');
INSERT INTO `sys_log` VALUES (1355, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543039610294&', '0:0:0:0:0:0:0:1', '2018-11-24 14:11:18');
INSERT INTO `sys_log` VALUES (1356, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543039610295&', '0:0:0:0:0:0:0:1', '2018-11-24 14:12:25');
INSERT INTO `sys_log` VALUES (1357, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543039610296&', '0:0:0:0:0:0:0:1', '2018-11-24 14:14:48');
INSERT INTO `sys_log` VALUES (1358, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543040322765&', '0:0:0:0:0:0:0:1', '2018-11-24 14:18:56');
INSERT INTO `sys_log` VALUES (1359, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543040322766&', '0:0:0:0:0:0:0:1', '2018-11-24 14:21:40');
INSERT INTO `sys_log` VALUES (1360, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543040322768&', '0:0:0:0:0:0:0:1', '2018-11-24 14:22:12');
INSERT INTO `sys_log` VALUES (1361, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:editPage,[参数]:id=15319&_=1543040322769&', '0:0:0:0:0:0:0:1', '2018-11-24 14:22:31');
INSERT INTO `sys_log` VALUES (1362, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1543040322771&', '0:0:0:0:0:0:0:1', '2018-11-24 14:23:04');
INSERT INTO `sys_log` VALUES (1363, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15319&_=1543040322773&', '0:0:0:0:0:0:0:1', '2018-11-24 14:23:11');
INSERT INTO `sys_log` VALUES (1364, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=15321&_=1543040322774&', '0:0:0:0:0:0:0:1', '2018-11-24 14:23:49');
INSERT INTO `sys_log` VALUES (1365, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.VideoCostController,[方法]:addPage,[参数]:id=&_=1543050368998&', '0:0:0:0:0:0:0:1', '2018-11-24 17:07:06');
INSERT INTO `sys_log` VALUES (1366, 'admin', 'admin', '[类名]:cn.dovahkiin.controller.CustomerController,[方法]:addPage,[参数]:id=&_=1543050369000&', '0:0:0:0:0:0:0:1', '2018-11-24 17:07:28');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `login_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登陆名',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `salt` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码加密盐',
  `sex` tinyint(2) NOT NULL DEFAULT 0 COMMENT '性别',
  `age` tinyint(2) NULL DEFAULT 0 COMMENT '年龄',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `user_type` tinyint(2) NOT NULL DEFAULT 0 COMMENT '用户类别',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '用户状态',
  `organization_id` int(11) NOT NULL DEFAULT 0 COMMENT '所属机构',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `IDx_user_login_name`(`login_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'admin', '05a671c66aefea124cc08b76ea6d30bb', 'test', 0, 25, '18707173376', 0, 0, 1, '2015-12-06 13:14:05');
INSERT INTO `user` VALUES (15, 'test', 'test', '05a671c66aefea124cc08b76ea6d30bb', 'test', 0, 25, '18707173376', 1, 0, 6, '2015-12-06 13:13:03');
INSERT INTO `user` VALUES (17, 'CQCQ', '编辑', 'efca8087f2d6d15ceddc156c428521a1', '7354c43b-4a7e-4150-99f1-63a7e1a7e074', 0, 0, '', 1, 0, 1, '2018-11-19 14:34:55');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` bigint(19) NOT NULL COMMENT '用户id',
  `role_id` bigint(19) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_role_ids`(`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (70, 1, 1);
INSERT INTO `user_role` VALUES (71, 1, 3);
INSERT INTO `user_role` VALUES (68, 15, 2);
INSERT INTO `user_role` VALUES (74, 17, 3);

-- ----------------------------
-- Table structure for video_cost
-- ----------------------------
DROP TABLE IF EXISTS `video_cost`;
CREATE TABLE `video_cost`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  `recored_date` date NOT NULL COMMENT '日期',
  `business_department_id` bigint(19) NULL DEFAULT NULL COMMENT '业务部',
  `product_type_id` bigint(19) NULL DEFAULT NULL COMMENT '产品类型ID',
  `customer_id` bigint(19) NOT NULL COMMENT '客户ID',
  `industry_id` bigint(19) NULL DEFAULT NULL COMMENT '行业',
  `demand_sector_id` bigint(19) NULL DEFAULT NULL COMMENT '需求部门',
  `optimizer_id` bigint(19) NULL DEFAULT NULL COMMENT '优化师ID',
  `video_type_id` bigint(19) NULL DEFAULT NULL COMMENT '视频类型ID',
  `complete_date` date NULL DEFAULT NULL COMMENT '成片日期',
  `originality_id` bigint(19) NULL DEFAULT NULL COMMENT '创意',
  `photographer_id` bigint(19) NULL DEFAULT NULL COMMENT '摄像',
  `editor_id` bigint(19) NULL DEFAULT NULL COMMENT '剪辑',
  `performer1_id` bigint(19) NULL DEFAULT NULL COMMENT '演员1',
  `performer2_id` bigint(19) NULL DEFAULT NULL COMMENT '演员2',
  `performer3_id` bigint(19) NULL DEFAULT NULL COMMENT '演员3',
  `consumption` double NULL DEFAULT 0 COMMENT '当日消耗',
  `cumulative_consumption` double NULL DEFAULT 0 COMMENT '累计消耗',
  `cumulative_consumption_ranking` int(11) NULL DEFAULT NULL COMMENT '消耗累积排名',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `video_cost_customer_FK`(`customer_id`) USING BTREE,
  INDEX `video_cost_optimizer_FK`(`optimizer_id`) USING BTREE,
  INDEX `video_cost_originality_FK`(`originality_id`) USING BTREE,
  INDEX `video_cost_photographer_FK`(`photographer_id`) USING BTREE,
  INDEX `video_cost_editor_FK`(`editor_id`) USING BTREE,
  INDEX `video_cost_product_type_FK`(`product_type_id`) USING BTREE,
  INDEX `video_cost_industry_FK`(`industry_id`) USING BTREE,
  INDEX `video_cost_video_type_FK`(`video_type_id`) USING BTREE,
  INDEX `video_cost_organization_FK`(`business_department_id`) USING BTREE,
  INDEX `video_cost_demand_sector_FK`(`demand_sector_id`) USING BTREE,
  CONSTRAINT `video_cost_customer_FK` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_demand_sector_FK` FOREIGN KEY (`demand_sector_id`) REFERENCES `organization` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_editor_FK` FOREIGN KEY (`editor_id`) REFERENCES `editor` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_industry_FK` FOREIGN KEY (`industry_id`) REFERENCES `industry` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_optimizer_FK` FOREIGN KEY (`optimizer_id`) REFERENCES `optimizer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_organization_FK` FOREIGN KEY (`business_department_id`) REFERENCES `organization` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_originality_FK` FOREIGN KEY (`originality_id`) REFERENCES `originality` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_photographer_FK` FOREIGN KEY (`photographer_id`) REFERENCES `photographer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_product_type_FK` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_video_type_FK` FOREIGN KEY (`video_type_id`) REFERENCES `video_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16580 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '视频成片消耗' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for video_type
-- ----------------------------
DROP TABLE IF EXISTS `video_type`;
CREATE TABLE `video_type`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品类型名称',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品类型编码',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3864 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品类型信息' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
