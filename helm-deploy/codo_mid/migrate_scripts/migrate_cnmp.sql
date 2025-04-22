
CREATE DATABASE IF NOT EXISTS `codo-cnmp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use codo_cnmp;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
-- ----------------------------
-- Table structure for audit_log
-- ----------------------------
CREATE TABLE IF NOT EXiSTS `audit_log`
(
    `id`             bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `username`       varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '操作用户名',
    `client_ip`      varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '客户端IP',
    `module`         varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '模块',
    `cluster`        varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '集群名称',
    `namespace`      varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL DEFAULT '' COMMENT '命名空间',
    `resource_type`  varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '对象类型',
    `resource_name`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '对象名称',
    `action`         varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '操作类型',
    `request_path`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求路径',
    `request_body`   text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '请求内容',
    `response_body`  text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '响应内容',
    `status`         tinyint(4) NOT NULL DEFAULT 0 COMMENT '操作状态 0:成功 1:失败',
    `duration`       varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL DEFAULT '0' COMMENT '操作耗时(ms)',
    `operation_time` timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    `created_at`     timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`     timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted_at`     timestamp NULL DEFAULT NULL COMMENT '删除时间',
    `trace_id`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'traceID',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX            `idx_username`(`username`) USING BTREE,
    INDEX            `idx_cluster`(`cluster`) USING BTREE,
    INDEX            `idx_operation_time`(`operation_time`) USING BTREE,
    INDEX            `idx_resource`(`resource_type`, `resource_name`) USING BTREE,
    INDEX            `idx_request_path`(`request_path`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作审计日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cluster
-- ----------------------------
CREATE TABLE IF NOT EXiSTS `cluster`
(
    `id`             bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at`     datetime(3) NULL DEFAULT NULL,
    `updated_at`     datetime(3) NULL DEFAULT NULL,
    `deleted_at`     datetime(3) NULL DEFAULT NULL,
    `name`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `description`    text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `import_type`    tinyint(4) NULL DEFAULT NULL,
    `import_detail`  longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `status`         tinyint(4) NULL DEFAULT NULL,
    `server_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `platform`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `build_date`     varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `ext_info`       longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `node_state`     tinyint(4) NULL DEFAULT NULL,
    `health_state`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `cpu_usage`      decimal(10, 2) NULL DEFAULT NULL,
    `memory_usage`   decimal(10, 2) NULL DEFAULT NULL,
    `cpu_total`      decimal(10, 2) NULL DEFAULT NULL,
    `memory_total`   decimal(10, 2) NULL DEFAULT NULL,
    `node_count`     tinyint(3) UNSIGNED NULL DEFAULT NULL,
    `cluster_state`  tinyint(4) NULL DEFAULT NULL,
    `uid`            varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
    `idip`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `app_id`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `app_secret`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `ops`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `dst_agent_id`   bigint(20) NULL DEFAULT NULL,
    `connet_type`    tinyint(4) NULL DEFAULT 1,
    `mesh_addr`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `links`          longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX            `idx_codo_cluster_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for game_server
