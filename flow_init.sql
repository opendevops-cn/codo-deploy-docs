-- 初始化数据字典
CREATE DATABASE IF NOT EXISTS `codo-flow` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `codo-flow`;

-- 创建 sys_dict_type 表，如果它不存在
CREATE TABLE IF NOT EXISTS `sys_dict_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_lock` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `dict_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `dict_code` (`dict_code`) USING BTREE,
  UNIQUE KEY `ix_sys_dict_type_dict_name` (`dict_name`) USING BTREE,
  KEY `ix_sys_dict_type_dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- 创建 sys_dict_data 表，如果它不存在
CREATE TABLE IF NOT EXISTS `sys_dict_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_lock` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `dict_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `dict_sort` smallint DEFAULT NULL,
  `dict_label` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dict_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `ix_sys_dict_data_dict_label` (`dict_label`) USING BTREE,
  KEY `ix_sys_dict_data_dict_sort` (`dict_sort`) USING BTREE,
  KEY `ix_sys_dict_data_pid` (`pid`) USING BTREE,
  KEY `ix_sys_dict_data_dict_code` (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- 检查并插入 sys_dict_type
INSERT INTO `sys_dict_type` (`id`, `is_lock`, `status`, `remark`, `created_by`, `update_by`, `create_time`, `update_time`, `dict_code`, `dict_name`, `dict_type`)
SELECT 1, 'n', '0', '流程类型', 'admin', '', '2023-03-15 16:48:10', '2023-03-15 16:48:10', 'FLOW_TYPE', '流程类型', 'list'
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict_type` WHERE `dict_code` = 'FLOW_TYPE');

INSERT INTO `sys_dict_type` (`id`, `is_lock`, `status`, `remark`, `created_by`, `update_by`, `create_time`, `update_time`, `dict_code`, `dict_name`, `dict_type`)
SELECT 2, 'n', '0', '常用任务使用', 'admin', '', '2023-03-16 09:56:28', '2023-03-16 09:56:28', 'TASK_TYPE', '任务类型', 'list'
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict_type` WHERE `dict_code` = 'TASK_TYPE');

-- 检查并插入 sys_dict_data
INSERT INTO `sys_dict_data` (`id`, `is_lock`, `status`, `remark`, `created_by`, `update_by`, `create_time`, `update_time`, `dict_code`, `pid`, `dict_sort`, `dict_label`, `dict_value`, `data_type`, `css_class`, `list_class`)
SELECT 1, 'n', '0', '事件', 'admin', '', '2023-03-15 16:48:38', '2023-03-15 16:48:38', 'FLOW_TYPE', 1, 0, '事件', 'event', 'string', '', ''
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict_data` WHERE `dict_code` = 'FLOW_TYPE' AND `dict_value` = 'event');

INSERT INTO `sys_dict_data` (`id`, `is_lock`, `status`, `remark`, `created_by`, `update_by`, `create_time`, `update_time`, `dict_code`, `pid`, `dict_sort`, `dict_label`, `dict_value`, `data_type`, `css_class`, `list_class`)
SELECT 2, 'n', '0', '请求', 'admin', '', '2023-03-16 09:53:36', '2023-03-16 09:53:36', 'FLOW_TYPE', 1, 0, '请求', 'request', 'string', '', ''
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict_data` WHERE `dict_code` = 'FLOW_TYPE' AND `dict_value` = 'request');

INSERT INTO `sys_dict_data` (`id`, `is_lock`, `status`, `remark`, `created_by`, `update_by`, `create_time`, `update_time`, `dict_code`, `pid`, `dict_sort`, `dict_label`, `dict_value`, `data_type`, `css_class`, `list_class`)
SELECT 3, 'n', '0', '发布', 'admin', '', '2023-03-16 09:54:57', '2023-03-16 09:54:57', 'FLOW_TYPE', 1, 0, '发布', 'publish', 'string', '', ''
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict_data` WHERE `dict_code` = 'FLOW_TYPE' AND `dict_value` = 'publish');

INSERT INTO `sys_dict_data` (`id`, `is_lock`, `status`, `remark`, `created_by`, `update_by`, `create_time`, `update_time`, `dict_code`, `pid`, `dict_sort`, `dict_label`, `dict_value`, `data_type`, `css_class`, `list_class`)
SELECT 4, 'n', '0', '监控', 'admin', '', '2023-03-16 09:55:24', '2023-03-16 09:55:24', 'FLOW_TYPE', 1, 0, '监控', 'monitor', 'string', '', ''
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict_data` WHERE `dict_code` = 'FLOW_TYPE' AND `dict_value` = 'monitor');

INSERT INTO `sys_dict_data` (`id`, `is_lock`, `status`, `remark`, `created_by`, `update_by`, `create_time`, `update_time`, `dict_code`, `pid`, `dict_sort`, `dict_label`, `dict_value`, `data_type`, `css_class`, `list_class`)
SELECT 5, 'n', '0', '服务端', 'admin', '', '2023-03-16 09:56:56', '2023-03-16 09:56:56', 'TASK_TYPE', 2, 0, '服务端', 'server', 'string', '', ''
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict_data` WHERE `dict_code` = 'TASK_TYPE' AND `dict_value` = 'server');

INSERT INTO `sys_dict_data` (`id`, `is_lock`, `status`, `remark`, `created_by`, `update_by`, `create_time`, `update_time`, `dict_code`, `pid`, `dict_sort`, `dict_label`, `dict_value`, `data_type`, `css_class`, `list_class`)
SELECT 6, 'n', '0', '客户端', 'admin', '', '2023-03-16 09:57:17', '2023-03-16 09:57:17', 'TASK_TYPE', 2, 0, '客户端', 'client', 'string', '', ''
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict_data` WHERE `dict_code` = 'TASK_TYPE' AND `dict_value` = 'client');

INSERT INTO `sys_dict_data` (`id`, `is_lock`, `status`, `remark`, `created_by`, `update_by`, `create_time`, `update_time`, `dict_code`, `pid`, `dict_sort`, `dict_label`, `dict_value`, `data_type`, `css_class`, `list_class`)
SELECT 7, 'n', '0', '运维任务', 'admin', '', '2023-03-16 09:57:55', '2023-03-16 09:57:55', 'TASK_TYPE', 2, 0, '运维任务', 'ops', 'string', '', ''
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict_data` WHERE `dict_code` = 'TASK_TYPE' AND `dict_value` = 'ops');

INSERT INTO `sys_dict_data` (`id`, `is_lock`, `status`, `remark`, `created_by`, `update_by`, `create_time`, `update_time`, `dict_code`, `pid`, `dict_sort`, `dict_label`, `dict_value`, `data_type`, `css_class`, `list_class`)
SELECT 8, 'n', '0', '打包构建', 'admin', '', '2023-06-07 17:44:21', '2023-06-07 17:44:21', 'FLOW_TYPE', 1, 0, '构建', 'build', 'string', '', ''
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict_data` WHERE `dict_code` = 'FLOW_TYPE' AND `dict_value` = 'build');