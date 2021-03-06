select * from customer ;
-- 素材的最大有效消耗
alter table customer ADD column max_effect_con double NULL  comment '素材最大有效消耗，-1 表示使用默认系统配置值' ;
alter table customer ADD column income_ratio double NULL  comment '收入比率，表示使用默认系统配置值' ;
alter table customer ADD column pay_ratio double NULL  comment '支出比率，表示使用默认系统配置值' ;
alter table customer add column supplier_id bigint comment '供应商外键' , add index supplier_id_index (supplier_id) ;
alter table customer add index originality_id_index (originality_id) ;
alter table customer add index performer1_id_index (performer1_id) ;
alter table customer add index performer2_id_index (performer2_id) ;
alter table customer add index performer3_id_index (performer3_id) ;
alter table customer add index photographer_id_index (photographer_id) ;
alter table customer add index product_type_id_index (product_type_id) ;
alter table customer add index editor_id_index (editor_id) ;
alter table customer add index video_type_id_index (video_type_id) ;
alter table customer add index industry_id_index (industry_id) ;
alter table video_cost add index video_cost_customer_id(customer_id);


-- 系统配置
drop table if exists system_config;
create table system_config (
    id  bigint(19) primary key NOT NULL AUTO_INCREMENT ,
    supplier_id bigint(19) unique  ,
    default_income_ratio double default 100  comment '收入比率，百分比',
    default_pay_ratio double default 10  comment '支出比率，百分比',
    default_max_effect_con double default 100 comment '默认最大有效消耗',
    default_max_effect_range int default 60 comment '默认生命周期',
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    update_by  bigint(19) comment '更新人'
);
insert into system_config (id,default_income_ratio,default_pay_ratio,default_max_effect_con ,default_max_effect_range ) value (1,100.00,10.00,100,60) ;



-- 供应商
DROP TABLE IF EXISTS `supplier`;
create table supplier
(
    `id`          bigint(19)  PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键id',
    `name`        varchar(50) NOT NULL COMMENT '供应商名称',
    `code`        varchar(50) NOT NULL UNIQUE COMMENT '供应商编码',
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `create_time` datetime    NOT NULL COMMENT '创建时间',
    `delete_flag` int(1)      NOT NULL DEFAULT 0 COMMENT '是否删除'
)ENGINE = InnoDB  CHARACTER SET = utf8 ;
select  * from user ;
/* 用户新增所属供应商 */
 alter table user add column supplier_id bigint comment '供应商外键' ,add index user_supplier_index(supplier_id) ;

/* 视频类别的固定价格  */
 alter table video_type add column base_price double default 0 comment '固定价格';

-- 视频版本
DROP TABLE IF EXISTS `video_version`;
create table video_version
(
    `id`          bigint(19)  PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键id',
    `name`        varchar(50) NOT NULL COMMENT '版本名称',
    `code`        varchar(50) NOT NULL UNIQUE COMMENT '版本编码',
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `create_time` datetime    NOT NULL COMMENT '创建时间',
    `delete_flag` int(1)      NOT NULL DEFAULT 0 COMMENT '是否删除'
)ENGINE = InnoDB  CHARACTER SET = utf8 ;
/* 将编号唯一，改为编号，版本Id，供应商Id 唯一 */
alter table customer add column video_version_id bigint(19) , add index video_version_index (video_version_id) ,add unique index code_version (code,video_version_id);

