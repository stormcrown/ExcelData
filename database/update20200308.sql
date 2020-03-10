select * from customer ;
-- 素材的最大有效消耗
-- alter table customer add column max_effect_con double default -1 comment '素材最大有效消耗，-1 表示使用默认系统配置值' ;
-- alter table customer add column income_ratio double default -1 comment '收入比率，-1 表示使用默认系统配置值' ;
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
    id  bigint(19) primary key ,
    default_income_ratio double default 100  comment '收入比率，百分比。',
    default_max_effect_con double default 100 comment '默认最大',
    default_max_effect_range int default 60 comment '默认生命周期'
);
insert into system_config (id,default_income_ratio,default_max_effect_con ,default_max_effect_range ) value (1,100.00,100,60) ;
select * from system_config ;

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
);
select  * from user ;
/* 用户新增所属供应商 */
-- alter table user add column supplier_id bigint comment '供应商外键' ,add index user_supplier_index(supplier_id) ;

/* 视频类别的固定价格  */
-- alter table video_type add column base_price double default 0 comment '固定价格';

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
);

/* 将编号唯一，改为编号，版本Id唯一 */
-- alter table customer add column video_version_id bigint(19) , add index video_version_index (video_version_id) ,drop index uniqueCode ,add unique index code_version (code,video_version_id);