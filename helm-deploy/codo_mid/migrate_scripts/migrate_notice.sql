CREATE
DATABASE IF NOT EXISTS `codo-notice` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
set NAMES utf8mb4;
use `codo-notice`;
CREATE TABLE IF NOT EXISTS `codo_audit`
(
    `id`
    bigint
    unsigned
    NOT
    NULL
    AUTO_INCREMENT,
    `created_at`
    datetime
(
    3
) DEFAULT NULL,
    `updated_at` datetime
(
    3
) DEFAULT NULL,
    `deleted_at` datetime
(
    3
) DEFAULT NULL,
    `created_by` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `updated_by` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `resource_type` varchar
(
    32
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `resource_name` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `resource_target` varchar
(
    2048
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `action` varchar
(
    32
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `status` varchar
(
    16
) COLLATE utf8mb4_unicode_ci DEFAULT 'success',
    `detail` mediumtext COLLATE utf8mb4_unicode_ci,
    PRIMARY KEY
(
    `id`
),
    KEY `idx_type`
(
    `resource_type`
),
    KEY `idx_action`
(
    `action`
),
    KEY `idx_codo_audit_deleted_at`
(
    `deleted_at`
)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS `codo_channel`
(
    `id`
    bigint
    unsigned
    NOT
    NULL
    AUTO_INCREMENT,
    `created_at`
    datetime
(
    3
) DEFAULT NULL,
    `updated_at` datetime
(
    3
) DEFAULT NULL,
    `deleted_at` datetime
(
    3
) DEFAULT NULL,
    `created_by` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `updated_by` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name` varchar
(
    256
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `use` varchar
(
    45
) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
    `user` longtext COLLATE utf8mb4_unicode_ci,
    `group` longtext COLLATE utf8mb4_unicode_ci,
    `contact_points` mediumtext COLLATE utf8mb4_unicode_ci,
    `custom_items` mediumtext COLLATE utf8mb4_unicode_ci,
    `default_rule` longtext COLLATE utf8mb4_unicode_ci,
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `uni_codo_channel_name`
(
    `name`
),
    KEY `idx_codo_channel_deleted_at`
(
    `deleted_at`
)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS `codo_router`
(
    `id`
    bigint
    unsigned
    NOT
    NULL
    AUTO_INCREMENT,
    `created_at`
    datetime
(
    3
) DEFAULT NULL,
    `updated_at` datetime
(
    3
) DEFAULT NULL,
    `deleted_at` datetime
(
    3
) DEFAULT NULL,
    `created_by` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `updated_by` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name` varchar
(
    256
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `description` varchar
(
    1024
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `status` varchar
(
    16
) COLLATE utf8mb4_unicode_ci DEFAULT 'yes',
    `channel_id` int DEFAULT '0',
    `condition` mediumtext COLLATE utf8mb4_unicode_ci,
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `uni_codo_router_name`
(
    `name`
),
    KEY `idx_codo_router_deleted_at`
(
    `deleted_at`
)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS `codo_template`
(
    `id`
    bigint
    unsigned
    NOT
    NULL
    AUTO_INCREMENT,
    `created_at`
    datetime
(
    3
) DEFAULT NULL,
    `updated_at` datetime
(
    3
) DEFAULT NULL,
    `deleted_at` datetime
(
    3
) DEFAULT NULL,
    `created_by` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `updated_by` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `name` varchar
(
    256
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `content` text COLLATE utf8mb4_unicode_ci,
    `type` varchar
(
    16
) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
    `use` varchar
(
    45
) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
    `default` varchar
(
    16
) COLLATE utf8mb4_unicode_ci DEFAULT 'no',
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `uni_codo_template_name`
(
    `name`
),
    KEY `idx_codo_template_deleted_at`
(
    `deleted_at`
),
    KEY `idx_name`
(
    `name`
),
    KEY `idx_type`
(
    `type`
)
    ) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;
CREATE TABLE IF NOT EXISTS `codo_user`
(
    `id`
    bigint
    unsigned
    NOT
    NULL
    AUTO_INCREMENT,
    `created_at`
    datetime
(
    3
) DEFAULT NULL,
    `updated_at` datetime
(
    3
) DEFAULT NULL,
    `deleted_at` datetime
(
    3
) DEFAULT NULL,
    `username` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `nickname` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `user_id` varchar
(
    128
) COLLATE utf8mb4_unicode_ci NOT NULL,
    `dep_id` varchar
(
    2048
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `dep` varchar
(
    2048
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `manager` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `avatar` varchar
(
    1024
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `active` tinyint
(
    1
) DEFAULT '1',
    `tel` varchar
(
    32
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `email` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `data_source` mediumtext COLLATE utf8mb4_unicode_ci,
    `disable` tinyint
(
    1
) DEFAULT '0',
    `dd_id` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `fs_id` varchar
(
    128
) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY
(
    `id`
),
    UNIQUE KEY `uni_codo_user_user_id`
(
    `user_id`
),
    KEY `idx_codo_user_deleted_at`
(
    `deleted_at`
)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE =utf8mb4_unicode_ci;


INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`) VALUES (1,'2022-07-29 18:00:00.000','2022-07-29 19:59:59.000',NULL,'admin(管理员)','admin(管理员)','阿里云短信默认模版','alydx','default','yes','{{.title}}, {{.description}}');
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`) VALUES (2,'2022-07-29 18:00:00.000','2022-07-29 19:59:58.000',NULL,'admin(管理员)','admin(管理员)','阿里云电话默认模版','alydh','default','yes','{{.title}}, {{.description}}');
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`) VALUES (3,'2022-07-29 18:00:00.000','2022-07-29 19:59:57.000',NULL,'admin(管理员)','admin(管理员)','腾讯云短信默认模版','txdx','default','yes','{\"msg\":\"{{.message}}\"}');
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`) VALUES (4,'2022-07-29 18:00:00.000','2022-07-29 19:59:56.000',NULL,'admin(管理员)','admin(管理员)','腾讯云电话默认模版','txdh','default','yes','{\"msg\":\"{{.message}}\"}');
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (5,'2022-07-29 18:00:00.000','2022-07-29 19:59:55.000',NULL,'admin(管理员)','admin(管理员)','邮件默认模版','email','default','yes',
        '{{if .message}}
        <h3>{{.message}}</h3>
        {{else}}
        <h3>未成功获取message信息</h3>
        {{end}}
        <img src=codo-notice.png />'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (6,'2022-07-29 18:00:00.000','2022-07-29 19:59:54.000',NULL,'admin(管理员)','admin(管理员)','飞书机器人默认模版','fs','default','yes',
        '{{if .message}}
        {{.message}}
        {{else}}
        未成功获取message信息
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (7,'2022-07-29 18:00:00.000','2022-07-29 19:59:53.000',NULL,'admin(管理员)','admin(管理员)','飞书应用默认模版','fsapp','default','yes',
        '{{if .message}}
        {{.message}}
        {{else}}
        未成功获取message信息
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (8,'2022-07-29 18:00:00.000','2022-07-29 19:59:52.000',NULL,'admin(管理员)','admin(管理员)','钉钉机器人默认模版','dd','default','yes',
        '{{if .message}}
        ### {{.message}}
        {{else}}
        ### 未成功获取message信息
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (9,'2022-07-29 18:00:00.000','2022-07-29 19:59:51.000',NULL,'admin(管理员)','admin(管理员)','钉钉应用默认模版','ddapp','default','yes',
        '{{if .message}}
        ### {{.message}}
        {{else}}
        ### 未成功获取message信息
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (10,'2022-07-29 18:00:00.000','2022-07-29 19:59:50.000',NULL,'admin(管理员)','admin(管理员)','企业微信默认模版','wx','grafana','yes',
        '{{if .message}}
        ### {{.message}}
        {{else}}
        ### 未成功获取message信息
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (11,'2022-07-29 18:00:00.000','2022-07-29 19:59:49.000',NULL,'admin(管理员)','admin(管理员)','企业微信应用默认模版','wxapp','default','yes',
        '{{if .message}}
        ### {{.message}}
        {{else}}
        ### 未成功获取message信息
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`) VALUES (12,'2022-07-29 18:00:00.000','2022-07-29 19:59:48.000',NULL,'admin(管理员)','admin(管理员)','Webhook默认模版','webhook','default','yes','{\"message\":\"{{.message}}\"}');
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (13,'2022-07-29 18:00:00.000','2022-07-29 19:59:47.000',NULL,'admin(管理员)','admin(管理员)','飞书机器人Prometheus','fs','prometheus','yes',
        '{{ $var := .externalURL}}
        {{ range $k,$v:=.alerts }}
        {{if eq $v.status "resolved"}}
        **[Prometheus恢复信息]({{$v.generatorURL}})**
        *[{{$v.labels.alertname}}]({{$var}})*
        告警级别：{{$v.labels.level}}
        开始时间：{{timeFormat $v.startsAt}}
        结束时间：{{timeFormat $v.endsAt}}
        故障主机IP：{{$v.labels.instance}}
        **{{$v.annotations.description}}**
        {{else}}
        **[Prometheus告警信息]({{$v.generatorURL}})**
        *[{{$v.labels.alertname}}]({{$var}})*
        告警级别：{{$v.labels.level}}
        开始时间：{{timeFormat $v.startsAt}}
        结束时间：{{timeFormat $v.endsAt}}
        故障主机IP：{{$v.labels.instance}}
        **{{$v.annotations.description}}**
        {{end}}
        {{end}}
        {{ $urimsg := "xxx" }}
        {{ range $key,$value:=.commonLabels }}
        {{$urimsg = print $urimsg $key "%3D%22" $value "%22%2C" }}
        {{end}}
        [*** 点我屏蔽该告警]({{$var}}/#/silences/new?filter=%7B{{substr 0 3 $urimsg}}%7D)'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (14,'2022-07-29 18:00:00.000','2022-07-29 19:59:46.000',NULL,'admin(管理员)','admin(管理员)','飞书机器人Grafana','fs','grafana','yes',
        '{{if eq .state "ok"}}
        **[Grafana恢复信息]({{.ruleUrl}})**
        *{{.ruleName}}*
        告警级别：严重
        开始时间：{{nowLocal}}
        **{{.message}}**
        {{else}}
        **[Grafana告警信息]({{.ruleUrl}})**
        *{{.ruleName}}*
        告警级别：严重
        开始时间：{{nowLocal}}
        **{{.message}}**
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (15,'2022-07-29 18:00:00.000','2022-07-29 19:59:45.000',NULL,'admin(管理员)','admin(管理员)','飞书应用Prometheus','fsapp','prometheus','yes',
        '{{ $var := .externalURL}}
        {{ range $k,$v:=.alerts }}
        {{if eq $v.status "resolved"}}
        **[Prometheus恢复信息]({{$v.generatorURL}})**
        *[{{$v.labels.alertname}}]({{$var}})*
        告警级别：{{$v.labels.level}}
        开始时间：{{timeFormat $v.startsAt}}
        结束时间：{{timeFormat $v.endsAt}}
        故障主机IP：{{$v.labels.instance}}
        **{{$v.annotations.description}}**
        {{else}}
        **[Prometheus告警信息]({{$v.generatorURL}})**
        *[{{$v.labels.alertname}}]({{$var}})*
        告警级别：{{$v.labels.level}}
        开始时间：{{timeFormat $v.startsAt}}
        结束时间：{{timeFormat $v.endsAt}}
        故障主机IP：{{$v.labels.instance}}
        **{{$v.annotations.description}}**
        {{end}}
        {{end}}
        {{ $urimsg := "xxx" }}
        {{ range $key,$value:=.commonLabels }}
        {{$urimsg = print $urimsg $key "%3D%22" $value "%22%2C" }}
        {{end}}
        [*** 点我屏蔽该告警]({{$var}}/#/silences/new?filter=%7B{{substr 0 3 $urimsg}}%7D)'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (16,'2022-07-29 18:00:00.000','2022-07-29 19:59:44.000',NULL,'admin(管理员)','admin(管理员)','飞书应用Grafana','fsapp','grafana','yes',
        '{{if eq .state "ok"}}
        **[Grafana恢复信息]({{.ruleUrl}})**
        *{{.ruleName}}*
        告警级别：严重
        开始时间：{{nowLocal}}
        **{{.message}}**
        {{else}}
        **[Grafana告警信息]({{.ruleUrl}})**
        *{{.ruleName}}*
        告警级别：严重
        开始时间：{{nowLocal}}
        **{{.message}}**
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (17,'2022-07-29 18:00:00.000','2022-07-29 19:59:43.000',NULL,'admin(管理员)','admin(管理员)','钉钉机器人Prometheus','dd','prometheus','yes',
        '{{ $var := .externalURL}}
        {{ range $k,$v:=.alerts }}
        {{if eq $v.status "resolved"}}
        ## [Prometheus恢复信息]({{$v.generatorURL}})
        #### [{{$v.labels.alertname}}]({{$var}})
        ###### 告警级别：{{$v.labels.level}}
        ###### 开始时间：{{timeFormat $v.startsAt}}
        ###### 结束时间：{{timeFormat $v.endsAt}}
        ###### 故障主机IP：{{$v.labels.instance}}
        ##### {{$v.annotations.description}}
        ![Prometheus](codo-notice.png)
        {{else}}
        ## [Prometheus告警信息]({{$v.generatorURL}})
        #### [{{$v.labels.alertname}}]({{$var}})
        ###### 告警级别：{{$v.labels.level}}
        ###### 开始时间：{{timeFormat $v.startsAt}}
        ###### 结束时间：{{timeFormat $v.endsAt}}
        ###### 故障主机IP：{{$v.labels.instance}}
        ##### {{$v.annotations.description}}
        ![Prometheus](codo-notice.png)
        {{end}}
        {{end}}
        {{ $urimsg := "xxx"}}
        {{ range $key,$value:=.commonLabels }}
        {{$urimsg =  print $urimsg $key "%3D%22" $value "%22%2C" }}
        {{end}}
        [*** 点我屏蔽该告警]({{$var}}/#/silences/new?filter=%7B{{substr 0 3 $urimsg}}%7D)'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (18,'2022-07-29 18:00:00.000','2022-07-29 19:59:42.000',NULL,'admin(管理员)','admin(管理员)','钉钉机器人Grafana','dd','grafana','yes',
        '{{if eq .state "ok"}}
        ## [Grafana恢复信息]({{.ruleUrl}})
        #### {{.ruleName}}
        ###### 告警级别：严重
        ###### 开始时间：{{nowLocal}}
        ##### {{.message}}
        {{else}}
        ## [Grafana告警信息]({{.ruleUrl}})
        #### {{.ruleName}}
        ###### 告警级别：严重
        ###### 开始时间：{{nowLocal}}
        ##### {{.message}}
        {{end}}
        ![Prometheus](codo-notice.png)'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (19,'2022-07-29 18:00:00.000','2022-07-29 19:59:41.000',NULL,'admin(管理员)','admin(管理员)','钉钉应用Prometheus','ddapp','prometheus','yes',
        '{{ $var := .externalURL}}
        {{ range $k,$v:=.alerts }}
        {{if eq $v.status "resolved"}}
        ## [Prometheus恢复信息]({{$v.generatorURL}})
        #### [{{$v.labels.alertname}}]({{$var}})
        ###### 告警级别：{{$v.labels.level}}
        ###### 开始时间：{{timeFormat $v.startsAt}}
        ###### 结束时间：{{timeFormat $v.endsAt}}
        ###### 故障主机IP：{{$v.labels.instance}}
        ##### {{$v.annotations.description}}
        ![Prometheus](codo-notice.png)
        {{else}}
        ## [Prometheus告警信息]({{$v.generatorURL}})
        #### [{{$v.labels.alertname}}]({{$var}})
        ###### 告警级别：{{$v.labels.level}}
        ###### 开始时间：{{timeFormat $v.startsAt}}
        ###### 结束时间：{{timeFormat $v.endsAt}}
        ###### 故障主机IP：{{$v.labels.instance}}
        ##### {{$v.annotations.description}}
        ![Prometheus](codo-notice.png)
        {{end}}
        {{end}}
        {{ $urimsg := "xxx"}}
        {{ range $key,$value:=.commonLabels }}
        {{$urimsg =  print $urimsg $key "%3D%22" $value "%22%2C" }}
        {{end}}
        [*** 点我屏蔽该告警]({{$var}}/#/silences/new?filter=%7B{{substr 0 3 $urimsg}}%7D)'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (20,'2022-07-29 18:00:00.000','2022-07-29 19:59:40.000',NULL,'admin(管理员)','admin(管理员)','钉钉应用Grafana','ddapp','grafana','yes',
        '{{if eq .state "ok"}}
        ## [Grafana恢复信息]({{.ruleUrl}})
        #### {{.ruleName}}
        ###### 告警级别：严重
        ###### 开始时间：{{nowLocal}}
        ##### {{.message}}
        {{else}}
        ## [Grafana告警信息]({{.ruleUrl}})
        #### {{.ruleName}}
        ###### 告警级别：严重
        ###### 开始时间：{{nowLocal}}
        ##### {{.message}}
        {{end}}
        ![Prometheus](codo-notice.png)'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (21,'2022-07-29 18:00:00.000','2022-07-29 19:59:39.000',NULL,'admin(管理员)','admin(管理员)','邮件Prometheus','email','prometheus','yes',
        '{{ $var := .externalURL}}{{ range $k,$v:=.alerts }}
        {{if eq $v.status "resolved"}}
        <h1><a href ={{$v.generatorURL}}>Prometheus恢复信息</a></h1>
        <h2><a href ={{$var}}>{{$v.labels.alertname}}</a></h2>
        <h5>告警级别：{{$v.labels.level}}</h5>
        <h5>开始时间：{{$v.startsAt}}</h5>
        <h5>结束时间：{{$v.endsAt}}</h5>
        <h5>故障主机IP：{{$v.labels.instance}}</h5>
        <h3>{{$v.annotations.description}}</h3>
        <img src=codo-notice.png />
        {{else}}
        <h1><a href ={{$v.generatorURL}}>Prometheus告警信息</a></h1>
        <h2><a href ={{$var}}>{{$v.labels.alertname}}</a></h2>
        <h5>告警级别：{{$v.labels.level}}</h5>
        <h5>开始时间：{{$v.startsAt}}</h5>
        <h5>结束时间：{{$v.endsAt}}</h5>
        <h5>故障主机IP：{{$v.labels.instance}}</h5>
        <h3>{{$v.annotations.description}}</h3>
        <img src=codo-notice.png />
        {{end}}
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (22,'2022-07-29 18:00:00.000','2022-07-29 19:59:38.000',NULL,'admin(管理员)','admin(管理员)','邮件Grafana','email','grafana','yes',
        '{{if eq .state "ok"}}
        <h1><a href ={{.ruleUrl}}>Grafana恢复信息</a></h1>
        <h2>{{.ruleName}}</h2>
        <h5>告警级别：严重</h5>
        <h5>开始时间：{{nowLocal}}</h5>
        <h3>{{.message}}</h3>
        {{else}}
        <h1><a href ={{.ruleUrl}}>Grafana恢复信息</a></h1>
        <h2>{{.ruleName}}</h2>
        <h5>告警级别：严重</h5>
        <h5>开始时间：{{nowLocal}}</h5>
        <h3>{{.message}}</h3>
        {{end}}
        <img src=codo-notice.png />'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (23,'2022-07-29 18:00:00.000','2022-07-29 19:59:37.000',NULL,'admin(管理员)','admin(管理员)','企业微信Prometheus','wx','prometheus','yes',
        '{{ $var := .externalURL}}
        {{ range $k,$v:=.alerts }}
        {{if eq $v.status "resolved"}}
        [PROMETHEUS-恢复信息]({{$v.generatorURL}})
        > **[{{$v.labels.alertname}}]({{$var}})**
        > <font color="info">告警级别:</font> {{$v.labels.level}}
        > <font color="info">开始时间:</font> {{$v.startsAt}}
        > <font color="info">结束时间:</font> {{$v.endsAt}}
        > <font color="info">故障主机IP:</font> {{$v.labels.instance}}
        > <font color="info">**{{$v.annotations.description}}**</font>
        {{else}}
        [PROMETHEUS-告警信息]({{$v.generatorURL}})
        > **[{{$v.labels.alertname}}]({{$var}})**
        > <font color="warning">告警级别:</font> {{$v.labels.level}}
        > <font color="warning">开始时间:</font> {{$v.startsAt}}
        > <font color="warning">结束时间:</font> {{$v.endsAt}}
        > <font color="warning">故障主机IP:</font> {{$v.labels.instance}}
        > <font color="warning">**{{$v.annotations.description}}**</font>
        {{end}}
        {{end}}
        {{ $urimsg:="xxx"}}
        {{ range $key,$value:=.commonLabels }}
        {{$urimsg =  print $urimsg $key "%3D%22" $value "%22%2C" }}
        {{end}}
        [*** 点我屏蔽该告警]({{$var}}/#/silences/new?filter=%7B{{substr 0 3 $urimsg}}%7D)'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (24,'2022-07-29 18:00:00.000','2022-07-29 19:59:37.000',NULL,'admin(管理员)','admin(管理员)','企业微信Grafana','wx','grafana','yes',
        '{{if eq .state "ok"}}
        [Grafana恢复信息]({{.ruleUrl}})
        >**{{.ruleName}}**
        >告警级别:严重
        开始时间:{{nowLocal}}
        {{.message}}
        {{else}}
        [Grafana告警信息]({{.ruleUrl}})
        >**{{.ruleName}}**
        >告警级别:严重
        开始时间:{{nowLocal}}
        {{.message}}
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (25,'2022-07-29 18:00:00.000','2022-07-29 19:59:36.000',NULL,'admin(管理员)','admin(管理员)','企业微信应用Prometheus','wxapp','prometheus','yes',
        '{{ $var := .externalURL}}
        {{ range $k,$v:=.alerts }}
        {{if eq $v.status "resolved"}}
        [PROMETHEUS-恢复信息]({{$v.generatorURL}})
        > **[{{$v.labels.alertname}}]({{$var}})**
        > <font color="info">告警级别:</font> {{$v.labels.level}}
        > <font color="info">开始时间:</font> {{$v.startsAt}}
        > <font color="info">结束时间:</font> {{$v.endsAt}}
        > <font color="info">故障主机IP:</font> {{$v.labels.instance}}
        > <font color="info">**{{$v.annotations.description}}**</font>
        {{else}}
        [PROMETHEUS-告警信息]({{$v.generatorURL}})
        > **[{{$v.labels.alertname}}]({{$var}})**
        > <font color="warning">告警级别:</font> {{$v.labels.level}}
        > <font color="warning">开始时间:</font> {{$v.startsAt}}
        > <font color="warning">结束时间:</font> {{$v.endsAt}}
        > <font color="warning">故障主机IP:</font> {{$v.labels.instance}}
        > <font color="warning">**{{$v.annotations.description}}**</font>
        {{end}}
        {{end}}
        {{ $urimsg:="xxx"}}
        {{ range $key,$value:=.commonLabels }}
        {{$urimsg =  print $urimsg $key "%3D%22" $value "%22%2C" }}
        {{end}}
        [*** 点我屏蔽该告警]({{$var}}/#/silences/new?filter=%7B{{substr 0 3 $urimsg}}%7D)'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (26,'2022-07-29 18:00:00.000','2022-07-29 19:59:35.000',NULL,'admin(管理员)','admin(管理员)','企业微信应用Grafana','wxapp','grafana','yes',
        '{{if eq .state "ok"}}
        [Grafana恢复信息]({{.ruleUrl}})
        >**{{.ruleName}}**
        >告警级别:严重
        开始时间:{{nowLocal}}
        {{.message}}
        {{else}}
        [Grafana告警信息]({{.ruleUrl}})
        >**{{.ruleName}}**
        >告警级别:严重
        开始时间:{{nowLocal}}
        {{.message}}
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (27,'2022-07-29 18:00:00.000','2022-07-29 19:59:34.000',NULL,'admin(管理员)','admin(管理员)','飞书机器人天枢监控','fs','tianshu','yes',
        '{{if eq .status "resolved"}}
        **【恢复信息】**
        主机IP：{{.address}}{{if .process_name}}
        进程名：{{.process_name}}{{end}}{{if .ps_name}}
        进程名ps：{{.ps_name}}{{end}}{{if .description}}
        告警描述：{{.description}}{{end}}
        告警等级：{{.severity}}
        业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        主机名称：{{.cmdb_host}}
        当前值：{{.value}}
        表达式：{{.expr}}
        类型：{{.classify}}
        来源：{{.source}}{{if .cpu}}
        cpu：{{.cpu}}{{end}}{{if .container}}
        k8s容器：{{.container}}{{end}}{{if .pod}}
        k8s-pod：{{.pod}}{{end}}{{if .namespace}}
        k8s命名空间：{{.namespace}}{{end}}{{if .server_name}}
        服务名：{{.server_name}}{{end}}{{if .instance}}
        实例：{{.instance}}{{end}}
        开始时间：{{timeFormat .starts_at}}
        结束时间：{{timeFormat .ends_at}}
        {{else}}
        **【告警信息】**
        主机IP：{{.address}}{{if .process_name}}
        进程名：{{.process_name}}{{end}}{{if .ps_name}}
        进程名ps：{{.ps_name}}{{end}}{{if .description}}
        告警描述：{{.description}}{{end}}
        告警等级：{{.severity}}
        业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        主机名称：{{.cmdb_host}}
        当前值：{{.value}}
        表达式：{{.expr}}
        类型：{{.classify}}
        来源：{{.source}}{{if .cpu}}
        cpu：{{.cpu}}{{end}}{{if .container}}
        k8s容器：{{.container}}{{end}}{{if .pod}}
        k8s-pod：{{.pod}}{{end}}{{if .namespace}}
        k8s命名空间：{{.namespace}}{{end}}{{if .server_name}}
        服务名：{{.server_name}}{{end}}{{if .instance}}
        实例：{{.instance}}{{end}}
        开始时间：{{timeFormat .starts_at}}
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (28,'2022-07-29 18:00:00.000','2022-07-29 19:59:33.000',NULL,'admin(管理员)','admin(管理员)','飞书应用天枢监控','fsapp','tianshu','yes',
        '{{if eq .status "resolved"}}
        **【恢复信息】**
        主机IP：{{.address}}{{if .process_name}}
        进程名：{{.process_name}}{{end}}{{if .ps_name}}
        进程名ps：{{.ps_name}}{{end}}{{if .description}}
        告警描述：{{.description}}{{end}}
        告警等级：{{.severity}}
        业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        主机名称：{{.cmdb_host}}
        当前值：{{.value}}
        表达式：{{.expr}}
        类型：{{.classify}}
        来源：{{.source}}{{if .cpu}}
        cpu：{{.cpu}}{{end}}{{if .container}}
        k8s容器：{{.container}}{{end}}{{if .pod}}
        k8s-pod：{{.pod}}{{end}}{{if .namespace}}
        k8s命名空间：{{.namespace}}{{end}}{{if .server_name}}
        服务名：{{.server_name}}{{end}}{{if .instance}}
        实例：{{.instance}}{{end}}
        开始时间：{{timeFormat .starts_at}}
        结束时间：{{timeFormat .ends_at}}
        {{else}}
        **【告警信息】**
        主机IP：{{.address}}{{if .process_name}}
        进程名：{{.process_name}}{{end}}{{if .ps_name}}
        进程名ps：{{.ps_name}}{{end}}{{if .description}}
        告警描述：{{.description}}{{end}}
        告警等级：{{.severity}}
        业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        主机名称：{{.cmdb_host}}
        当前值：{{.value}}
        表达式：{{.expr}}
        类型：{{.classify}}
        来源：{{.source}}{{if .cpu}}
        cpu：{{.cpu}}{{end}}{{if .container}}
        k8s容器：{{.container}}{{end}}{{if .pod}}
        k8s-pod：{{.pod}}{{end}}{{if .namespace}}
        k8s命名空间：{{.namespace}}{{end}}{{if .server_name}}
        服务名：{{.server_name}}{{end}}{{if .instance}}
        实例：{{.instance}}{{end}}
        开始时间：{{timeFormat .starts_at}}
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (29,'2022-07-29 18:00:00.000','2022-07-29 19:59:32.000',NULL,'admin(管理员)','admin(管理员)','钉钉机器人天枢监控','dd','tianshu','yes',
        '{{if eq .status "resolved"}}
        ## 【恢复信息】
        #### 主机IP：{{.address}}
        {{if .description}}#### 告警描述：{{.description}}{{end}}
        #### 告警等级：{{.severity}}
        #### 业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        #### 主机名称：{{.cmdb_host}}
        #### 当前值：{{.value}}
        #### 表达式：{{.expr}}
        #### 类型：{{.classify}}
        #### 来源：{{.source}}
        {{if .cpu}}#### cpu：{{.cpu}}{{end}}
        #### 开始时间：{{timeFormat .starts_at}}
        #### 结束时间：{{timeFormat .ends_at}}
        {{else}}
        ## 【告警信息】
        #### 主机IP：{{.address}}
        {{if .description}}#### 告警描述：{{.description}}{{end}}
        #### 告警等级：{{.severity}}
        #### 业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        #### 主机名称：{{.cmdb_host}}
        #### 当前值：{{.value}}
        #### 表达式：{{.expr}}
        #### 类型：{{.classify}}
        #### 来源：{{.source}}
        {{if .cpu}}#### cpu：{{.cpu}}{{end}}
        #### 开始时间：{{timeFormat .starts_at}}
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (30,'2022-07-29 18:00:00.000','2022-07-29 19:59:31.000',NULL,'admin(管理员)','admin(管理员)','钉钉应用天枢监控','ddapp','tianshu','yes',
        '{{if eq .status "resolved"}}
        ## 【恢复信息】
        #### 主机IP：{{.address}}
        {{if .description}}#### 告警描述：{{.description}}{{end}}
        #### 告警等级：{{.severity}}
        #### 业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        #### 主机名称：{{.cmdb_host}}
        #### 当前值：{{.value}}
        #### 表达式：{{.expr}}
        #### 类型：{{.classify}}
        #### 来源：{{.source}}
        {{if .cpu}}#### cpu：{{.cpu}}{{end}}
        #### 开始时间：{{timeFormat .starts_at}}
        #### 结束时间：{{timeFormat .ends_at}}
        {{else}}
        ## 【告警信息】
        #### 主机IP：{{.address}}
        {{if .description}}#### 告警描述：{{.description}}{{end}}
        #### 告警等级：{{.severity}}
        #### 业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        #### 主机名称：{{.cmdb_host}}
        #### 当前值：{{.value}}
        #### 表达式：{{.expr}}
        #### 类型：{{.classify}}
        #### 来源：{{.source}}
        {{if .cpu}}#### cpu：{{.cpu}}{{end}}
        #### 开始时间：{{timeFormat .starts_at}}
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (31,'2022-07-29 18:00:00.000','2022-07-29 19:59:30.000',NULL,'admin(管理员)','admin(管理员)','企业微信天枢监控','wx','tianshu','yes',
        '{{if eq .status "resolved"}}
        ## 【恢复信息】
        #### 主机IP：{{.address}}
        {{if .description}}#### 告警描述：{{.description}}{{end}}
        #### 告警等级：{{.severity}}
        #### 业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        #### 主机名称：{{.cmdb_host}}
        #### 当前值：{{.value}}
        #### 表达式：{{.expr}}
        #### 类型：{{.classify}}
        #### 来源：{{.source}}
        {{if .cpu}}#### cpu：{{.cpu}}{{end}}
        #### 开始时间：{{timeFormat .starts_at}}
        #### 结束时间：{{timeFormat .ends_at}}
        {{else}}
        ## 【告警信息】
        #### 主机IP：{{.address}}
        {{if .description}}#### 告警描述：{{.description}}{{end}}
        #### 告警等级：{{.severity}}
        #### 业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        #### 主机名称：{{.cmdb_host}}
        #### 当前值：{{.value}}
        #### 表达式：{{.expr}}
        #### 类型：{{.classify}}
        #### 来源：{{.source}}
        {{if .cpu}}#### cpu：{{.cpu}}{{end}}
        #### 开始时间：{{timeFormat .starts_at}}
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (32,'2022-07-29 18:00:00.000','2022-07-29 19:59:29.000',NULL,'admin(管理员)','admin(管理员)','企业微信应用天枢监控','wxapp','tianshu','yes',
        '{{if eq .status "resolved"}}
        ## 【恢复信息】
        #### 主机IP：{{.address}}
        {{if .description}}#### 告警描述：{{.description}}{{end}}
        #### 告警等级：{{.severity}}
        #### 业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        #### 主机名称：{{.cmdb_host}}
        #### 当前值：{{.value}}
        #### 表达式：{{.expr}}
        #### 类型：{{.classify}}
        #### 来源：{{.source}}
        {{if .cpu}}#### cpu：{{.cpu}}{{end}}
        #### 开始时间：{{timeFormat .starts_at}}
        #### 结束时间：{{timeFormat .ends_at}}
        {{else}}
        ## 【告警信息】
        #### 主机IP：{{.address}}
        {{if .description}}#### 告警描述：{{.description}}{{end}}
        #### 告警等级：{{.severity}}
        #### 业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}
        #### 主机名称：{{.cmdb_host}}
        #### 当前值：{{.value}}
        #### 表达式：{{.expr}}
        #### 类型：{{.classify}}
        #### 来源：{{.source}}
        {{if .cpu}}#### cpu：{{.cpu}}{{end}}
        #### 开始时间：{{timeFormat .starts_at}}
        {{end}}'
       );
INSERT
IGNORE INTO `codo_template` (`id`,`created_at`,`updated_at`,`deleted_at`,`created_by`,`updated_by`,`name`,`type`,`use`,`default`,`content`)
VALUES (33,'2022-07-29 18:00:00.000','2022-07-29 19:59:28.000',NULL,'admin(管理员)','admin(管理员)','邮件天枢监控','email','tianshu','yes',
        '{{if eq .status "resolved"}}
        <h2>【告警恢复】</h2>
        <h3>主机IP：{{.address}}</h3>
        <ul>
            {{if .description}}<li>告警描述：{{.description}}</li>{{end}}
            <li>告警等级：{{.severity}}</li>
            <li>业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}</li>
            <li>主机名称：{{.cmdb_host}}</li>
            <li>当前值：{{.value}}</li>
            <li>表达式：{{.expr}}</li>
            <li>类型：{{.classify}}</li>
            <li>来源：{{.source}}</li>
            {{if .cpu}}<li>cpu：{{.cpu}}</li>{{end}}
            <li>开始时间：{{timeFormat .starts_at}}</li>
            <li>结束时间：{{timeFormat .ends_at}}</li>
        </ul>
        {{else}}
        <h2>【告警信息】</h2>
        <h3>主机IP：{{.address}}</h3>
        <ul>
            {{if .description}}<li>告警描述：{{.description}}</li>{{end}}
            <li>告警等级：{{.severity}}</li>
            <li>业务拓扑：{{.cmdb_biz}}->{{.cmdb_env}}->{{.cmdb_set}}->{{.cmdb_module}}</li>
            <li>主机名称：{{.cmdb_host}}</li>
            <li>当前值：{{.value}}</li>
            <li>表达式：{{.expr}}</li>
            <li>类型：{{.classify}}</li>
            <li>来源：{{.source}}</li>
            {{if .cpu}}<li>cpu：{{.cpu}}</li>{{end}}
            <li>开始时间：{{timeFormat .starts_at}}</li>
        </ul>
        {{end}}'
       );
