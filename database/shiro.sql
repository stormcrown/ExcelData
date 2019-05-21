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

 Date: 21/05/2019 10:34:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 为方便按日期查询数据，因此建立日期表，
/*数字表 */
CREATE TABLE  IF NOT EXISTS num(i INT);
CREATE TABLE num (i INT);
INSERT INTO num (i) VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);
COMMIT ;
/* 日期表 **/
CREATE TABLE  IF NOT EXISTS calendar(datelist DATE);
INSERT INTO calendar(datelist) SELECT
    ADDDATE(
        (   -- 这里的起始日期，你可以换成当前日期
            DATE_FORMAT("2015-1-1", '%Y-%m-%d')
        ),
        numlist.id
    ) AS `date`
FROM
    (
        SELECT
            n1.i + n10.i * 10 + n100.i * 100 + n1000.i * 1000+ n10000.i * 10000 AS id
        FROM
            num n1
        CROSS JOIN num AS n10
        CROSS JOIN num AS n100
        CROSS JOIN num AS n1000
        CROSS JOIN num AS n10000
    ) AS numlist;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户名',
  `true_customer_id` bigint(20) NULL DEFAULT NULL,
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
  UNIQUE INDEX `uniqueCode`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42086 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户信息' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 3315 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '剪辑师信息' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 7370 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '行业信息' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 5746 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '优化师信息' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组织机构' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 6047 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '创意师信息' ROW_FORMAT = Dynamic;


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
) ENGINE = InnoDB AUTO_INCREMENT = 2742 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '演员信息' ROW_FORMAT = Dynamic;


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
) ENGINE = InnoDB AUTO_INCREMENT = 4320 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '摄像师信息' ROW_FORMAT = Dynamic;


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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品类型信息' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 294 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资源' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES (1, '权限管理', '', '', '系统管理', 'glyphicon-list icon-purple', NULL, 1, 0, 0, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (11, '菜单管理', '/resource/manager', 'ajax', '资源管理', 'glyphicon-th ', 1, 1, 0, 1, 0, '2014-02-19 01:00:00');
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
INSERT INTO `resource` VALUES (241, '数据字典', '', '', NULL, 'glyphicon-book icon-blue', NULL, 0, 0, 0, 0, '2018-11-18 00:35:04');
INSERT INTO `resource` VALUES (242, '素材', '/customer/manager', 'ajax', NULL, 'glyphicon-user icon-green', 241, 0, 0, 1, 0, '2018-11-18 00:36:17');
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
INSERT INTO `resource` VALUES (287, '客户', '/trueCustomer/manager', '', NULL, 'glyphicon-user icon-blue', 241, 1, 0, 1, 0, '2018-11-29 17:58:46');
INSERT INTO `resource` VALUES (288, '列表', '/trueCustomer/dataGrid', 'ajax', NULL, 'glyphicon-list icon-blue', 287, 0, 0, 1, 1, '2018-11-29 18:00:10');
INSERT INTO `resource` VALUES (289, '添加', '/trueCustomer/add', 'ajax', NULL, 'glyphicon-plus icon-green', 287, 1, 0, 1, 1, '2018-11-29 18:00:50');
INSERT INTO `resource` VALUES (290, '编辑', '/trueCustomer/edit', 'ajax', NULL, 'glyphicon-pencil icon-purple', 287, 2, 0, 1, 1, '2018-11-29 18:01:18');
INSERT INTO `resource` VALUES (291, '删除', '/trueCustomer/delete', 'ajax', NULL, 'glyphicon-trash icon-red', 287, 0, 0, 1, 1, '2018-11-29 18:02:03');
INSERT INTO `resource` VALUES (292, '统计图表', '', NULL, NULL, 'glyphicon-picture icon-yellow', NULL, 0, 0, 1, 0, '2018-12-01 10:56:39');
INSERT INTO `resource` VALUES (293, '柱形图', '/count/bar', '', NULL, 'glyphicon-list icon-green', 292, 0, 0, 1, 0, '2018-12-01 11:00:01');

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
INSERT INTO `role` VALUES (1, 'adminll', 1, '超级管', 0);
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
) ENGINE = InnoDB AUTO_INCREMENT = 1448 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色资源' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_resource
-- ----------------------------
INSERT INTO `role_resource` VALUES (1422, 1, 1);
INSERT INTO `role_resource` VALUES (1423, 1, 11);
INSERT INTO `role_resource` VALUES (1428, 1, 12);
INSERT INTO `role_resource` VALUES (1434, 1, 13);
INSERT INTO `role_resource` VALUES (1439, 1, 14);
INSERT INTO `role_resource` VALUES (1424, 1, 111);
INSERT INTO `role_resource` VALUES (1425, 1, 112);
INSERT INTO `role_resource` VALUES (1426, 1, 113);
INSERT INTO `role_resource` VALUES (1427, 1, 114);
INSERT INTO `role_resource` VALUES (1429, 1, 121);
INSERT INTO `role_resource` VALUES (1430, 1, 122);
INSERT INTO `role_resource` VALUES (1431, 1, 123);
INSERT INTO `role_resource` VALUES (1432, 1, 124);
INSERT INTO `role_resource` VALUES (1433, 1, 125);
INSERT INTO `role_resource` VALUES (1435, 1, 131);
INSERT INTO `role_resource` VALUES (1436, 1, 132);
INSERT INTO `role_resource` VALUES (1437, 1, 133);
INSERT INTO `role_resource` VALUES (1438, 1, 134);
INSERT INTO `role_resource` VALUES (1440, 1, 141);
INSERT INTO `role_resource` VALUES (1441, 1, 142);
INSERT INTO `role_resource` VALUES (1442, 1, 143);
INSERT INTO `role_resource` VALUES (1443, 1, 144);
INSERT INTO `role_resource` VALUES (1445, 1, 221);
INSERT INTO `role_resource` VALUES (1360, 1, 226);
INSERT INTO `role_resource` VALUES (1446, 1, 227);
INSERT INTO `role_resource` VALUES (1447, 1, 228);
INSERT INTO `role_resource` VALUES (1444, 1, 229);
INSERT INTO `role_resource` VALUES (1364, 1, 233);
INSERT INTO `role_resource` VALUES (1363, 1, 234);
INSERT INTO `role_resource` VALUES (1365, 1, 235);
INSERT INTO `role_resource` VALUES (1366, 1, 236);
INSERT INTO `role_resource` VALUES (1367, 1, 237);
INSERT INTO `role_resource` VALUES (1368, 1, 238);
INSERT INTO `role_resource` VALUES (1369, 1, 239);
INSERT INTO `role_resource` VALUES (1370, 1, 240);
INSERT INTO `role_resource` VALUES (1371, 1, 241);
INSERT INTO `role_resource` VALUES (1372, 1, 242);
INSERT INTO `role_resource` VALUES (1373, 1, 243);
INSERT INTO `role_resource` VALUES (1374, 1, 244);
INSERT INTO `role_resource` VALUES (1375, 1, 245);
INSERT INTO `role_resource` VALUES (1376, 1, 246);
INSERT INTO `role_resource` VALUES (1382, 1, 247);
INSERT INTO `role_resource` VALUES (1383, 1, 248);
INSERT INTO `role_resource` VALUES (1384, 1, 249);
INSERT INTO `role_resource` VALUES (1385, 1, 250);
INSERT INTO `role_resource` VALUES (1386, 1, 251);
INSERT INTO `role_resource` VALUES (1387, 1, 252);
INSERT INTO `role_resource` VALUES (1388, 1, 253);
INSERT INTO `role_resource` VALUES (1389, 1, 254);
INSERT INTO `role_resource` VALUES (1390, 1, 255);
INSERT INTO `role_resource` VALUES (1391, 1, 256);
INSERT INTO `role_resource` VALUES (1392, 1, 257);
INSERT INTO `role_resource` VALUES (1393, 1, 258);
INSERT INTO `role_resource` VALUES (1394, 1, 259);
INSERT INTO `role_resource` VALUES (1395, 1, 260);
INSERT INTO `role_resource` VALUES (1396, 1, 261);
INSERT INTO `role_resource` VALUES (1397, 1, 262);
INSERT INTO `role_resource` VALUES (1398, 1, 263);
INSERT INTO `role_resource` VALUES (1399, 1, 264);
INSERT INTO `role_resource` VALUES (1400, 1, 265);
INSERT INTO `role_resource` VALUES (1401, 1, 266);
INSERT INTO `role_resource` VALUES (1402, 1, 267);
INSERT INTO `role_resource` VALUES (1403, 1, 268);
INSERT INTO `role_resource` VALUES (1404, 1, 269);
INSERT INTO `role_resource` VALUES (1405, 1, 270);
INSERT INTO `role_resource` VALUES (1406, 1, 271);
INSERT INTO `role_resource` VALUES (1407, 1, 272);
INSERT INTO `role_resource` VALUES (1408, 1, 273);
INSERT INTO `role_resource` VALUES (1409, 1, 274);
INSERT INTO `role_resource` VALUES (1410, 1, 275);
INSERT INTO `role_resource` VALUES (1411, 1, 276);
INSERT INTO `role_resource` VALUES (1412, 1, 277);
INSERT INTO `role_resource` VALUES (1413, 1, 278);
INSERT INTO `role_resource` VALUES (1414, 1, 279);
INSERT INTO `role_resource` VALUES (1415, 1, 280);
INSERT INTO `role_resource` VALUES (1416, 1, 281);
INSERT INTO `role_resource` VALUES (1417, 1, 282);
INSERT INTO `role_resource` VALUES (1418, 1, 283);
INSERT INTO `role_resource` VALUES (1419, 1, 284);
INSERT INTO `role_resource` VALUES (1420, 1, 285);
INSERT INTO `role_resource` VALUES (1421, 1, 286);
INSERT INTO `role_resource` VALUES (1377, 1, 287);
INSERT INTO `role_resource` VALUES (1378, 1, 288);
INSERT INTO `role_resource` VALUES (1380, 1, 289);
INSERT INTO `role_resource` VALUES (1381, 1, 290);
INSERT INTO `role_resource` VALUES (1379, 1, 291);
INSERT INTO `role_resource` VALUES (1361, 1, 292);
INSERT INTO `role_resource` VALUES (1362, 1, 293);
INSERT INTO `role_resource` VALUES (745, 2, 233);
INSERT INTO `role_resource` VALUES (744, 2, 234);
INSERT INTO `role_resource` VALUES (746, 2, 235);
INSERT INTO `role_resource` VALUES (747, 2, 236);
INSERT INTO `role_resource` VALUES (748, 2, 237);
INSERT INTO `role_resource` VALUES (749, 2, 238);
INSERT INTO `role_resource` VALUES (1334, 3, 1);
INSERT INTO `role_resource` VALUES (1335, 3, 11);
INSERT INTO `role_resource` VALUES (1340, 3, 12);
INSERT INTO `role_resource` VALUES (1346, 3, 13);
INSERT INTO `role_resource` VALUES (1351, 3, 14);
INSERT INTO `role_resource` VALUES (1336, 3, 111);
INSERT INTO `role_resource` VALUES (1337, 3, 112);
INSERT INTO `role_resource` VALUES (1338, 3, 113);
INSERT INTO `role_resource` VALUES (1339, 3, 114);
INSERT INTO `role_resource` VALUES (1341, 3, 121);
INSERT INTO `role_resource` VALUES (1342, 3, 122);
INSERT INTO `role_resource` VALUES (1343, 3, 123);
INSERT INTO `role_resource` VALUES (1344, 3, 124);
INSERT INTO `role_resource` VALUES (1345, 3, 125);
INSERT INTO `role_resource` VALUES (1347, 3, 131);
INSERT INTO `role_resource` VALUES (1348, 3, 132);
INSERT INTO `role_resource` VALUES (1349, 3, 133);
INSERT INTO `role_resource` VALUES (1350, 3, 134);
INSERT INTO `role_resource` VALUES (1352, 3, 141);
INSERT INTO `role_resource` VALUES (1353, 3, 142);
INSERT INTO `role_resource` VALUES (1354, 3, 143);
INSERT INTO `role_resource` VALUES (1355, 3, 144);
INSERT INTO `role_resource` VALUES (1357, 3, 221);
INSERT INTO `role_resource` VALUES (1273, 3, 226);
INSERT INTO `role_resource` VALUES (1358, 3, 227);
INSERT INTO `role_resource` VALUES (1359, 3, 228);
INSERT INTO `role_resource` VALUES (1356, 3, 229);
INSERT INTO `role_resource` VALUES (1277, 3, 233);
INSERT INTO `role_resource` VALUES (1276, 3, 234);
INSERT INTO `role_resource` VALUES (1278, 3, 235);
INSERT INTO `role_resource` VALUES (1279, 3, 236);
INSERT INTO `role_resource` VALUES (1280, 3, 237);
INSERT INTO `role_resource` VALUES (1281, 3, 238);
INSERT INTO `role_resource` VALUES (1282, 3, 239);
INSERT INTO `role_resource` VALUES (1283, 3, 240);
INSERT INTO `role_resource` VALUES (1284, 3, 241);
INSERT INTO `role_resource` VALUES (1285, 3, 242);
INSERT INTO `role_resource` VALUES (1286, 3, 243);
INSERT INTO `role_resource` VALUES (1287, 3, 244);
INSERT INTO `role_resource` VALUES (1288, 3, 245);
INSERT INTO `role_resource` VALUES (1289, 3, 246);
INSERT INTO `role_resource` VALUES (1294, 3, 247);
INSERT INTO `role_resource` VALUES (1295, 3, 248);
INSERT INTO `role_resource` VALUES (1296, 3, 249);
INSERT INTO `role_resource` VALUES (1297, 3, 250);
INSERT INTO `role_resource` VALUES (1298, 3, 251);
INSERT INTO `role_resource` VALUES (1299, 3, 252);
INSERT INTO `role_resource` VALUES (1300, 3, 253);
INSERT INTO `role_resource` VALUES (1301, 3, 254);
INSERT INTO `role_resource` VALUES (1302, 3, 255);
INSERT INTO `role_resource` VALUES (1303, 3, 256);
INSERT INTO `role_resource` VALUES (1304, 3, 257);
INSERT INTO `role_resource` VALUES (1305, 3, 258);
INSERT INTO `role_resource` VALUES (1306, 3, 259);
INSERT INTO `role_resource` VALUES (1307, 3, 260);
INSERT INTO `role_resource` VALUES (1308, 3, 261);
INSERT INTO `role_resource` VALUES (1309, 3, 262);
INSERT INTO `role_resource` VALUES (1310, 3, 263);
INSERT INTO `role_resource` VALUES (1311, 3, 264);
INSERT INTO `role_resource` VALUES (1312, 3, 265);
INSERT INTO `role_resource` VALUES (1313, 3, 266);
INSERT INTO `role_resource` VALUES (1314, 3, 267);
INSERT INTO `role_resource` VALUES (1315, 3, 268);
INSERT INTO `role_resource` VALUES (1316, 3, 269);
INSERT INTO `role_resource` VALUES (1317, 3, 270);
INSERT INTO `role_resource` VALUES (1318, 3, 271);
INSERT INTO `role_resource` VALUES (1319, 3, 272);
INSERT INTO `role_resource` VALUES (1320, 3, 273);
INSERT INTO `role_resource` VALUES (1321, 3, 274);
INSERT INTO `role_resource` VALUES (1322, 3, 275);
INSERT INTO `role_resource` VALUES (1323, 3, 276);
INSERT INTO `role_resource` VALUES (1324, 3, 277);
INSERT INTO `role_resource` VALUES (1325, 3, 278);
INSERT INTO `role_resource` VALUES (1326, 3, 279);
INSERT INTO `role_resource` VALUES (1327, 3, 280);
INSERT INTO `role_resource` VALUES (1328, 3, 281);
INSERT INTO `role_resource` VALUES (1329, 3, 282);
INSERT INTO `role_resource` VALUES (1330, 3, 283);
INSERT INTO `role_resource` VALUES (1331, 3, 284);
INSERT INTO `role_resource` VALUES (1332, 3, 285);
INSERT INTO `role_resource` VALUES (1333, 3, 286);
INSERT INTO `role_resource` VALUES (1290, 3, 287);
INSERT INTO `role_resource` VALUES (1291, 3, 288);
INSERT INTO `role_resource` VALUES (1293, 3, 290);
INSERT INTO `role_resource` VALUES (1292, 3, 291);
INSERT INTO `role_resource` VALUES (1274, 3, 292);
INSERT INTO `role_resource` VALUES (1275, 3, 293);
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
) ENGINE = InnoDB AUTO_INCREMENT = 1699 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for true_customer
-- ----------------------------
DROP TABLE IF EXISTS `true_customer`;
CREATE TABLE `true_customer`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户名',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户编码',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `delete_flag` int(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 827 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户信息' ROW_FORMAT = Dynamic;


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
  INDEX `video_cost_demand_sector_FK`(`demand_sector_id`) USING BTREE
  /*,
  CONSTRAINT `video_cost_demand_sector_FK` FOREIGN KEY (`demand_sector_id`) REFERENCES `organization` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_industry_FK` FOREIGN KEY (`industry_id`) REFERENCES `industry` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_optimizer_FK` FOREIGN KEY (`optimizer_id`) REFERENCES `optimizer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_organization_FK` FOREIGN KEY (`business_department_id`) REFERENCES `organization` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `video_cost_product_type_FK` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT*/
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '视频成片消耗' ROW_FORMAT = Dynamic;


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
) ENGINE = InnoDB AUTO_INCREMENT = 4231 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品类型信息' ROW_FORMAT = Dynamic;


SET FOREIGN_KEY_CHECKS = 1;