-- 收入价格分级
DROP TABLE IF EXISTS `price_level`;
create table price_level
(
    `id`          bigint(19)  PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键id',
    `name`        varchar(50) NOT NULL COMMENT '分级名称',
    `code`        varchar(50) NOT NULL UNIQUE COMMENT '分级编码',
    `base_price` double default 0 comment '固定价格',
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `update_by` bigint    NOT NULL  COMMENT '更新人',
    `create_time` datetime    NOT NULL COMMENT '创建时间',
    `create_by` bigint    NOT NULL  COMMENT '创建人',
    `delete_flag` int(1)      NOT NULL DEFAULT 0 COMMENT '是否删除'
)ENGINE = InnoDB  CHARACTER SET = utf8 ;
alter table customer add column price_level_id bigint comment '收入价格分级外键' , add index price_level_id_index (price_level_id) ;
ALTER TABLE `shiro`.`resource`
    MODIFY COLUMN `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源图标' AFTER `description`;



-- 支出价格分级
DROP TABLE IF EXISTS `pay_level`;
create table pay_level
(
    `id`          bigint(19)  PRIMARY KEY NOT NULL AUTO_INCREMENT COMMENT '主键id',
    `name`        varchar(50) NOT NULL COMMENT '分级名称',
    `code`        varchar(50) NOT NULL UNIQUE COMMENT '分级编码',
    `base_pay` double default 0 comment '固定支出',
    `update_time` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
    `update_by` bigint    NOT NULL  COMMENT '更新人',
    `create_time` datetime    NOT NULL COMMENT '创建时间',
    `create_by` bigint    NOT NULL  COMMENT '创建人',
    `delete_flag` int(1)      NOT NULL DEFAULT 0 COMMENT '是否删除'
)ENGINE = InnoDB  CHARACTER SET = utf8 ;
alter table customer add column pay_level_id bigint comment '支出价格分级外键' , add index pay_level_id_index (pay_level_id) ;

alter table system_config add delete_flag int(1) NOT NULL DEFAULT 0 COMMENT '是否删除';

alter table system_config add column default_pay_max_effect_con double default 100 comment '默认支出最大有效消耗';

alter table customer add column pay_max_effect_con double comment '支出最大有效消耗';

alter table price_level
    add ratio double   comment '价格比率，百分比',
    add  max_effect_con double comment '最大有效消耗',
    add  max_effect_range int  comment '生命周期,天';

alter table pay_level
    add ratio double comment '价格比率，百分比',
    add  max_effect_con double comment '最大有效消耗',
    add  max_effect_range int comment '生命周期,天';


ALTER TABLE `video_cost`
    MODIFY COLUMN `consumption` decimal(29, 8) NULL COMMENT '当日消耗' AFTER `optimizer_id`;
ALTER TABLE `system_config`
    MODIFY COLUMN `default_income_ratio` decimal(29, 8) NULL DEFAULT 100 COMMENT '收入比率，百分比。' AFTER `supplier_id`,
    MODIFY COLUMN `default_max_effect_con` decimal(29, 8) NULL DEFAULT 100 COMMENT '默认最大有效消耗' AFTER `default_income_ratio`,
    MODIFY COLUMN `default_pay_ratio` decimal(29, 8) NULL DEFAULT 10 COMMENT '支出比率，百分比' AFTER `update_by`,
    MODIFY COLUMN `default_pay_max_effect_con` decimal(29, 8) NULL DEFAULT 100 COMMENT '默认支出最大有效消耗' AFTER `delete_flag`;
ALTER TABLE `pay_level`
    MODIFY COLUMN `base_pay` decimal(29, 8) NULL COMMENT '固定支出' AFTER `code`,
    MODIFY COLUMN `ratio` decimal(29, 8) NULL DEFAULT 100 COMMENT '价格比率，百分比' AFTER `delete_flag`,
    MODIFY COLUMN `max_effect_con` decimal(29, 8) NULL DEFAULT 100 COMMENT '最大有效消耗' AFTER `ratio`;
ALTER TABLE `price_level`
    MODIFY COLUMN `base_price` decimal(29, 8) NULL COMMENT '固定价格' AFTER `code`,
    MODIFY COLUMN `ratio` decimal(29, 8) NULL DEFAULT 100 COMMENT '价格比率，百分比' AFTER `delete_flag`,
    MODIFY COLUMN `max_effect_con` decimal(29, 8) NULL DEFAULT 100 COMMENT '最大有效消耗' AFTER `ratio`;
ALTER TABLE `customer`
    MODIFY COLUMN `max_effect_con` decimal(29, 8) NULL DEFAULT NULL COMMENT '素材最大有效消耗，-1 表示使用默认系统配置值' AFTER `delete_flag`,
    MODIFY COLUMN `income_ratio` decimal(29, 8) NULL DEFAULT NULL COMMENT '收入比率，表示使用默认系统配置值' AFTER `max_effect_con`,
    MODIFY COLUMN `pay_ratio` decimal(29, 8) NULL DEFAULT NULL COMMENT '支出比率，表示使用默认系统配置值' AFTER `price_level_id`,
    MODIFY COLUMN `pay_max_effect_con` decimal(29, 8) NULL DEFAULT NULL COMMENT '支出最大有效消耗' AFTER `pay_level_id`;