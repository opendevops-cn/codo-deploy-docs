-- Create databases if they do not exist
CREATE DATABASE IF NOT EXISTS `codo-admin` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `codo-cmdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `codo-flow` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `codo-kerrigan` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS `codo-agent-server` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create a user and grant privileges
CREATE USER IF NOT EXISTS 'codo'@'%' IDENTIFIED WITH mysql_native_password BY 'ss1917';
GRANT ALL PRIVILEGES ON *.* TO 'codo'@'%' WITH GRANT OPTION;

-- Flush privileges
FLUSH PRIVILEGES;


-- 初始化数据字典
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


--------------------------------------- cnmp ---------------------------------------
CREATE DATABASE IF NOT EXISTS `codo_cnmp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

use codo_cnmp;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for audit_log
-- ----------------------------
CREATE TABLE IF NOT EXISTS `audit_log` (
                                           `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作用户名',
    `client_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '客户端IP',
    `module` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模块',
    `cluster` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '集群名称',
    `namespace` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '命名空间',
    `resource_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '对象类型',
    `resource_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '对象名称',
    `action` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作类型',
    `request_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求路径',
    `request_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '请求内容',
    `response_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '响应内容',
    `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '操作状态 0:成功 1:失败',
    `duration` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '操作耗时(ms)',
    `operation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_username`(`username`) USING BTREE,
    INDEX `idx_cluster`(`cluster`) USING BTREE,
    INDEX `idx_operation_time`(`operation_time`) USING BTREE,
    INDEX `idx_resource`(`resource_type`, `resource_name`) USING BTREE,
    INDEX `idx_request_path`(`request_path`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作审计日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cluster
-- ----------------------------
CREATE TABLE IF NOT EXISTS `cluster` (
                                         `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` datetime(3) NULL DEFAULT NULL,
    `updated_at` datetime(3) NULL DEFAULT NULL,
    `deleted_at` datetime(3) NULL DEFAULT NULL,
    `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `import_type` tinyint(4) NULL DEFAULT NULL,
    `import_detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `status` tinyint(4) NULL DEFAULT NULL,
    `server_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `platform` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `build_date` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `ext_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `node_state` tinyint(4) NULL DEFAULT NULL,
    `health_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `cpu_usage` decimal(10, 2) NULL DEFAULT NULL,
    `memory_usage` decimal(10, 2) NULL DEFAULT NULL,
    `cpu_total` decimal(10, 2) NULL DEFAULT NULL,
    `memory_total` decimal(10, 2) NULL DEFAULT NULL,
    `node_count` tinyint(3) UNSIGNED NULL DEFAULT NULL,
    `cluster_state` tinyint(4) NULL DEFAULT NULL,
    `uid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_codo_cluster_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for node
-- ----------------------------
CREATE TABLE IF NOT EXISTS `node` (
                                      `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `capacity` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `allocatable` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `addresses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `creation_timestamp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `created_at` datetime(3) NULL DEFAULT NULL,
    `updated_at` datetime(3) NULL DEFAULT NULL,
    `deleted_at` datetime(3) NULL DEFAULT NULL,
    `cluster_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
    `cpu_usage` decimal(10, 2) NULL DEFAULT NULL,
    `memory_usage` decimal(10, 2) NULL DEFAULT NULL,
    `status` tinyint(4) NULL DEFAULT NULL,
    `labels` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `annotations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `node_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `roles` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `resource_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `health_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `spec` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `cluster_id`(`cluster_id`) USING BTREE,
    CONSTRAINT `node_ibfk_1` FOREIGN KEY (`cluster_id`) REFERENCES `cluster` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
    ) ENGINE = InnoDB AUTO_INCREMENT = 425 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role
-- ----------------------------
CREATE TABLE IF NOT EXISTS `role` (
                                      `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` datetime(3) NULL DEFAULT NULL,
    `updated_at` datetime(3) NULL DEFAULT NULL,
    `deleted_at` datetime(3) NULL DEFAULT NULL,
    `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `role_type` tinyint(4) NOT NULL,
    `is_default` tinyint(1) NOT NULL DEFAULT 0,
    `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `yaml` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_role_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role_binding
-- ----------------------------
CREATE TABLE IF NOT EXISTS `role_binding` (
                                              `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` datetime(3) NULL DEFAULT NULL,
    `updated_at` datetime(3) NULL DEFAULT NULL,
    `deleted_at` datetime(3) NULL DEFAULT NULL,
    `user_group_id` bigint(20) UNSIGNED NOT NULL,
    `cluster_id` bigint(20) UNSIGNED NOT NULL,
    `role_id` bigint(20) UNSIGNED NOT NULL,
    `namespace` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `idx_user_group_cluster_role_namespace`(`user_group_id`, `cluster_id`, `role_id`, `namespace`, `deleted_at`) USING BTREE,
    INDEX `idx_role_binding_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
CREATE TABLE IF NOT EXISTS `user` (
                                      `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` datetime(3) NULL DEFAULT NULL,
    `updated_at` datetime(3) NULL DEFAULT NULL,
    `deleted_at` datetime(3) NULL DEFAULT NULL,
    `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `user_id` bigint(20) UNSIGNED NOT NULL,
    `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `source` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `uid_user_id`(`user_id`) USING BTREE,
    INDEX `idx_user_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 11275928 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_follow
-- ----------------------------
CREATE TABLE IF NOT EXISTS `user_follow` (
                                             `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户ID',
    `follow_type` tinyint(4) NOT NULL COMMENT '关注类型',
    `follow_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关注对象',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `uk_user_type`(`user_id`, `follow_type`, `follow_value`, `deleted_at`) USING BTREE,
    INDEX `idx_user_id`(`user_id`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户关注表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_group
-- ----------------------------
CREATE TABLE IF NOT EXISTS `user_group` (
                                            `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` datetime(3) NULL DEFAULT NULL,
    `updated_at` datetime(3) NULL DEFAULT NULL,
    `deleted_at` datetime(3) NULL DEFAULT NULL,
    `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `user_group_id` bigint(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `uid_user_group_id`(`user_group_id`) USING BTREE,
    INDEX `idx_user_group_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_user_group_rel
-- ----------------------------
CREATE TABLE IF NOT EXISTS `user_user_group_rel` (
                                                     `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` datetime(3) NULL DEFAULT NULL,
    `updated_at` datetime(3) NULL DEFAULT NULL,
    `deleted_at` datetime(3) NULL DEFAULT NULL,
    `user_id` bigint(20) UNSIGNED NOT NULL,
    `user_group_id` bigint(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `uid_user_user_group`(`user_id`, `user_group_id`) USING BTREE,
    INDEX `idx_user_user_group_rel_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

--------------------------------------- cnmp ---------------------------------------