-- ----------------------------
CREATE TABLE IF NOT EXiSTS `game_server`
(
    `id`                  int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `entity_num`          int(11) NOT NULL COMMENT '实例对象数',
    `server_name`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '进程ID',
    `online_num`          int(11) NOT NULL COMMENT '在线用户数',
    `lock_entity_status`  tinyint(1) NULL DEFAULT 0 COMMENT 'entity锁定状态',
    `lock_lb_status`      tinyint(1) NULL DEFAULT 0 COMMENT 'lb锁定状态',
    `server_type`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '进程类型',
    `server`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '进程名称',
    `cluster_name`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '集群名',
    `namespace`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '命名空间',
    `pod`                 varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'pod名称',
    `server_version`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务版本',
    `code_version_game`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '游戏代码版本',
    `code_version_config` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '配置代码版本',
    `created_at`          datetime(3) NULL DEFAULT NULL COMMENT '创建时间',
    `updated_at`          datetime(3) NULL DEFAULT NULL COMMENT '更新时间',
    `deleted_at`          datetime(3) NULL DEFAULT NULL COMMENT '删除时间',
    `code_version_script` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `workload`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作负载',
    `workload_type`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作负载类型',
    `server_type_desc`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '进程类型中文名',
    `big_area`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '大区编号 ',
    `game_app_id`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '游戏应用编号',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `idx_unique`(`cluster_name`, `namespace`, `pod`) USING BTREE,
    INDEX                 `idx_server_name`(`server_name`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '游戏服务器实体表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for node
-- ----------------------------
CREATE TABLE IF NOT EXiSTS `node`
(
    `id`                 int(11) NOT NULL AUTO_INCREMENT,
    `name`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `conditions`         longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `capacity`           longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `allocatable`        longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `addresses`          longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `creation_timestamp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `created_at`         datetime(3) NULL DEFAULT NULL,
    `updated_at`         datetime(3) NULL DEFAULT NULL,
    `deleted_at`         datetime(3) NULL DEFAULT NULL,
    `cluster_id`         bigint(20) UNSIGNED NULL DEFAULT NULL,
    `cpu_usage`          decimal(10, 2) NULL DEFAULT NULL,
    `memory_usage`       decimal(10, 2) NULL DEFAULT NULL,
    `status`             tinyint(4) NULL DEFAULT NULL,
    `labels`             longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `annotations`        longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `node_info`          longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `roles`              varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `uid`                varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `resource_version`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `health_state`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `spec`               longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX                `cluster_id`(`cluster_id`) USING BTREE,
    CONSTRAINT `node_ibfk_1` FOREIGN KEY (`cluster_id`) REFERENCES `cluster` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for proxy_agent
-- ----------------------------
CREATE TABLE IF NOT EXiSTS `proxy_agent`
(
    `id`         bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` datetime(3) NULL DEFAULT NULL,
    `updated_at` datetime(3) NULL DEFAULT NULL,
    `deleted_at` datetime(3) NULL DEFAULT NULL,
    `name`       varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `agent_id`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX        `idx_role_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for role
-- ----------------------------
CREATE TABLE  IF NOT EXiSTS `role`
(
    `id`          bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at`  datetime(3) NULL DEFAULT NULL,
    `updated_at`  datetime(3) NULL DEFAULT NULL,
    `deleted_at`  datetime(3) NULL DEFAULT NULL,
    `name`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `role_type`   tinyint(4) NOT NULL,
    `is_default`  tinyint(1) NOT NULL DEFAULT 0,
    `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `yaml`        text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
    `update_by`   varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX         `idx_role_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role_binding
-- ----------------------------
CREATE TABLE IF NOT EXiSTS `role_binding`
(
    `id`            bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at`    datetime(3) NULL DEFAULT NULL,
    `updated_at`    datetime(3) NULL DEFAULT NULL,
    `deleted_at`    datetime(3) NULL DEFAULT NULL,
    `user_group_id` bigint(20) UNSIGNED NOT NULL,
    `cluster_id`    bigint(20) UNSIGNED NOT NULL,
    `role_id`       bigint(20) UNSIGNED NOT NULL,
    `namespace`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `idx_user_group_cluster_role_namespace`(`user_group_id`, `cluster_id`, `role_id`, `namespace`, `deleted_at`) USING BTREE,
    INDEX           `idx_role_binding_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
CREATE TABLE  IF NOT EXiSTS `user`
(
    `id`         bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` datetime(3) NULL DEFAULT NULL,
    `updated_at` datetime(3) NULL DEFAULT NULL,
    `deleted_at` datetime(3) NULL DEFAULT NULL,
    `username`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `nickname`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `user_id`    bigint(20) UNSIGNED NOT NULL,
    `email`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `source`     varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `uid_user_id`(`user_id`) USING BTREE,
    INDEX        `idx_user_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_follow
-- ----------------------------
CREATE TABLE  IF NOT EXiSTS `user_follow`
(
    `id`           bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id`      bigint(20) UNSIGNED NOT NULL COMMENT '用户ID',
    `follow_type`  tinyint(4) NOT NULL COMMENT '关注类型',
    `follow_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关注对象',
    `created_at`   timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`   timestamp                                                     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted_at`   timestamp NULL DEFAULT NULL COMMENT '删除时间',
    `cluster_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `uk_user_type`(`user_id`, `follow_type`, `follow_value`, `deleted_at`, `cluster_name`) USING BTREE,
    INDEX          `idx_user_id`(`user_id`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户关注表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user_group
-- ----------------------------
CREATE TABLE  IF NOT EXiSTS `user_group`
(
    `id`            bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at`    datetime(3) NULL DEFAULT NULL,
    `updated_at`    datetime(3) NULL DEFAULT NULL,
    `deleted_at`    datetime(3) NULL DEFAULT NULL,
    `name`          varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    `user_group_id` bigint(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `uid_user_group_id`(`user_group_id`) USING BTREE,
    INDEX           `idx_user_group_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_user_group_rel
-- ----------------------------
CREATE TABLE IF NOT EXiSTS `user_user_group_rel`
(
    `id`            bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at`    datetime(3) NULL DEFAULT NULL,
    `updated_at`    datetime(3) NULL DEFAULT NULL,
    `deleted_at`    datetime(3) NULL DEFAULT NULL,
    `user_id`       bigint(20) UNSIGNED NOT NULL,
    `user_group_id` bigint(20) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `uid_user_user_group`(`user_id`, `user_group_id`) USING BTREE,
    INDEX           `idx_user_user_group_rel_deleted_at`(`deleted_at`) USING BTREE
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

SET
FOREIGN_KEY_CHECKS = 1;
