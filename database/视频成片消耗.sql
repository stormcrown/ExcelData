DROP TABLE
IF EXISTS `video_cost`;
CREATE TABLE `video_cost` (
	`id` BIGINT (19) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '主键id',
	`update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
	`create_time` datetime not null COMMENT '创建时间',
	`delete_flag` int(1) DEFAULT 0 COMMENT '是否删除',
	`recored_date` date NOT NULL COMMENT '日期',
	`business_department` VARCHAR (100) COMMENT '业务部',
	`product_type` VARCHAR (100) COMMENT '产品类型',
	`customer_name` VARCHAR (64) COMMENT '客户名',
	`industry` VARCHAR (32) COMMENT '行业',
	`demand_sector` VARCHAR (32) DEFAULT NULL COMMENT '需求部门',
	`optimizer` VARCHAR (32) COMMENT '优化师',
	`video_type` VARCHAR (100) COMMENT '视频类型',
	`complete_date` date COMMENT '成片日期',
	`originality` VARCHAR (100) COMMENT '创意',
	`photographer` VARCHAR (100) COMMENT '摄像',
	`editor` VARCHAR (100) COMMENT '剪辑',
	`performer1` VARCHAR (100) COMMENT '演员1',
	`performer2` VARCHAR (100) COMMENT '演员2',
	`performer3` VARCHAR (100) COMMENT '演员3',
	`consumption` DOUBLE COMMENT '当日消耗',
	`cumulative_consumption` DOUBLE COMMENT '累计消耗',
	`cumulative_consumption_ranking` INT COMMENT '消耗累积排名'

) ENGINE = INNODB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8 COMMENT = '视频成片消耗';