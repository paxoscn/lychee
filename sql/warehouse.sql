drop table if exists m_logical_tables;

create table m_logical_tables (
id int not null auto_increment,
seller_id int not null,
layer varchar(8) not null comment 'ODS, DWD, DWM, DWS, ADS',
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
has_oneid tinyint not null default 0,
primary key(id),
unique key(seller_id, name)
);

insert into m_logical_tables values (1, 1003, 'ADS', 'ads_basic_infos', '基础标签表', '', 1);
insert into m_logical_tables values (2, 1003, 'ADS', 'ads_purchases', '订单事实表', '', 1);
insert into m_logical_tables values (3, 1003, 'ADS', 'ads_daily_purchases', '每日购买事实表', '', 1);
insert into m_logical_tables values (5, 1003, 'ADS', 'ads_app_events', 'APP使用事实表', '', 1);
insert into m_logical_tables values (6, 1003, 'ADS', 'ads_consuming_portraits', '消费标签表', '', 1);
insert into m_logical_tables values (7, 1003, 'ADS', 'ads_crowds', '人群表', '', 0);
insert into m_logical_tables values (8, 1003, 'ADS', 'ads_crowd_instances', '人群实例表', '', 0);
insert into m_logical_tables values (9, 1003, 'ADS', 'ads_crowd_instance_members', '人群实例成员表', '', 1);
insert into m_logical_tables values (10, 1003, 'ADS', 'ads_event_address', '收货地址事实表', '', 1);
insert into m_logical_tables values (11, 1003, 'ADS', 'ads_event_order', '订单事实表', '', 1);
insert into m_logical_tables values (12, 1003, 'ADS', 'ads_event_cart', '购物车事实表', '', 1);
insert into m_logical_tables values (13, 1003, 'ADS', 'ads_event_share', '分享事实表', '', 1);
insert into m_logical_tables values (14, 1003, 'ADS', 'ads_event_coupon', '优惠券事实表', '', 1);
insert into m_logical_tables values (15, 1003, 'ADS', 'ads_event_activity', '活动事实表', '', 1);
insert into m_logical_tables values (16, 1003, 'ADS', 'ads_event_app', 'APP事实表', '', 1);
insert into m_logical_tables values (17, 1003, 'ADS', 'ads_event_login', '登录注册事实表', '', 1);
insert into m_logical_tables values (18, 1003, 'ADS', 'tags_mbr_memberbaseinfo_d', '用户表', '', 1);
insert into m_logical_tables values (19, 1003, 'ADS', 'tags_mbr_customerlifecyclestage_d', '生命周期表', '', 1);
insert into m_logical_tables values (20, 1003, 'ADS', 'tags_mbr_memberbuyinfo_d', '会员价值表', '', 1);
insert into m_logical_tables values (21, 1003, 'ADS', 'tags_mbr_memberloyalty_d', '会员忠诚度表', '', 1);
insert into m_logical_tables values (22, 1003, 'ADS', 'tags_mbr_preferredbrand_d', '商品偏好表', '', 1);
insert into m_logical_tables values (23, 1003, 'ADS', 'tags_mbr_preferredcategory_d', '品类偏好表', '', 1);
insert into m_logical_tables values (24, 1003, 'ADS', 'tags_mbr_pricesensitivity_d', '价格敏感度表', '', 1);
insert into m_logical_tables values (25, 1003, 'ADS', 'tags_mbr_discountsensitivity_d', '优惠敏感度表', '', 1);
insert into m_logical_tables values (26, 1003, 'ADS', 'tags_mbr_preferredconsumptionchannel_d', '消费渠道偏好表', '', 1);
insert into m_logical_tables values (27, 1003, 'ADS', 'tags_mbr_preferredinteractchannel_d', '互动渠道偏好表', '', 1);
insert into m_logical_tables values (28, 1003, 'ADS', 'tags_mbr_preferredactiontype_d', '活动类型偏好表', '', 1);

drop table if exists m_logical_table_columns;

create table m_logical_table_columns (
id int not null auto_increment,
table_id int not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
dimension_id int not null default 0 comment '与metrics_id二选一',
dimension_group_id int not null default 0 comment '当dimension_id有值且该列属于一个维度组时有值',
metrics_id int not null default 0 comment '与dimension_id二选一',
primary key(id),
unique key(table_id, name)
);

insert into m_logical_table_columns values (1, 1, 'gender', '性别', '', 1, 0, 0);
insert into m_logical_table_columns values (2, 1, 'age', '年龄', '', 2, 0, 0);
insert into m_logical_table_columns values (3, 2, 'order_no', '订单号', '', 3, 0, 0);
insert into m_logical_table_columns values (4, 2, 'pay_time', '付款时间', '', 4, 0, 0);
insert into m_logical_table_columns values (5, 2, 'buy_channel', '购买渠道', '', 5, 0, 0);
insert into m_logical_table_columns values (6, 3, 'pay_date', '购买日期', '', 6, 0, 0);
insert into m_logical_table_columns values (7, 3, 'buy_channel', '购买渠道', '', 7, 0, 0);
insert into m_logical_table_columns values (8, 4, 'category', '字段归类', '', 8, 0, 0);
insert into m_logical_table_columns values (9, 4, 'physical_table_id', '物理表ID', '', 9, 0, 0);
insert into m_logical_table_columns values (10, 4, 'logical_table_column_id', '逻辑表列ID', '', 10, 0, 0);
insert into m_logical_table_columns values (13, 5, 'app_action_type', 'APP行为类型', '', 13, 0, 0);
insert into m_logical_table_columns values (14, 5, 'action_time', '行为时间', '', 14, 0, 0);
insert into m_logical_table_columns values (15, 2, 'order_action_type', '订单行为类型', '', 15, 0, 0);
insert into m_logical_table_columns values (16, 2, 'store_type', '业态', '', 7, 1, 0);
insert into m_logical_table_columns values (17, 3, 'store_type', '业态', '', 7, 1, 0);
insert into m_logical_table_columns values (18, 2, 'buy_value', '购买金额', '', 0, 0, 1);
insert into m_logical_table_columns values (19, 3, 'buy_value', '购买金额', '', 0, 0, 1);
insert into m_logical_table_columns values (20, 6, 'membership_level', '会员等级', '', 16, 0, 0);
insert into m_logical_table_columns values (21, 7, 'crowd_id', '人群ID', '', 17, 0, 0);
insert into m_logical_table_columns values (22, 7, 'crowd_name', '人群名称', '', 18, 0, 0);
insert into m_logical_table_columns values (23, 8, 'crowd_id', '人群ID', '', 17, 0, 0);
insert into m_logical_table_columns values (24, 8, 'instance_id', '人群实例ID', '', 19, 0, 0);
insert into m_logical_table_columns values (25, 9, 'instance_id', '人群实例ID', '', 19, 0, 0);
insert into m_logical_table_columns values (26, 1, 'tel', '电话号码', '', 20, 0, 0);
insert into m_logical_table_columns values (27, 6, 'store_type', '业态', '', 7, 1, 0);

insert into m_logical_table_columns values (90101, 10, 'a', '事件名称', '', 9001, 2, 0);
insert into m_logical_table_columns values (90102, 10, 'id_m', '用户id', '', 9002, 2, 0);
insert into m_logical_table_columns values (90103, 10, 'member_name', '会员姓名', '', 9003, 2, 0);
insert into m_logical_table_columns values (90104, 10, 'gender', '性别', '', 9004, 2, 0);
insert into m_logical_table_columns values (90105, 10, 'birthday', '生日', '', 9005, 2, 0);
insert into m_logical_table_columns values (90106, 10, 'id_p', '手机号', '', 9006, 2, 0);
insert into m_logical_table_columns values (90107, 10, 'time', '用户访问数据的时间', '', 9007, 2, 0);
insert into m_logical_table_columns values (90108, 10, 'email', '邮箱', '', 9008, 2, 0);
insert into m_logical_table_columns values (90109, 10, 'reg_date', '注册时间', '', 9009, 2, 0);
insert into m_logical_table_columns values (901010, 10, 'reg_store', '注册门店', '', 90010, 2, 0);
insert into m_logical_table_columns values (901011, 10, 'membership_level', '会员等级', '', 90011, 2, 0);
insert into m_logical_table_columns values (901012, 10, 'id_wx', '微信openid', '', 90012, 2, 0);
insert into m_logical_table_columns values (901013, 10, 'official_account', '关注公众号', '', 90013, 2, 0);
insert into m_logical_table_columns values (901014, 10, 'app_id', '应用id', '', 90014, 2, 0);
insert into m_logical_table_columns values (901015, 10, 'app_name', '应用名称', '', 90015, 2, 0);
insert into m_logical_table_columns values (901016, 10, 'province', '省', '', 90016, 2, 0);
insert into m_logical_table_columns values (901017, 10, 'city', '市', '', 90017, 2, 0);
insert into m_logical_table_columns values (901018, 10, 'area', '区', '', 90018, 2, 0);
insert into m_logical_table_columns values (901019, 10, 'ip', '用户访问时的ip', '', 90019, 2, 0);
insert into m_logical_table_columns values (901020, 10, 'timezone', '客户端本地时区', '', 90020, 2, 0);
insert into m_logical_table_columns values (901021, 10, 'mac', 'MAC地址', '', 90021, 2, 0);
insert into m_logical_table_columns values (901022, 10, 'browser', '浏览器名称', '', 90022, 2, 0);
insert into m_logical_table_columns values (901023, 10, 'os', '操作系统名称', '', 90023, 2, 0);
insert into m_logical_table_columns values (901024, 10, 'net', '网络类型', '', 90024, 2, 0);
insert into m_logical_table_columns values (901025, 10, 'carrier', '运营商', '', 90025, 2, 0);
insert into m_logical_table_columns values (901026, 10, 'model', '设备型号', '', 90026, 2, 0);
insert into m_logical_table_columns values (901027, 10, 'sid', '会话id', '', 90027, 2, 0);
insert into m_logical_table_columns values (901028, 10, 'cookie', '客户端cookie唯一标识', '', 90028, 2, 0);
insert into m_logical_table_columns values (901029, 10, 'agent', '客户端信息', '', 90029, 2, 0);
insert into m_logical_table_columns values (901030, 10, 'ute', '客户系统用户类型', '', 90030, 2, 0);
insert into m_logical_table_columns values (901032, 10, 'channel_id', '渠道id', '', 90032, 2, 0);
insert into m_logical_table_columns values (901033, 10, 'channel_name', '渠道名称', '', 90033, 2, 0);
insert into m_logical_table_columns values (901034, 10, 'current_url', '当前页面地址', '', 90034, 2, 0);
insert into m_logical_table_columns values (901035, 10, 'guest_url', '访问的页面地址', '', 90035, 2, 0);
insert into m_logical_table_columns values (901036, 10, 'source_url', '跳转来源地址', '', 90036, 2, 0);
insert into m_logical_table_columns values (901037, 10, 'source_id', '页面来源id', '', 90037, 2, 0);
insert into m_logical_table_columns values (901038, 10, 'source_name', '页面来源名称', '', 90038, 2, 0);
insert into m_logical_table_columns values (901039, 10, 'page_id', '页面id', '', 90039, 2, 0);
insert into m_logical_table_columns values (901040, 10, 'page_name', '页面名称', '', 90040, 2, 0);
insert into m_logical_table_columns values (901041, 10, 'assembly_id', '组件id', '', 90041, 2, 0);
insert into m_logical_table_columns values (901042, 10, 'assembly_name', '组件名称', '', 90042, 2, 0);
insert into m_logical_table_columns values (901043, 10, 'jump_page_id', '要跳转的页面id', '', 90043, 2, 0);
insert into m_logical_table_columns values (901044, 10, 'jump_page_name', '要跳转的页面名称', '', 90044, 2, 0);
insert into m_logical_table_columns values (901045, 10, 'a_type', '事件类型', '', 90045, 2, 0);
insert into m_logical_table_columns values (901046, 10, 'p_type', '组件化：1', '', 90046, 2, 0);
insert into m_logical_table_columns values (901047, 10, 'a_source', '事件来源', '', 90047, 2, 0);
insert into m_logical_table_columns values (901048, 10, 'version', '埋点方案版本', '', 90048, 2, 0);
insert into m_logical_table_columns values (901101, 10, 'shop_id', '关联门店', '', 90101, 0, 0);
insert into m_logical_table_columns values (901102, 10, 'receiver_address', '收货地址', '', 90102, 0, 0);

insert into m_logical_table_columns values (90111, 11, 'a', '事件名称', '', 9001, 2, 0);
insert into m_logical_table_columns values (90112, 11, 'id_m', '用户id', '', 9002, 2, 0);
insert into m_logical_table_columns values (90113, 11, 'member_name', '会员姓名', '', 9003, 2, 0);
insert into m_logical_table_columns values (90114, 11, 'gender', '性别', '', 9004, 2, 0);
insert into m_logical_table_columns values (90115, 11, 'birthday', '生日', '', 9005, 2, 0);
insert into m_logical_table_columns values (90116, 11, 'id_p', '手机号', '', 9006, 2, 0);
insert into m_logical_table_columns values (90117, 11, 'time', '用户访问数据的时间', '', 9007, 2, 0);
insert into m_logical_table_columns values (90118, 11, 'email', '邮箱', '', 9008, 2, 0);
insert into m_logical_table_columns values (90119, 11, 'reg_date', '注册时间', '', 9009, 2, 0);
insert into m_logical_table_columns values (901110, 11, 'reg_store', '注册门店', '', 90010, 2, 0);
insert into m_logical_table_columns values (901111, 11, 'membership_level', '会员等级', '', 90011, 2, 0);
insert into m_logical_table_columns values (901112, 11, 'id_wx', '微信openid', '', 90012, 2, 0);
insert into m_logical_table_columns values (901113, 11, 'official_account', '关注公众号', '', 90013, 2, 0);
insert into m_logical_table_columns values (901114, 11, 'app_id', '应用id', '', 90014, 2, 0);
insert into m_logical_table_columns values (901115, 11, 'app_name', '应用名称', '', 90015, 2, 0);
insert into m_logical_table_columns values (901116, 11, 'province', '省', '', 90016, 2, 0);
insert into m_logical_table_columns values (901117, 11, 'city', '市', '', 90017, 2, 0);
insert into m_logical_table_columns values (901118, 11, 'area', '区', '', 90018, 2, 0);
insert into m_logical_table_columns values (901119, 11, 'ip', '用户访问时的ip', '', 90019, 2, 0);
insert into m_logical_table_columns values (901120, 11, 'timezone', '客户端本地时区', '', 90020, 2, 0);
insert into m_logical_table_columns values (901121, 11, 'mac', 'MAC地址', '', 90021, 2, 0);
insert into m_logical_table_columns values (901122, 11, 'browser', '浏览器名称', '', 90022, 2, 0);
insert into m_logical_table_columns values (901123, 11, 'os', '操作系统名称', '', 90023, 2, 0);
insert into m_logical_table_columns values (901124, 11, 'net', '网络类型', '', 90024, 2, 0);
insert into m_logical_table_columns values (901125, 11, 'carrier', '运营商', '', 90025, 2, 0);
insert into m_logical_table_columns values (901126, 11, 'model', '设备型号', '', 90026, 2, 0);
insert into m_logical_table_columns values (901127, 11, 'sid', '会话id', '', 90027, 2, 0);
insert into m_logical_table_columns values (901128, 11, 'cookie', '客户端cookie唯一标识', '', 90028, 2, 0);
insert into m_logical_table_columns values (901129, 11, 'agent', '客户端信息', '', 90029, 2, 0);
insert into m_logical_table_columns values (901130, 11, 'ute', '客户系统用户类型', '', 90030, 2, 0);
insert into m_logical_table_columns values (901132, 11, 'channel_id', '渠道id', '', 90032, 2, 0);
insert into m_logical_table_columns values (901133, 11, 'channel_name', '渠道名称', '', 90033, 2, 0);
insert into m_logical_table_columns values (901134, 11, 'current_url', '当前页面地址', '', 90034, 2, 0);
insert into m_logical_table_columns values (901135, 11, 'guest_url', '访问的页面地址', '', 90035, 2, 0);
insert into m_logical_table_columns values (901136, 11, 'source_url', '跳转来源地址', '', 90036, 2, 0);
insert into m_logical_table_columns values (901137, 11, 'source_id', '页面来源id', '', 90037, 2, 0);
insert into m_logical_table_columns values (901138, 11, 'source_name', '页面来源名称', '', 90038, 2, 0);
insert into m_logical_table_columns values (901139, 11, 'page_id', '页面id', '', 90039, 2, 0);
insert into m_logical_table_columns values (901140, 11, 'page_name', '页面名称', '', 90040, 2, 0);
insert into m_logical_table_columns values (901141, 11, 'assembly_id', '组件id', '', 90041, 2, 0);
insert into m_logical_table_columns values (901142, 11, 'assembly_name', '组件名称', '', 90042, 2, 0);
insert into m_logical_table_columns values (901143, 11, 'jump_page_id', '要跳转的页面id', '', 90043, 2, 0);
insert into m_logical_table_columns values (901144, 11, 'jump_page_name', '要跳转的页面名称', '', 90044, 2, 0);
insert into m_logical_table_columns values (901145, 11, 'a_type', '事件类型', '', 90045, 2, 0);
insert into m_logical_table_columns values (901146, 11, 'p_type', '组件化：1', '', 90046, 2, 0);
insert into m_logical_table_columns values (901147, 11, 'a_source', '事件来源', '', 90047, 2, 0);
insert into m_logical_table_columns values (901148, 11, 'version', '埋点方案版本', '', 90048, 2, 0);
insert into m_logical_table_columns values (9122, 11, 'coupon_id', '优惠券id', '', 9022, 0, 0);
insert into m_logical_table_columns values (9123, 11, 'discount', '折扣金额', '', 9023, 0, 0);
insert into m_logical_table_columns values (9124, 11, 'is_buy_again', '是否再次购买', '', 9024, 0, 0);
insert into m_logical_table_columns values (9125, 11, 'is_coupon_used', '是否使用优惠券', '', 9025, 0, 0);
insert into m_logical_table_columns values (9126, 11, 'is_point_used', '是否使用积分', '', 9026, 0, 0);
insert into m_logical_table_columns values (9127, 11, 'is_refund', '是否退款', '', 9027, 0, 0);
insert into m_logical_table_columns values (9128, 11, 'is_return', '是否退货', '', 9028, 0, 0);
insert into m_logical_table_columns values (9129, 11, 'order_id', '订单号', '', 9029, 0, 0);
insert into m_logical_table_columns values (91210, 11, 'order_status', '订单状态', '', 90210, 0, 0);
insert into m_logical_table_columns values (91211, 11, 'payment_amount', '实付金额', '', 0, 0, 2);
insert into m_logical_table_columns values (91212, 11, 'payment_method', '支付方式', '', 90212, 0, 0);
insert into m_logical_table_columns values (91213, 11, 'payment_time', '支付时间', '', 90213, 0, 0);
insert into m_logical_table_columns values (91214, 11, 'points_consumption', '积分消耗', '', 0, 0, 3);
insert into m_logical_table_columns values (91215, 11, 'product_amount', '应付金额', '', 0, 0, 4);
insert into m_logical_table_columns values (91216, 11, 'product_id', '商品id', '', 90216, 0, 0);
insert into m_logical_table_columns values (91217, 11, 'product_num', '商品数量', '', 0, 0, 5);
insert into m_logical_table_columns values (91218, 11, 'receiver_address', '收货地址', '', 90102, 0, 0);
insert into m_logical_table_columns values (91219, 11, 'refund_amount', '退款金额', '', 0, 0, 6);
insert into m_logical_table_columns values (91220, 11, 'return_order_id', '退单号', '', 90220, 0, 0);
insert into m_logical_table_columns values (91221, 11, 'return_product_id', '退单商品id', '', 90221, 0, 0);
insert into m_logical_table_columns values (91222, 11, 'to_shop_or_home_delivery', '到店/到家', '', 90222, 0, 0);

insert into m_logical_table_columns values (90121, 12, 'a', '事件名称', '', 9001, 2, 0);
insert into m_logical_table_columns values (90122, 12, 'id_m', '用户id', '', 9002, 2, 0);
insert into m_logical_table_columns values (90123, 12, 'member_name', '会员姓名', '', 9003, 2, 0);
insert into m_logical_table_columns values (90124, 12, 'gender', '性别', '', 9004, 2, 0);
insert into m_logical_table_columns values (90125, 12, 'birthday', '生日', '', 9005, 2, 0);
insert into m_logical_table_columns values (90126, 12, 'id_p', '手机号', '', 9006, 2, 0);
insert into m_logical_table_columns values (90127, 12, 'time', '用户访问数据的时间', '', 9007, 2, 0);
insert into m_logical_table_columns values (90128, 12, 'email', '邮箱', '', 9008, 2, 0);
insert into m_logical_table_columns values (90129, 12, 'reg_date', '注册时间', '', 9009, 2, 0);
insert into m_logical_table_columns values (901210, 12, 'reg_store', '注册门店', '', 90010, 2, 0);
insert into m_logical_table_columns values (901211, 12, 'membership_level', '会员等级', '', 90011, 2, 0);
insert into m_logical_table_columns values (901212, 12, 'id_wx', '微信openid', '', 90012, 2, 0);
insert into m_logical_table_columns values (901213, 12, 'official_account', '关注公众号', '', 90013, 2, 0);
insert into m_logical_table_columns values (901214, 12, 'app_id', '应用id', '', 90014, 2, 0);
insert into m_logical_table_columns values (901215, 12, 'app_name', '应用名称', '', 90015, 2, 0);
insert into m_logical_table_columns values (901216, 12, 'province', '省', '', 90016, 2, 0);
insert into m_logical_table_columns values (901217, 12, 'city', '市', '', 90017, 2, 0);
insert into m_logical_table_columns values (901218, 12, 'area', '区', '', 90018, 2, 0);
insert into m_logical_table_columns values (901219, 12, 'ip', '用户访问时的ip', '', 90019, 2, 0);
insert into m_logical_table_columns values (901220, 12, 'timezone', '客户端本地时区', '', 90020, 2, 0);
insert into m_logical_table_columns values (901221, 12, 'mac', 'MAC地址', '', 90021, 2, 0);
insert into m_logical_table_columns values (901222, 12, 'browser', '浏览器名称', '', 90022, 2, 0);
insert into m_logical_table_columns values (901223, 12, 'os', '操作系统名称', '', 90023, 2, 0);
insert into m_logical_table_columns values (901224, 12, 'net', '网络类型', '', 90024, 2, 0);
insert into m_logical_table_columns values (901225, 12, 'carrier', '运营商', '', 90025, 2, 0);
insert into m_logical_table_columns values (901226, 12, 'model', '设备型号', '', 90026, 2, 0);
insert into m_logical_table_columns values (901227, 12, 'sid', '会话id', '', 90027, 2, 0);
insert into m_logical_table_columns values (901228, 12, 'cookie', '客户端cookie唯一标识', '', 90028, 2, 0);
insert into m_logical_table_columns values (901229, 12, 'agent', '客户端信息', '', 90029, 2, 0);
insert into m_logical_table_columns values (901230, 12, 'ute', '客户系统用户类型', '', 90030, 2, 0);
insert into m_logical_table_columns values (901232, 12, 'channel_id', '渠道id', '', 90032, 2, 0);
insert into m_logical_table_columns values (901233, 12, 'channel_name', '渠道名称', '', 90033, 2, 0);
insert into m_logical_table_columns values (901234, 12, 'current_url', '当前页面地址', '', 90034, 2, 0);
insert into m_logical_table_columns values (901235, 12, 'guest_url', '访问的页面地址', '', 90035, 2, 0);
insert into m_logical_table_columns values (901236, 12, 'source_url', '跳转来源地址', '', 90036, 2, 0);
insert into m_logical_table_columns values (901237, 12, 'source_id', '页面来源id', '', 90037, 2, 0);
insert into m_logical_table_columns values (901238, 12, 'source_name', '页面来源名称', '', 90038, 2, 0);
insert into m_logical_table_columns values (901239, 12, 'page_id', '页面id', '', 90039, 2, 0);
insert into m_logical_table_columns values (901240, 12, 'page_name', '页面名称', '', 90040, 2, 0);
insert into m_logical_table_columns values (901241, 12, 'assembly_id', '组件id', '', 90041, 2, 0);
insert into m_logical_table_columns values (901242, 12, 'assembly_name', '组件名称', '', 90042, 2, 0);
insert into m_logical_table_columns values (901243, 12, 'jump_page_id', '要跳转的页面id', '', 90043, 2, 0);
insert into m_logical_table_columns values (901244, 12, 'jump_page_name', '要跳转的页面名称', '', 90044, 2, 0);
insert into m_logical_table_columns values (901245, 12, 'a_type', '事件类型', '', 90045, 2, 0);
insert into m_logical_table_columns values (901246, 12, 'p_type', '组件化：1', '', 90046, 2, 0);
insert into m_logical_table_columns values (901247, 12, 'a_source', '事件来源', '', 90047, 2, 0);
insert into m_logical_table_columns values (901248, 12, 'version', '埋点方案版本', '', 90048, 2, 0);
insert into m_logical_table_columns values (9131, 12, 'is_add_to_shoppingcart', '是否加入购物车', '', 9031, 0, 0);
insert into m_logical_table_columns values (9132, 12, 'is_flash_sale', '是否秒杀', '', 9032, 0, 0);
insert into m_logical_table_columns values (9133, 12, 'is_in_stock', '商品是否上架', '', 9033, 0, 0);
insert into m_logical_table_columns values (9134, 12, 'is_modify_good_num_in_shoppingcart', '是否购物车商品增加减少数量', '', 9034, 0, 0);
insert into m_logical_table_columns values (9136, 12, 'product_id', '商品id', '', 90216, 0, 0);

insert into m_logical_table_columns values (90131, 13, 'a', '事件名称', '', 9001, 2, 0);
insert into m_logical_table_columns values (90132, 13, 'id_m', '用户id', '', 9002, 2, 0);
insert into m_logical_table_columns values (90133, 13, 'member_name', '会员姓名', '', 9003, 2, 0);
insert into m_logical_table_columns values (90134, 13, 'gender', '性别', '', 9004, 2, 0);
insert into m_logical_table_columns values (90135, 13, 'birthday', '生日', '', 9005, 2, 0);
insert into m_logical_table_columns values (90136, 13, 'id_p', '手机号', '', 9006, 2, 0);
insert into m_logical_table_columns values (90137, 13, 'time', '用户访问数据的时间', '', 9007, 2, 0);
insert into m_logical_table_columns values (90138, 13, 'email', '邮箱', '', 9008, 2, 0);
insert into m_logical_table_columns values (90139, 13, 'reg_date', '注册时间', '', 9009, 2, 0);
insert into m_logical_table_columns values (901310, 13, 'reg_store', '注册门店', '', 90010, 2, 0);
insert into m_logical_table_columns values (901311, 13, 'membership_level', '会员等级', '', 90011, 2, 0);
insert into m_logical_table_columns values (901312, 13, 'id_wx', '微信openid', '', 90012, 2, 0);
insert into m_logical_table_columns values (901313, 13, 'official_account', '关注公众号', '', 90013, 2, 0);
insert into m_logical_table_columns values (901314, 13, 'app_id', '应用id', '', 90014, 2, 0);
insert into m_logical_table_columns values (901315, 13, 'app_name', '应用名称', '', 90015, 2, 0);
insert into m_logical_table_columns values (901316, 13, 'province', '省', '', 90016, 2, 0);
insert into m_logical_table_columns values (901317, 13, 'city', '市', '', 90017, 2, 0);
insert into m_logical_table_columns values (901318, 13, 'area', '区', '', 90018, 2, 0);
insert into m_logical_table_columns values (901319, 13, 'ip', '用户访问时的ip', '', 90019, 2, 0);
insert into m_logical_table_columns values (901320, 13, 'timezone', '客户端本地时区', '', 90020, 2, 0);
insert into m_logical_table_columns values (901321, 13, 'mac', 'MAC地址', '', 90021, 2, 0);
insert into m_logical_table_columns values (901322, 13, 'browser', '浏览器名称', '', 90022, 2, 0);
insert into m_logical_table_columns values (901323, 13, 'os', '操作系统名称', '', 90023, 2, 0);
insert into m_logical_table_columns values (901324, 13, 'net', '网络类型', '', 90024, 2, 0);
insert into m_logical_table_columns values (901325, 13, 'carrier', '运营商', '', 90025, 2, 0);
insert into m_logical_table_columns values (901326, 13, 'model', '设备型号', '', 90026, 2, 0);
insert into m_logical_table_columns values (901327, 13, 'sid', '会话id', '', 90027, 2, 0);
insert into m_logical_table_columns values (901328, 13, 'cookie', '客户端cookie唯一标识', '', 90028, 2, 0);
insert into m_logical_table_columns values (901329, 13, 'agent', '客户端信息', '', 90029, 2, 0);
insert into m_logical_table_columns values (901330, 13, 'ute', '客户系统用户类型', '', 90030, 2, 0);
insert into m_logical_table_columns values (901332, 13, 'channel_id', '渠道id', '', 90032, 2, 0);
insert into m_logical_table_columns values (901333, 13, 'channel_name', '渠道名称', '', 90033, 2, 0);
insert into m_logical_table_columns values (901334, 13, 'current_url', '当前页面地址', '', 90034, 2, 0);
insert into m_logical_table_columns values (901335, 13, 'guest_url', '访问的页面地址', '', 90035, 2, 0);
insert into m_logical_table_columns values (901336, 13, 'source_url', '跳转来源地址', '', 90036, 2, 0);
insert into m_logical_table_columns values (901337, 13, 'source_id', '页面来源id', '', 90037, 2, 0);
insert into m_logical_table_columns values (901338, 13, 'source_name', '页面来源名称', '', 90038, 2, 0);
insert into m_logical_table_columns values (901339, 13, 'page_id', '页面id', '', 90039, 2, 0);
insert into m_logical_table_columns values (901340, 13, 'page_name', '页面名称', '', 90040, 2, 0);
insert into m_logical_table_columns values (901341, 13, 'assembly_id', '组件id', '', 90041, 2, 0);
insert into m_logical_table_columns values (901342, 13, 'assembly_name', '组件名称', '', 90042, 2, 0);
insert into m_logical_table_columns values (901343, 13, 'jump_page_id', '要跳转的页面id', '', 90043, 2, 0);
insert into m_logical_table_columns values (901344, 13, 'jump_page_name', '要跳转的页面名称', '', 90044, 2, 0);
insert into m_logical_table_columns values (901345, 13, 'a_type', '事件类型', '', 90045, 2, 0);
insert into m_logical_table_columns values (901346, 13, 'p_type', '组件化：1', '', 90046, 2, 0);
insert into m_logical_table_columns values (901347, 13, 'a_source', '事件来源', '', 90047, 2, 0);
insert into m_logical_table_columns values (901348, 13, 'version', '埋点方案版本', '', 90048, 2, 0);
insert into m_logical_table_columns values (9141, 13, 'is_flash_sale', '是否秒杀', '', 9032, 0, 0);
insert into m_logical_table_columns values (9142, 13, 'is_in_stock', '商品是否上架', '', 9033, 0, 0);
insert into m_logical_table_columns values (9143, 13, 'product_id', '商品id', '', 90216, 0, 0);
insert into m_logical_table_columns values (9144, 13, 'share_channel', '分享方式', '', 9044, 0, 0);

insert into m_logical_table_columns values (90141, 14, 'a', '事件名称', '', 9001, 2, 0);
insert into m_logical_table_columns values (90142, 14, 'id_m', '用户id', '', 9002, 2, 0);
insert into m_logical_table_columns values (90143, 14, 'member_name', '会员姓名', '', 9003, 2, 0);
insert into m_logical_table_columns values (90144, 14, 'gender', '性别', '', 9004, 2, 0);
insert into m_logical_table_columns values (90145, 14, 'birthday', '生日', '', 9005, 2, 0);
insert into m_logical_table_columns values (90146, 14, 'id_p', '手机号', '', 9006, 2, 0);
insert into m_logical_table_columns values (90147, 14, 'time', '用户访问数据的时间', '', 9007, 2, 0);
insert into m_logical_table_columns values (90148, 14, 'email', '邮箱', '', 9008, 2, 0);
insert into m_logical_table_columns values (90149, 14, 'reg_date', '注册时间', '', 9009, 2, 0);
insert into m_logical_table_columns values (901410, 14, 'reg_store', '注册门店', '', 90010, 2, 0);
insert into m_logical_table_columns values (901411, 14, 'membership_level', '会员等级', '', 90011, 2, 0);
insert into m_logical_table_columns values (901412, 14, 'id_wx', '微信openid', '', 90012, 2, 0);
insert into m_logical_table_columns values (901413, 14, 'official_account', '关注公众号', '', 90013, 2, 0);
insert into m_logical_table_columns values (901414, 14, 'app_id', '应用id', '', 90014, 2, 0);
insert into m_logical_table_columns values (901415, 14, 'app_name', '应用名称', '', 90015, 2, 0);
insert into m_logical_table_columns values (901416, 14, 'province', '省', '', 90016, 2, 0);
insert into m_logical_table_columns values (901417, 14, 'city', '市', '', 90017, 2, 0);
insert into m_logical_table_columns values (901418, 14, 'area', '区', '', 90018, 2, 0);
insert into m_logical_table_columns values (901419, 14, 'ip', '用户访问时的ip', '', 90019, 2, 0);
insert into m_logical_table_columns values (901420, 14, 'timezone', '客户端本地时区', '', 90020, 2, 0);
insert into m_logical_table_columns values (901421, 14, 'mac', 'MAC地址', '', 90021, 2, 0);
insert into m_logical_table_columns values (901422, 14, 'browser', '浏览器名称', '', 90022, 2, 0);
insert into m_logical_table_columns values (901423, 14, 'os', '操作系统名称', '', 90023, 2, 0);
insert into m_logical_table_columns values (901424, 14, 'net', '网络类型', '', 90024, 2, 0);
insert into m_logical_table_columns values (901425, 14, 'carrier', '运营商', '', 90025, 2, 0);
insert into m_logical_table_columns values (901426, 14, 'model', '设备型号', '', 90026, 2, 0);
insert into m_logical_table_columns values (901427, 14, 'sid', '会话id', '', 90027, 2, 0);
insert into m_logical_table_columns values (901428, 14, 'cookie', '客户端cookie唯一标识', '', 90028, 2, 0);
insert into m_logical_table_columns values (901429, 14, 'agent', '客户端信息', '', 90029, 2, 0);
insert into m_logical_table_columns values (901430, 14, 'ute', '客户系统用户类型', '', 90030, 2, 0);
insert into m_logical_table_columns values (901432, 14, 'channel_id', '渠道id', '', 90032, 2, 0);
insert into m_logical_table_columns values (901433, 14, 'channel_name', '渠道名称', '', 90033, 2, 0);
insert into m_logical_table_columns values (901434, 14, 'current_url', '当前页面地址', '', 90034, 2, 0);
insert into m_logical_table_columns values (901435, 14, 'guest_url', '访问的页面地址', '', 90035, 2, 0);
insert into m_logical_table_columns values (901436, 14, 'source_url', '跳转来源地址', '', 90036, 2, 0);
insert into m_logical_table_columns values (901437, 14, 'source_id', '页面来源id', '', 90037, 2, 0);
insert into m_logical_table_columns values (901438, 14, 'source_name', '页面来源名称', '', 90038, 2, 0);
insert into m_logical_table_columns values (901439, 14, 'page_id', '页面id', '', 90039, 2, 0);
insert into m_logical_table_columns values (901440, 14, 'page_name', '页面名称', '', 90040, 2, 0);
insert into m_logical_table_columns values (901441, 14, 'assembly_id', '组件id', '', 90041, 2, 0);
insert into m_logical_table_columns values (901442, 14, 'assembly_name', '组件名称', '', 90042, 2, 0);
insert into m_logical_table_columns values (901443, 14, 'jump_page_id', '要跳转的页面id', '', 90043, 2, 0);
insert into m_logical_table_columns values (901444, 14, 'jump_page_name', '要跳转的页面名称', '', 90044, 2, 0);
insert into m_logical_table_columns values (901445, 14, 'a_type', '事件类型', '', 90045, 2, 0);
insert into m_logical_table_columns values (901446, 14, 'p_type', '组件化：1', '', 90046, 2, 0);
insert into m_logical_table_columns values (901447, 14, 'a_source', '事件来源', '', 90047, 2, 0);
insert into m_logical_table_columns values (901448, 14, 'version', '埋点方案版本', '', 90048, 2, 0);
insert into m_logical_table_columns values (9151, 14, 'coupon_id', '优惠券id', '', 9022, 0, 0);
insert into m_logical_table_columns values (9152, 14, 'number_received', '领取数量', '', 0, 0, 7);
insert into m_logical_table_columns values (9153, 14, 'order_id', '使用订单id', '', 9029, 0, 0);
insert into m_logical_table_columns values (9154, 14, 'used_num', '使用数量', '', 0, 0, 8);

insert into m_logical_table_columns values (90151, 15, 'a', '事件名称', '', 9001, 2, 0);
insert into m_logical_table_columns values (90152, 15, 'id_m', '用户id', '', 9002, 2, 0);
insert into m_logical_table_columns values (90153, 15, 'member_name', '会员姓名', '', 9003, 2, 0);
insert into m_logical_table_columns values (90154, 15, 'gender', '性别', '', 9004, 2, 0);
insert into m_logical_table_columns values (90155, 15, 'birthday', '生日', '', 9005, 2, 0);
insert into m_logical_table_columns values (90156, 15, 'id_p', '手机号', '', 9006, 2, 0);
insert into m_logical_table_columns values (90157, 15, 'time', '用户访问数据的时间', '', 9007, 2, 0);
insert into m_logical_table_columns values (90158, 15, 'email', '邮箱', '', 9008, 2, 0);
insert into m_logical_table_columns values (90159, 15, 'reg_date', '注册时间', '', 9009, 2, 0);
insert into m_logical_table_columns values (901510, 15, 'reg_store', '注册门店', '', 90010, 2, 0);
insert into m_logical_table_columns values (901511, 15, 'membership_level', '会员等级', '', 90011, 2, 0);
insert into m_logical_table_columns values (901512, 15, 'id_wx', '微信openid', '', 90012, 2, 0);
insert into m_logical_table_columns values (901513, 15, 'official_account', '关注公众号', '', 90013, 2, 0);
insert into m_logical_table_columns values (901514, 15, 'app_id', '应用id', '', 90014, 2, 0);
insert into m_logical_table_columns values (901515, 15, 'app_name', '应用名称', '', 90015, 2, 0);
insert into m_logical_table_columns values (901516, 15, 'province', '省', '', 90016, 2, 0);
insert into m_logical_table_columns values (901517, 15, 'city', '市', '', 90017, 2, 0);
insert into m_logical_table_columns values (901518, 15, 'area', '区', '', 90018, 2, 0);
insert into m_logical_table_columns values (901519, 15, 'ip', '用户访问时的ip', '', 90019, 2, 0);
insert into m_logical_table_columns values (901520, 15, 'timezone', '客户端本地时区', '', 90020, 2, 0);
insert into m_logical_table_columns values (901521, 15, 'mac', 'MAC地址', '', 90021, 2, 0);
insert into m_logical_table_columns values (901522, 15, 'browser', '浏览器名称', '', 90022, 2, 0);
insert into m_logical_table_columns values (901523, 15, 'os', '操作系统名称', '', 90023, 2, 0);
insert into m_logical_table_columns values (901524, 15, 'net', '网络类型', '', 90024, 2, 0);
insert into m_logical_table_columns values (901525, 15, 'carrier', '运营商', '', 90025, 2, 0);
insert into m_logical_table_columns values (901526, 15, 'model', '设备型号', '', 90026, 2, 0);
insert into m_logical_table_columns values (901527, 15, 'sid', '会话id', '', 90027, 2, 0);
insert into m_logical_table_columns values (901528, 15, 'cookie', '客户端cookie唯一标识', '', 90028, 2, 0);
insert into m_logical_table_columns values (901529, 15, 'agent', '客户端信息', '', 90029, 2, 0);
insert into m_logical_table_columns values (901530, 15, 'ute', '客户系统用户类型', '', 90030, 2, 0);
insert into m_logical_table_columns values (901532, 15, 'channel_id', '渠道id', '', 90032, 2, 0);
insert into m_logical_table_columns values (901533, 15, 'channel_name', '渠道名称', '', 90033, 2, 0);
insert into m_logical_table_columns values (901534, 15, 'current_url', '当前页面地址', '', 90034, 2, 0);
insert into m_logical_table_columns values (901535, 15, 'guest_url', '访问的页面地址', '', 90035, 2, 0);
insert into m_logical_table_columns values (901536, 15, 'source_url', '跳转来源地址', '', 90036, 2, 0);
insert into m_logical_table_columns values (901537, 15, 'source_id', '页面来源id', '', 90037, 2, 0);
insert into m_logical_table_columns values (901538, 15, 'source_name', '页面来源名称', '', 90038, 2, 0);
insert into m_logical_table_columns values (901539, 15, 'page_id', '页面id', '', 90039, 2, 0);
insert into m_logical_table_columns values (901540, 15, 'page_name', '页面名称', '', 90040, 2, 0);
insert into m_logical_table_columns values (901541, 15, 'assembly_id', '组件id', '', 90041, 2, 0);
insert into m_logical_table_columns values (901542, 15, 'assembly_name', '组件名称', '', 90042, 2, 0);
insert into m_logical_table_columns values (901543, 15, 'jump_page_id', '要跳转的页面id', '', 90043, 2, 0);
insert into m_logical_table_columns values (901544, 15, 'jump_page_name', '要跳转的页面名称', '', 90044, 2, 0);
insert into m_logical_table_columns values (901545, 15, 'a_type', '事件类型', '', 90045, 2, 0);
insert into m_logical_table_columns values (901546, 15, 'p_type', '组件化：1', '', 90046, 2, 0);
insert into m_logical_table_columns values (901547, 15, 'a_source', '事件来源', '', 90047, 2, 0);
insert into m_logical_table_columns values (901548, 15, 'version', '埋点方案版本', '', 90048, 2, 0);
insert into m_logical_table_columns values (9161, 15, 'activity_id', '活动id', '', 9061, 0, 0);
insert into m_logical_table_columns values (9162, 15, 'activity_name', '活动名称', '', 9062, 0, 0);
insert into m_logical_table_columns values (9164, 15, 'coupon_id', '优惠券id', '', 9022, 0, 0);
insert into m_logical_table_columns values (9165, 15, 'product_id', '关联活动商品', '', 90216, 0, 0);

insert into m_logical_table_columns values (90161, 16, 'a', '事件名称', '', 9001, 2, 0);
insert into m_logical_table_columns values (90162, 16, 'id_m', '用户id', '', 9002, 2, 0);
insert into m_logical_table_columns values (90163, 16, 'member_name', '会员姓名', '', 9003, 2, 0);
insert into m_logical_table_columns values (90164, 16, 'gender', '性别', '', 9004, 2, 0);
insert into m_logical_table_columns values (90165, 16, 'birthday', '生日', '', 9005, 2, 0);
insert into m_logical_table_columns values (90166, 16, 'id_p', '手机号', '', 9006, 2, 0);
insert into m_logical_table_columns values (90167, 16, 'time', '用户访问数据的时间', '', 9007, 2, 0);
insert into m_logical_table_columns values (90168, 16, 'email', '邮箱', '', 9008, 2, 0);
insert into m_logical_table_columns values (90169, 16, 'reg_date', '注册时间', '', 9009, 2, 0);
insert into m_logical_table_columns values (901610, 16, 'reg_store', '注册门店', '', 90010, 2, 0);
insert into m_logical_table_columns values (901611, 16, 'membership_level', '会员等级', '', 90011, 2, 0);
insert into m_logical_table_columns values (901612, 16, 'id_wx', '微信openid', '', 90012, 2, 0);
insert into m_logical_table_columns values (901613, 16, 'official_account', '关注公众号', '', 90013, 2, 0);
insert into m_logical_table_columns values (901614, 16, 'app_id', '应用id', '', 90014, 2, 0);
insert into m_logical_table_columns values (901615, 16, 'app_name', '应用名称', '', 90015, 2, 0);
insert into m_logical_table_columns values (901616, 16, 'province', '省', '', 90016, 2, 0);
insert into m_logical_table_columns values (901617, 16, 'city', '市', '', 90017, 2, 0);
insert into m_logical_table_columns values (901618, 16, 'area', '区', '', 90018, 2, 0);
insert into m_logical_table_columns values (901619, 16, 'ip', '用户访问时的ip', '', 90019, 2, 0);
insert into m_logical_table_columns values (901620, 16, 'timezone', '客户端本地时区', '', 90020, 2, 0);
insert into m_logical_table_columns values (901621, 16, 'mac', 'MAC地址', '', 90021, 2, 0);
insert into m_logical_table_columns values (901622, 16, 'browser', '浏览器名称', '', 90022, 2, 0);
insert into m_logical_table_columns values (901623, 16, 'os', '操作系统名称', '', 90023, 2, 0);
insert into m_logical_table_columns values (901624, 16, 'net', '网络类型', '', 90024, 2, 0);
insert into m_logical_table_columns values (901625, 16, 'carrier', '运营商', '', 90025, 2, 0);
insert into m_logical_table_columns values (901626, 16, 'model', '设备型号', '', 90026, 2, 0);
insert into m_logical_table_columns values (901627, 16, 'sid', '会话id', '', 90027, 2, 0);
insert into m_logical_table_columns values (901628, 16, 'cookie', '客户端cookie唯一标识', '', 90028, 2, 0);
insert into m_logical_table_columns values (901629, 16, 'agent', '客户端信息', '', 90029, 2, 0);
insert into m_logical_table_columns values (901630, 16, 'ute', '客户系统用户类型', '', 90030, 2, 0);
insert into m_logical_table_columns values (901632, 16, 'channel_id', '渠道id', '', 90032, 2, 0);
insert into m_logical_table_columns values (901633, 16, 'channel_name', '渠道名称', '', 90033, 2, 0);
insert into m_logical_table_columns values (901634, 16, 'current_url', '当前页面地址', '', 90034, 2, 0);
insert into m_logical_table_columns values (901635, 16, 'guest_url', '访问的页面地址', '', 90035, 2, 0);
insert into m_logical_table_columns values (901636, 16, 'source_url', '跳转来源地址', '', 90036, 2, 0);
insert into m_logical_table_columns values (901637, 16, 'source_id', '页面来源id', '', 90037, 2, 0);
insert into m_logical_table_columns values (901638, 16, 'source_name', '页面来源名称', '', 90038, 2, 0);
insert into m_logical_table_columns values (901639, 16, 'page_id', '页面id', '', 90039, 2, 0);
insert into m_logical_table_columns values (901640, 16, 'page_name', '页面名称', '', 90040, 2, 0);
insert into m_logical_table_columns values (901641, 16, 'assembly_id', '组件id', '', 90041, 2, 0);
insert into m_logical_table_columns values (901642, 16, 'assembly_name', '组件名称', '', 90042, 2, 0);
insert into m_logical_table_columns values (901643, 16, 'jump_page_id', '要跳转的页面id', '', 90043, 2, 0);
insert into m_logical_table_columns values (901644, 16, 'jump_page_name', '要跳转的页面名称', '', 90044, 2, 0);
insert into m_logical_table_columns values (901645, 16, 'a_type', '事件类型', '', 90045, 2, 0);
insert into m_logical_table_columns values (901646, 16, 'p_type', '组件化：1', '', 90046, 2, 0);
insert into m_logical_table_columns values (901647, 16, 'a_source', '事件来源', '', 90047, 2, 0);
insert into m_logical_table_columns values (901648, 16, 'version', '埋点方案版本', '', 90048, 2, 0);

insert into m_logical_table_columns values (90171, 17, 'a', '事件名称', '', 9001, 2, 0);
insert into m_logical_table_columns values (90172, 17, 'id_m', '用户id', '', 9002, 2, 0);
insert into m_logical_table_columns values (90173, 17, 'member_name', '会员姓名', '', 9003, 2, 0);
insert into m_logical_table_columns values (90174, 17, 'gender', '性别', '', 9004, 2, 0);
insert into m_logical_table_columns values (90175, 17, 'birthday', '生日', '', 9005, 2, 0);
insert into m_logical_table_columns values (90176, 17, 'id_p', '手机号', '', 9006, 2, 0);
insert into m_logical_table_columns values (90177, 17, 'time', '用户访问数据的时间', '', 9007, 2, 0);
insert into m_logical_table_columns values (90178, 17, 'email', '邮箱', '', 9008, 2, 0);
insert into m_logical_table_columns values (90179, 17, 'reg_date', '注册时间', '', 9009, 2, 0);
insert into m_logical_table_columns values (901710, 17, 'reg_store', '注册门店', '', 90010, 2, 0);
insert into m_logical_table_columns values (901711, 17, 'membership_level', '会员等级', '', 90011, 2, 0);
insert into m_logical_table_columns values (901712, 17, 'id_wx', '微信openid', '', 90012, 2, 0);
insert into m_logical_table_columns values (901713, 17, 'official_account', '关注公众号', '', 90013, 2, 0);
insert into m_logical_table_columns values (901714, 17, 'app_id', '应用id', '', 90014, 2, 0);
insert into m_logical_table_columns values (901715, 17, 'app_name', '应用名称', '', 90015, 2, 0);
insert into m_logical_table_columns values (901716, 17, 'province', '省', '', 90016, 2, 0);
insert into m_logical_table_columns values (901717, 17, 'city', '市', '', 90017, 2, 0);
insert into m_logical_table_columns values (901718, 17, 'area', '区', '', 90018, 2, 0);
insert into m_logical_table_columns values (901719, 17, 'ip', '用户访问时的ip', '', 90019, 2, 0);
insert into m_logical_table_columns values (901720, 17, 'timezone', '客户端本地时区', '', 90020, 2, 0);
insert into m_logical_table_columns values (901721, 17, 'mac', 'MAC地址', '', 90021, 2, 0);
insert into m_logical_table_columns values (901722, 17, 'browser', '浏览器名称', '', 90022, 2, 0);
insert into m_logical_table_columns values (901723, 17, 'os', '操作系统名称', '', 90023, 2, 0);
insert into m_logical_table_columns values (901724, 17, 'net', '网络类型', '', 90024, 2, 0);
insert into m_logical_table_columns values (901725, 17, 'carrier', '运营商', '', 90025, 2, 0);
insert into m_logical_table_columns values (901726, 17, 'model', '设备型号', '', 90026, 2, 0);
insert into m_logical_table_columns values (901727, 17, 'sid', '会话id', '', 90027, 2, 0);
insert into m_logical_table_columns values (901728, 17, 'cookie', '客户端cookie唯一标识', '', 90028, 2, 0);
insert into m_logical_table_columns values (901729, 17, 'agent', '客户端信息', '', 90029, 2, 0);
insert into m_logical_table_columns values (901730, 17, 'ute', '客户系统用户类型', '', 90030, 2, 0);
insert into m_logical_table_columns values (901732, 17, 'channel_id', '渠道id', '', 90032, 2, 0);
insert into m_logical_table_columns values (901733, 17, 'channel_name', '渠道名称', '', 90033, 2, 0);
insert into m_logical_table_columns values (901734, 17, 'current_url', '当前页面地址', '', 90034, 2, 0);
insert into m_logical_table_columns values (901735, 17, 'guest_url', '访问的页面地址', '', 90035, 2, 0);
insert into m_logical_table_columns values (901736, 17, 'source_url', '跳转来源地址', '', 90036, 2, 0);
insert into m_logical_table_columns values (901737, 17, 'source_id', '页面来源id', '', 90037, 2, 0);
insert into m_logical_table_columns values (901738, 17, 'source_name', '页面来源名称', '', 90038, 2, 0);
insert into m_logical_table_columns values (901739, 17, 'page_id', '页面id', '', 90039, 2, 0);
insert into m_logical_table_columns values (901740, 17, 'page_name', '页面名称', '', 90040, 2, 0);
insert into m_logical_table_columns values (901741, 17, 'assembly_id', '组件id', '', 90041, 2, 0);
insert into m_logical_table_columns values (901742, 17, 'assembly_name', '组件名称', '', 90042, 2, 0);
insert into m_logical_table_columns values (901743, 17, 'jump_page_id', '要跳转的页面id', '', 90043, 2, 0);
insert into m_logical_table_columns values (901744, 17, 'jump_page_name', '要跳转的页面名称', '', 90044, 2, 0);
insert into m_logical_table_columns values (901745, 17, 'a_type', '事件类型', '', 90045, 2, 0);
insert into m_logical_table_columns values (901746, 17, 'p_type', '组件化：1', '', 90046, 2, 0);
insert into m_logical_table_columns values (901747, 17, 'a_source', '事件来源', '', 90047, 2, 0);
insert into m_logical_table_columns values (901748, 17, 'version', '埋点方案版本', '', 90048, 2, 0);

insert into m_logical_table_columns values (91172, 18, 'id_m', '用户id', '', 9002, 0, 0);
insert into m_logical_table_columns values (91174, 18, 'gender', '性别', '', 9004, 0, 0);
insert into m_logical_table_columns values (91175, 18, 'birthday', '生日', '', 9005, 0, 0);
insert into m_logical_table_columns values (91176, 18, 'id_p', '手机号', '', 9006, 0, 0);
insert into m_logical_table_columns values (91178, 18, 'email', '邮箱', '', 9008, 0, 0);
insert into m_logical_table_columns values (91179, 18, 'reg_date', '注册时间', '', 9009, 0, 0);
insert into m_logical_table_columns values (911710, 18, 'reg_store', '注册门店', '', 90010, 0, 0);
insert into m_logical_table_columns values (911711, 18, 'membership_level', '会员等级', '', 90011, 0, 0);
insert into m_logical_table_columns values (911712, 18, 'id_wx', '微信openid', '', 90012, 0, 0);
insert into m_logical_table_columns values (911713, 18, 'official_account', '关注公众号', '', 90013, 0, 0);
insert into m_logical_table_columns values (911714, 18, 'province', '省', '', 90016, 0, 0);
insert into m_logical_table_columns values (911715, 18, 'city', '市', '', 90017, 0, 0);
insert into m_logical_table_columns values (911716, 18, 'area', '区', '', 90018, 0, 0);
insert into m_logical_table_columns values (911717, 18, 'current_points', '当前积分', '', 9100, 0, 0);
insert into m_logical_table_columns values (911718, 18, 'used_points', '已使用积分', '', 9101, 0, 0);
insert into m_logical_table_columns values (911719, 18, 'available_coupon_num', '未使用优惠券数量', '', 9102, 0, 0);
insert into m_logical_table_columns values (911720, 18, 'used_coupon_num', '已使用优惠券数量', '', 9103, 0, 0);
insert into m_logical_table_columns values (911721, 18, 'agebracket', '年龄阶段', '', 9104, 0, 0);
insert into m_logical_table_columns values (911722, 18, 'constellation', '星座', '', 9105, 0, 0);
insert into m_logical_table_columns values (911723, 19, 'customerlifecyclestage', '生命周期', '', 9106, 0, 0);
insert into m_logical_table_columns values (911724, 20, 'memberbuyinfo', '会员价值', '', 9107, 0, 0);
insert into m_logical_table_columns values (911725, 21, 'memberloyalty', '会员忠诚度', '', 9108, 0, 0);
insert into m_logical_table_columns values (911726, 22, 'preferredbrand', '商品偏好', '', 9109, 0, 0);
insert into m_logical_table_columns values (911727, 23, 'preferredcategory', '品类偏好', '', 9110, 0, 0);
insert into m_logical_table_columns values (911728, 24, 'pricesensitivity', '价格敏感度', '', 9111, 0, 0);
insert into m_logical_table_columns values (911729, 25, 'discountsensitivity', '优惠敏感度', '', 9112, 0, 0);
insert into m_logical_table_columns values (911730, 26, 'preferredconsumptionchannel', '消费渠道偏好', '', 9113, 0, 0);
insert into m_logical_table_columns values (911731, 27, 'preferredinteractchannel', '互动渠道偏好', '', 9114, 0, 0);
insert into m_logical_table_columns values (911732, 28, 'preferredactiontype', '活动类型偏好', '', 9115, 0, 0);

drop table if exists m_identities;

create table m_identities (
id int not null auto_increment,
seller_id int not null,
name varchar(8) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
primary key(id),
unique key(seller_id, name)
);

insert into m_identities values (1, 1003, 'id_m', '会员ID', '');
insert into m_identities values (2, 1003, 'id_p', '电话号码', '');
insert into m_identities values (3, 1003, 'id_wx', '微信OpenID', '');

drop table if exists m_dimension_groups;

create table m_dimension_groups (
id int not null auto_increment,
seller_id int not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
primary key(id),
unique key(seller_id, cn_name)
);

insert into m_dimension_groups values (1, 1003, '业态', '');
insert into m_dimension_groups values (2, 1003, '事件预置属性', '');

drop table if exists m_grouped_dimensions;

create table m_grouped_dimensions (
id int not null auto_increment,
group_id int not null,
dimension_id int not null,
remarks varchar(256) not null,
primary key(id),
unique key(group_id, dimension_id)
);

insert into m_grouped_dimensions values (1, 1, 7, '');
insert into m_grouped_dimensions values (9001, 2, 9001, '');
insert into m_grouped_dimensions values (9002, 2, 9002, '');
insert into m_grouped_dimensions values (9003, 2, 9003, '');
insert into m_grouped_dimensions values (9004, 2, 9004, '');
insert into m_grouped_dimensions values (9005, 2, 9005, '');
insert into m_grouped_dimensions values (9006, 2, 9006, '');
insert into m_grouped_dimensions values (9007, 2, 9007, '');
insert into m_grouped_dimensions values (9008, 2, 9008, '');
insert into m_grouped_dimensions values (9009, 2, 9009, '');
insert into m_grouped_dimensions values (90010, 2, 90010, '');
insert into m_grouped_dimensions values (90011, 2, 90011, '');
insert into m_grouped_dimensions values (90012, 2, 90012, '');
insert into m_grouped_dimensions values (90013, 2, 90013, '');
insert into m_grouped_dimensions values (90014, 2, 90014, '');
insert into m_grouped_dimensions values (90015, 2, 90015, '');
insert into m_grouped_dimensions values (90016, 2, 90016, '');
insert into m_grouped_dimensions values (90017, 2, 90017, '');
insert into m_grouped_dimensions values (90018, 2, 90018, '');
insert into m_grouped_dimensions values (90019, 2, 90019, '');
insert into m_grouped_dimensions values (90020, 2, 90020, '');
insert into m_grouped_dimensions values (90021, 2, 90021, '');
insert into m_grouped_dimensions values (90022, 2, 90022, '');
insert into m_grouped_dimensions values (90023, 2, 90023, '');
insert into m_grouped_dimensions values (90024, 2, 90024, '');
insert into m_grouped_dimensions values (90025, 2, 90025, '');
insert into m_grouped_dimensions values (90026, 2, 90026, '');
insert into m_grouped_dimensions values (90027, 2, 90027, '');
insert into m_grouped_dimensions values (90028, 2, 90028, '');
insert into m_grouped_dimensions values (90029, 2, 90029, '');
insert into m_grouped_dimensions values (90030, 2, 90030, '');
insert into m_grouped_dimensions values (90031, 2, 90031, '');
insert into m_grouped_dimensions values (90032, 2, 90032, '');
insert into m_grouped_dimensions values (90033, 2, 90033, '');
insert into m_grouped_dimensions values (90034, 2, 90034, '');
insert into m_grouped_dimensions values (90035, 2, 90035, '');
insert into m_grouped_dimensions values (90036, 2, 90036, '');
insert into m_grouped_dimensions values (90037, 2, 90037, '');
insert into m_grouped_dimensions values (90038, 2, 90038, '');
insert into m_grouped_dimensions values (90039, 2, 90039, '');
insert into m_grouped_dimensions values (90040, 2, 90040, '');
insert into m_grouped_dimensions values (90041, 2, 90041, '');
insert into m_grouped_dimensions values (90042, 2, 90042, '');
insert into m_grouped_dimensions values (90043, 2, 90043, '');
insert into m_grouped_dimensions values (90044, 2, 90044, '');
insert into m_grouped_dimensions values (90045, 2, 90045, '');
insert into m_grouped_dimensions values (90046, 2, 90046, '');
insert into m_grouped_dimensions values (90047, 2, 90047, '');
insert into m_grouped_dimensions values (90048, 2, 90048, '');

drop table if exists m_dimensions;

create table m_dimensions (
id int not null auto_increment,
seller_id int not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
identity_id int not null default 0,
data_type varchar(16) not null comment 'number, boolean, enum, string, time',
primary key(id),
unique key(seller_id, name)
);

insert into m_dimensions values (2, 1003, 'age', '年龄', '', 0, 'number');
insert into m_dimensions values (3, 1003, 'order_no', '订单号', '', 0, 'string');
insert into m_dimensions values (4, 1003, 'pay_time', '购买时间', '', 0, 'time');
insert into m_dimensions values (5, 1003, 'buy_channel', '购买渠道', '', 0, 'enum');
insert into m_dimensions values (6, 1003, 'pay_date', '购买日期', '', 0, 'time');
insert into m_dimensions values (7, 1003, 'store_type', '业态', '', 0, 'enum');
insert into m_dimensions values (8, 1003, 'tag_category', '标签字段归类', '', 0, 'enum');
insert into m_dimensions values (9, 1003, 'physical_table_id', '物理表ID', '', 0, 'string');
insert into m_dimensions values (10, 1003, 'logical_table_column_id', '逻辑表列ID', '', 0, 'string');
insert into m_dimensions values (13, 1003, 'app_action_type', 'APP行为类型', '', 0, 'enum');
insert into m_dimensions values (14, 1003, 'action_time', '行为时间', '', 0, 'time');
insert into m_dimensions values (15, 1003, 'order_action_type', '订单行为类型', '', 0, 'enum');
insert into m_dimensions values (16, 1003, 'membership_level1', '会员等级', '', 0, 'enum');
insert into m_dimensions values (17, 1003, 'crowd_id', '人群ID', '', 0, 'string');
insert into m_dimensions values (18, 1003, 'crowd_name', '人群名称', '', 0, 'string');
insert into m_dimensions values (19, 1003, 'instance_id', '人群实例ID', '', 0, 'string');

insert into m_dimensions values (9001, 1003, 'a', '事件名称', '', 0, 'enum');
insert into m_dimensions values (9002, 1003, 'id_m', '用户id', '', 1, 'string');
insert into m_dimensions values (9003, 1003, 'member_name', '会员姓名', '', 0, 'string');
insert into m_dimensions values (9004, 1003, 'gender', '性别', '', 0, 'enum');
insert into m_dimensions values (9005, 1003, 'birthday', '生日', '', 0, 'time');
insert into m_dimensions values (9006, 1003, 'id_p', '手机号', '', 2, 'string');
insert into m_dimensions values (9007, 1003, 'time', '用户访问数据的时间', '', 0, 'time');
insert into m_dimensions values (9008, 1003, 'email', '邮箱', '', 0, 'string');
insert into m_dimensions values (9009, 1003, 'reg_date', '注册时间', '', 0, 'time');
insert into m_dimensions values (90010, 1003, 'reg_store', '注册门店', '', 0, 'string');
insert into m_dimensions values (90011, 1003, 'membership_level', '会员等级', '', 0, 'enum');
insert into m_dimensions values (90012, 1003, 'id_wx', '微信openid', '', 3, 'string');
insert into m_dimensions values (90013, 1003, 'official_account', '关注公众号', '', 0, 'string');
insert into m_dimensions values (90014, 1003, 'app_id', '应用id', '', 0, 'string');
insert into m_dimensions values (90015, 1003, 'app_name', '应用名称', '', 0, 'string');
insert into m_dimensions values (90016, 1003, 'province', '省', '', 0, 'string');
insert into m_dimensions values (90017, 1003, 'city', '市', '', 0, 'string');
insert into m_dimensions values (90018, 1003, 'area', '区', '', 0, 'string');
insert into m_dimensions values (90019, 1003, 'ip', '用户访问时的ip', '', 0, 'string');
insert into m_dimensions values (90020, 1003, 'timezone', '客户端本地时区', '', 0, 'string');
insert into m_dimensions values (90021, 1003, 'mac', 'MAC地址', '', 0, 'string');
insert into m_dimensions values (90022, 1003, 'browser', '浏览器名称', '', 0, 'string');
insert into m_dimensions values (90023, 1003, 'os', '操作系统名称', '', 0, 'string');
insert into m_dimensions values (90024, 1003, 'net', '网络类型', '', 0, 'string');
insert into m_dimensions values (90025, 1003, 'carrier', '运营商', '', 0, 'string');
insert into m_dimensions values (90026, 1003, 'model', '设备型号', '', 0, 'string');
insert into m_dimensions values (90027, 1003, 'sid', '会话id', '', 0, 'string');
insert into m_dimensions values (90028, 1003, 'cookie', '客户端cookie唯一标识', '', 0, 'string');
insert into m_dimensions values (90029, 1003, 'agent', '客户端信息', '', 0, 'string');
insert into m_dimensions values (90030, 1003, 'ute', '客户系统用户类型', '', 0, 'string');
insert into m_dimensions values (90032, 1003, 'channel_id', '渠道id', '', 0, 'enum');
insert into m_dimensions values (90033, 1003, 'channel_name', '渠道名称', '', 0, 'string');
insert into m_dimensions values (90034, 1003, 'current_url', '当前页面地址', '', 0, 'string');
insert into m_dimensions values (90035, 1003, 'guest_url', '访问的页面地址', '', 0, 'string');
insert into m_dimensions values (90036, 1003, 'source_url', '跳转来源地址', '', 0, 'string');
insert into m_dimensions values (90037, 1003, 'source_id', '页面来源id', '', 0, 'string');
insert into m_dimensions values (90038, 1003, 'source_name', '页面来源名称', '', 0, 'string');
insert into m_dimensions values (90039, 1003, 'page_id', '页面id', '', 0, 'string');
insert into m_dimensions values (90040, 1003, 'page_name', '页面名称', '', 0, 'string');
insert into m_dimensions values (90041, 1003, 'assembly_id', '组件id', '', 0, 'string');
insert into m_dimensions values (90042, 1003, 'assembly_name', '组件名称', '', 0, 'string');
insert into m_dimensions values (90043, 1003, 'jump_page_id', '要跳转的页面id', '', 0, 'string');
insert into m_dimensions values (90044, 1003, 'jump_page_name', '要跳转的页面名称', '', 0, 'string');
insert into m_dimensions values (90045, 1003, 'a_type', '事件类型', '', 0, 'string');
insert into m_dimensions values (90046, 1003, 'p_type', '组件化：1', '', 0, 'number');
insert into m_dimensions values (90047, 1003, 'a_source', '事件来源', '', 0, 'string');
insert into m_dimensions values (90048, 1003, 'version', '埋点方案版本', '', 0, 'string');
insert into m_dimensions values (90101, 1003, 'shop_id', '关联门店', '', 0, 'string');
insert into m_dimensions values (90102, 1003, 'receiver_address', '收货地址', '', 0, 'string');
insert into m_dimensions values (9022, 1003, 'coupon_id', '优惠券id', '', 0, 'enum');
insert into m_dimensions values (9023, 1003, 'discount', '折扣金额', '', 0, 'number');
insert into m_dimensions values (9024, 1003, 'is_buy_again', '是否再次购买', '', 0, 'boolean');
insert into m_dimensions values (9025, 1003, 'is_coupon_used', '是否使用优惠券', '', 0, 'boolean');
insert into m_dimensions values (9026, 1003, 'is_point_used', '是否使用积分', '', 0, 'boolean');
insert into m_dimensions values (9027, 1003, 'is_refund', '是否退款', '', 0, 'boolean');
insert into m_dimensions values (9028, 1003, 'is_return', '是否退货', '', 0, 'boolean');
insert into m_dimensions values (9029, 1003, 'order_id', '订单号', '', 0, 'string');
insert into m_dimensions values (90210, 1003, 'order_status', '订单状态', '', 0, 'number');
insert into m_dimensions values (90212, 1003, 'payment_method', '支付方式', '', 0, 'number');
insert into m_dimensions values (90213, 1003, 'payment_time', '支付时间', '', 0, '时间戳');
insert into m_dimensions values (90216, 1003, 'product_id', '商品id', '', 0, 'enum');
insert into m_dimensions values (90220, 1003, 'return_order_id', '退单号', '', 0, 'string');
insert into m_dimensions values (90221, 1003, 'return_product_id', '退单商品id', '', 0, 'string');
insert into m_dimensions values (90222, 1003, 'to_shop_or_home_delivery', '到店/到家', '', 0, 'boolean');
insert into m_dimensions values (9031, 1003, 'is_add_to_shoppingcart', '是否加入购物车', '', 0, 'boolean');
insert into m_dimensions values (9032, 1003, 'is_flash_sale', '是否秒杀', '', 0, 'boolean');
insert into m_dimensions values (9033, 1003, 'is_in_stock', '商品是否上架', '', 0, 'boolean');
insert into m_dimensions values (9034, 1003, 'is_modify_good_num_in_shoppingcart', '是否购物车商品增加减少数量', '', 0, 'boolean');
insert into m_dimensions values (9044, 1003, 'share_channel', '分享方式', '', 0, 'string');
insert into m_dimensions values (9061, 1003, 'activity_id', '活动id', '', 0, 'enum');
insert into m_dimensions values (9062, 1003, 'activity_name', '活动名称', '', 0, 'string');

insert into m_dimensions values (9100, 1003, 'current_points', '当前积分', '', 0, 'number');
insert into m_dimensions values (9101, 1003, 'used_points', '已使用积分', '', 0, 'number');
insert into m_dimensions values (9102, 1003, 'available_coupon_num', '未使用优惠券数量', '', 0, 'number');
insert into m_dimensions values (9103, 1003, 'used_coupon_num', '已使用优惠券数量', '', 0, 'number');
insert into m_dimensions values (9104, 1003, 'agebracket', '年龄阶段', '', 0, 'string');
insert into m_dimensions values (9105, 1003, 'constellation', '星座', '', 0, 'string');
insert into m_dimensions values (9106, 1003, 'customerlifecyclestage', '生命周期', '', 0, 'string');
insert into m_dimensions values (9107, 1003, 'memberbuyinfo', '会员价值', '', 0, 'string');
insert into m_dimensions values (9108, 1003, 'memberloyalty', '会员忠诚度', '', 0, 'string');
insert into m_dimensions values (9109, 1003, 'preferredbrand', '商品偏好', '', 0, 'string');
insert into m_dimensions values (9110, 1003, 'preferredcategory', '品类偏好', '', 0, 'string');
insert into m_dimensions values (9111, 1003, 'pricesensitivity', '价格敏感度', '', 0, 'string');
insert into m_dimensions values (9112, 1003, 'discountsensitivity', '优惠敏感度', '', 0, 'string');
insert into m_dimensions values (9113, 1003, 'preferredconsumptionchannel', '消费渠道偏好', '', 0, 'string');
insert into m_dimensions values (9114, 1003, 'preferredinteractchannel', '互动渠道偏好', '', 0, 'string');
insert into m_dimensions values (9115, 1003, 'preferredactiontype', '活动类型偏好', '', 0, 'string');

drop table if exists m_dimension_dictionaries;

create table m_dimension_dictionaries (
id int not null auto_increment,
dimension_id int not null,
physical_table_data_source_id int not null default 0 comment '与query二选一',
physical_table_name varchar(128) not null default '',
parent_name_column varchar(128) not null default '',
name_column varchar(128) not null default '',
cn_name_column varchar(128) not null default '',
query varchar(512) not null default '',
remarks varchar(256) not null,
primary key(id),
unique key(dimension_id)
);

insert into m_dimension_dictionaries values (2, 5, 1, 'ads_buy_channels', 'parent_id', 'channel_id', 'channel_name', '', '');
insert into m_dimension_dictionaries values (3, 7, 1, 'ads_dict_store_types', '', 'value', 'name', '', '');
insert into m_dimension_dictionaries values (4, 8, 1, 'ads_tag_categories', '', 'value', 'name', '', '');
insert into m_dimension_dictionaries values (5, 13, 1, 'ads_app_action_types', '', 'value', 'name', '', '');
insert into m_dimension_dictionaries values (6, 15, 1, 'ads_order_action_types', '', 'value', 'name', '', '');
insert into m_dimension_dictionaries values (7, 90011, 1, 'ads_dict_membership_levels', '', 'value', 'name', '', '');
insert into m_dimension_dictionaries values (8, 19, 0, '', '', '', '', 'select i.instance_id, c.crowd_name from mysql_pro_cdp.ads_crowd_instances i join mysql_pro_cdp.ads_crowds c on i.crowd_id = c.crowd_id', '');
insert into m_dimension_dictionaries values (10, 9001, 1, 'ads_dict_event_types', '', 'value', 'name', '', '');
/*
insert into m_dimension_dictionaries values (12, 90032, 1, 'ads_channels', '', 'channel_id', 'channel_name', '', '');
insert into m_dimension_dictionaries values (13, 90216, 1, 'ads_products', '', 'product_id', 'product_name', '', '');
insert into m_dimension_dictionaries values (14, 9022, 1, 'ads_coupons', '', 'coupon_id', 'coupon_name', '', '');
insert into m_dimension_dictionaries values (15, 9061, 1, 'ads_activities', '', 'activity_id', 'activity_name', '', '');
*/
insert into m_dimension_dictionaries values (100, 9105, 2, 'ads_dict', '', 'code', 'name', 'field = \'constellation\'', '');
insert into m_dimension_dictionaries values (101, 9106, 2, 'ads_dict', '', 'code', 'name', 'field = \'Customer_LifeCycle_Stage\'', '');
insert into m_dimension_dictionaries values (102, 9104, 2, 'ads_dict', '', 'code', 'name', 'field = \'age_bracket\'', '');
insert into m_dimension_dictionaries values (104, 9112, 2, 'ads_dict', '', 'code', 'name', 'field = \'discount_sensitivity\'', '');
insert into m_dimension_dictionaries values (105, 9004, 2, 'ads_dict', '', 'code', 'name', 'field = \'gender\'', '');
insert into m_dimension_dictionaries values (106, 9031, 2, 'ads_dict', '', 'code', 'name', 'field = \'is_add_to_shoppingcart\'', '');
insert into m_dimension_dictionaries values (107, 9032, 2, 'ads_dict', '', 'code', 'name', 'field = \'is_flash_sale\'', '');
insert into m_dimension_dictionaries values (108, 9033, 2, 'ads_dict', '', 'code', 'name', 'field = \'is_in_stock\'', '');
insert into m_dimension_dictionaries values (109, 9034, 2, 'ads_dict', '', 'code', 'name', 'field = \'is_modify_good_num_in_shoppingcart\'', '');
insert into m_dimension_dictionaries values (110, 9027, 2, 'ads_dict', '', 'code', 'name', 'field = \'is_refund\'', '');
insert into m_dimension_dictionaries values (111, 9028, 2, 'ads_dict', '', 'code', 'name', 'field = \'is_return\'', '');
insert into m_dimension_dictionaries values (112, 9108, 2, 'ads_dict', '', 'code', 'name', 'field = \'member_loyalty\'', '');
insert into m_dimension_dictionaries values (113, 90210, 2, 'ads_dict', '', 'code', 'name', 'field = \'order_status\'', '');
insert into m_dimension_dictionaries values (114, 90212, 2, 'ads_dict', '', 'code', 'name', 'field = \'payment_method\'', '');
insert into m_dimension_dictionaries values (115, 9111, 2, 'ads_dict', '', 'code', 'name', 'field = \'pricesen_sitivity\'', '');
insert into m_dimension_dictionaries values (116, 9044, 2, 'ads_dict', '', 'code', 'name', 'field = \'share_channel\'', '');
insert into m_dimension_dictionaries values (117, 90222, 2, 'ads_dict', '', 'code', 'name', 'field = \'to_shop_or_home_delivery\'', '');
insert into m_dimension_dictionaries values (118, 90016, 2, 'dw_province_city_area_dim', 'father_id', 'id', 'name', 'id > 0 and id % 10000 = 0', '');
insert into m_dimension_dictionaries values (119, 90017, 2, 'dw_province_city_area_dim', 'father_id', 'id', 'name', '', '');
insert into m_dimension_dictionaries values (120, 90018, 2, 'dw_province_city_area_dim', 'father_id', 'id', 'name', '', '');
insert into m_dimension_dictionaries values (122, 90216, 2, 'dw_product_dim', '', 'product_id', 'product_name', '', '');
insert into m_dimension_dictionaries values (123, 90032, 2, 'dw_channel_dim', 'father_channel_id', 'channel_id', 'channel_name', '', '');
insert into m_dimension_dictionaries values (124, 9022, 2, 'dw_coupon_dim', '', 'coupon_id', 'coupon_name', '', '');
insert into m_dimension_dictionaries values (125, 9061, 2, 'dw_activity_dim', '', 'activity_id', 'activity_name', '', '');

drop table if exists m_metrics;

create table m_metrics (
id int not null auto_increment,
seller_id int not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
primary key(id),
unique key(seller_id, name)
);

insert into m_metrics values (1, 1003, 'money', '金额', '');
insert into m_metrics values (2, 1003, 'payment_amount', '实付金额', '');
insert into m_metrics values (3, 1003, 'points_consumption', '积分消耗', '');
insert into m_metrics values (4, 1003, 'product_amount', '应付金额', '');
insert into m_metrics values (5, 1003, 'product_num', '商品数量', '');
insert into m_metrics values (6, 1003, 'refund_amount', '退款金额', '');
insert into m_metrics values (7, 1003, 'number_received', '领取数', '');
insert into m_metrics values (8, 1003, 'used_num', '使用数量', '');

drop table if exists m_physical_tables;

create table m_physical_tables (
id int not null auto_increment,
seller_id int not null,
logical_table_id int not null,
data_source_id int not null,
name varchar(128) not null,
remarks varchar(256) not null,
primary key(id),
unique key(seller_id, name)
);

insert into m_physical_tables values (1, 1003, 1, 2, 'ads_basic_infos', '');
insert into m_physical_tables values (2, 1003, 2, 2, 'ads_purchases', '');
insert into m_physical_tables values (3, 1003, 3, 2, 'ads_daily_purchases', '');
insert into m_physical_tables values (5, 1003, 5, 2, 'ads_app_events', '');
insert into m_physical_tables values (6, 1003, 6, 2, 'ads_consuming_portraits', '');
insert into m_physical_tables values (7, 1003, 7, 1, 'ads_crowds', '');
insert into m_physical_tables values (8, 1003, 8, 1, 'ads_crowd_instances', '');
insert into m_physical_tables values (9, 1003, 9, 2, 'ads_crowd_instance_members', '');
insert into m_physical_tables values (10, 1003, 10, 2, 'ads_event_address', '');
insert into m_physical_tables values (11, 1003, 11, 2, 'ads_event_order', '');
insert into m_physical_tables values (12, 1003, 12, 2, 'ads_event_cart', '');
insert into m_physical_tables values (13, 1003, 13, 2, 'ads_event_share', '');
insert into m_physical_tables values (14, 1003, 14, 2, 'ads_event_coupon', '');
insert into m_physical_tables values (15, 1003, 15, 2, 'ads_event_activity', '');
insert into m_physical_tables values (16, 1003, 16, 2, 'ads_event_app', '');
insert into m_physical_tables values (17, 1003, 17, 2, 'ads_event_login', '');
insert into m_physical_tables values (18, 1003, 18, 2, 'tags_mbr_memberbaseinfo_d', '');
insert into m_physical_tables values (19, 1003, 19, 2, 'tags_mbr_customerlifecyclestage_d', '');
insert into m_physical_tables values (20, 1003, 20, 2, 'tags_mbr_memberbuyinfo_d', '');
insert into m_physical_tables values (21, 1003, 21, 2, 'tags_mbr_memberloyalty_d', '');
insert into m_physical_tables values (22, 1003, 22, 2, 'tags_mbr_preferredbrand_d', '');
insert into m_physical_tables values (23, 1003, 23, 2, 'tags_mbr_preferredcategory_d', '');
insert into m_physical_tables values (24, 1003, 24, 2, 'tags_mbr_pricesensitivity_d', '');
insert into m_physical_tables values (25, 1003, 25, 2, 'tags_mbr_discountsensitivity_d', '');
insert into m_physical_tables values (26, 1003, 26, 2, 'tags_mbr_preferredconsumptionchannel_d', '');
insert into m_physical_tables values (27, 1003, 27, 2, 'tags_mbr_preferredinteractchannel_d', '');
insert into m_physical_tables values (28, 1003, 28, 2, 'tags_mbr_preferredactiontype_d', '');

drop table if exists m_physical_table_columns;

create table m_physical_table_columns (
id int not null auto_increment,
physical_table_id int not null,
logical_table_column_id int not null default 0,
physical_name varchar(128) not null,
primary key(id),
unique key(physical_table_id, logical_table_column_id)
);

drop table if exists m_data_sources;

create table m_data_sources (
id int not null auto_increment,
seller_id int not null,
driver varchar(32) not null comment 'Hive, MySQL, Clickhouse',
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
primary key(id),
unique key(seller_id, name)
);

insert into m_data_sources values (1, 1003, 'MySQL', 'mysql_pro_cdp', 'MySQL Production', '');
insert into m_data_sources values (2, 1003, 'MySQL', 'adb_pro_cdp', 'AnalyticDB Production', '');

drop table if exists m_data_source_params;

create table m_data_source_params (
id int not null auto_increment,
data_source_id int not null,
param_name varchar(128) not null,
param_value varchar(256) not null,
primary key(id),
unique key(data_source_id, param_name)
);

insert into m_data_source_params values (1, 1, 'host', '127.0.0.1');
insert into m_data_source_params values (2, 1, 'port', '3306');
insert into m_data_source_params values (3, 1, 'user', 'root');
insert into m_data_source_params values (4, 1, 'password', '123456');
insert into m_data_source_params values (5, 1, 'database', 'cdp');
insert into m_data_source_params values (6, 2, 'host', '127.0.0.1');
insert into m_data_source_params values (7, 2, 'port', '10001');
insert into m_data_source_params values (8, 2, 'user', 'adb');
insert into m_data_source_params values (9, 2, 'password', '123456');
insert into m_data_source_params values (10, 2, 'database', 'cdp');

drop table if exists m_driver_param_definitions;

create table m_driver_param_definitions (
id int not null auto_increment,
driver varchar(32) not null comment 'Hive, MySQL, Clickhouse',
param_name varchar(128) not null,
primary key(id),
unique key(driver, param_name)
);

insert into m_driver_param_definitions values (1, 'MySQL', 'host');
insert into m_driver_param_definitions values (2, 'MySQL', 'port');
insert into m_driver_param_definitions values (3, 'MySQL', 'user');
insert into m_driver_param_definitions values (4, 'MySQL', 'password');
insert into m_driver_param_definitions values (5, 'MySQL', 'database');

drop table if exists ads_dict_event_types;

create table ads_dict_event_types (
id int not null auto_increment,
seller_id int not null,
value varchar(128) not null,
name varchar(128) not null,
table_id int not null,
primary key(id),
unique key(seller_id, value)
);

insert into ads_dict_event_types values (901, 1003, 'new_receiver_address', '新增收货地址', 10);
insert into ads_dict_event_types values (902, 1003, 'modify_receiver_address', '修改收货地址', 10);
insert into ads_dict_event_types values (903, 1003, 'delete_receiver_address', '删除收货地址', 10);
insert into ads_dict_event_types values (904, 1003, 'payment', '付款', 11);
insert into ads_dict_event_types values (905, 1003, 'delete_order', '删除订单', 11);
insert into ads_dict_event_types values (906, 1003, 'cancel_order', '取消订单', 11);
insert into ads_dict_event_types values (907, 1003, 'request_refund_or_return', '申请退货退款', 11);
insert into ads_dict_event_types values (908, 1003, 'add_to_shoppingcart', '加入购物车', 12);
insert into ads_dict_event_types values (909, 1003, 'modify_good_num_in_shoppingcart', '购物车商品增加减少数量', 12);
insert into ads_dict_event_types values (9010, 1003, 'delete_from_shoppingcart', '删除购物车商品', 12);
insert into ads_dict_event_types values (9011, 1003, 'empty_shoppingcart', '清空购物车', 12);
insert into ads_dict_event_types values (9012, 1003, 'share_goods', '分享商品', 13);
insert into ads_dict_event_types values (9013, 1003, 'receive_coupons', '领取优惠券', 14);
insert into ads_dict_event_types values (9014, 1003, 'use_coupons', '使用优惠券', 14);
insert into ads_dict_event_types values (9015, 1003, 'join_activity', '进入活动', 15);
insert into ads_dict_event_types values (9016, 1003, 'lunch_app', 'app启动', 16);
insert into ads_dict_event_types values (9017, 1003, 'login', '登陆', 17);
insert into ads_dict_event_types values (9018, 1003, 'sign_in', '注册 ', 17);
insert into ads_dict_event_types values (9019, 1003, 'logout', '退出账号', 17);

drop table if exists ads_dict_genders;

create table ads_dict_genders (
id int not null auto_increment,
seller_id int not null,
value varchar(128) not null,
name varchar(128),
primary key(id),
unique key(seller_id, value)
);

insert into ads_dict_genders values (1, 1003, '1', '男');
insert into ads_dict_genders values (2, 1003, '2', '女');
insert into ads_dict_genders values (3, 1003, '3', '未知');

drop table if exists ads_buy_channels;

create table ads_buy_channels (
id int not null auto_increment,
seller_id int not null,
parent_id int not null,
channel_id int not null,
channel_name varchar(128),
primary key(id),
unique key(seller_id, channel_id)
);

insert into ads_buy_channels values (1, 1003, 0, 1, '线上');
insert into ads_buy_channels values (2, 1003, 0, 2, '线下');
insert into ads_buy_channels values (3, 1003, 1, 3, '京东');
insert into ads_buy_channels values (4, 1003, 1, 4, '淘宝');
insert into ads_buy_channels values (5, 1003, 2, 5, '北京市');
insert into ads_buy_channels values (6, 1003, 5, 6, '北京市');
insert into ads_buy_channels values (7, 1003, 6, 7, '海淀区');
insert into ads_buy_channels values (8, 1003, 7, 8, '四季青店');

drop table if exists ads_dict_membership_levels;

create table ads_dict_membership_levels (
id int not null auto_increment,
seller_id int not null,
value varchar(128) not null,
name varchar(128),
primary key(id),
unique key(seller_id, value)
);

insert into ads_dict_membership_levels values (1, 1003, '1', 'V1');
insert into ads_dict_membership_levels values (2, 1003, '2', 'V2');
insert into ads_dict_membership_levels values (3, 1003, '3', 'V3');
insert into ads_dict_membership_levels values (4, 1003, '4', 'V4');
insert into ads_dict_membership_levels values (5, 1003, '5', 'V5');

drop table if exists ads_dict_store_types;

create table ads_dict_store_types (
id int not null auto_increment,
seller_id int not null,
value varchar(128) not null,
name varchar(128),
primary key(id),
unique key(seller_id, value)
);

insert into ads_dict_store_types values (1, 1003, '0', '全部');
insert into ads_dict_store_types values (2, 1003, '1', '超市');
insert into ads_dict_store_types values (3, 1003, '2', '百货');
insert into ads_dict_store_types values (4, 1003, '3', '家电');

drop table if exists ads_channels;

create table ads_channels (
id int not null auto_increment,
seller_id int not null,
`channel_source` varchar(100) not null comment '渠道来源',
`channel_category1` varchar(100) not null comment '一级渠道类型',
`channel_category2` varchar(100) not null comment '二级渠道类型',
`channel_category3` varchar(100) not null comment '三级渠道类型',
`channel_id` varchar(100) not null comment '渠道id',
`channel_name` varchar(100) not null comment '渠道名称',
`detail_address` varchar(100) not null comment '详细地址',
primary key(id),
unique key(seller_id, channel_id)
);

drop table if exists ads_products;

create table ads_products (
id int not null auto_increment,
seller_id int not null,
`product_id` varchar(100) not null comment '商品id',
`product_name` varchar(100) not null comment '商品名称',
`brand_id` varchar(100) not null comment '品牌id',
`brand_name` varchar(100) not null comment '品牌名称',
`category_level1_id` varchar(100) not null comment '一级品类',
`category_level2_id` varchar(100) not null comment '二级品类',
`category_level3_id` varchar(100) not null comment '三级品类',
`price` int not null comment '价格',
`specification` varchar(100) not null comment '规格',
primary key(id),
unique key(seller_id, product_id)
);

drop table if exists ads_coupons;

create table ads_coupons (
id int not null auto_increment,
seller_id int not null,
`coupon_id` varchar(100) not null comment '优惠券id',
`coupon_name` varchar(100) not null comment '优惠券名称',
`start_date` bigint not null comment '有效起始期',
`end_date` bigint not null comment '有效截至期',
`coupon_type` varchar(100) not null comment '优惠券类型',
`discount_amount` int not null comment '折扣金额',
`discount_ratio` int not null comment '折扣比例',
`channel_id` varchar(100) not null comment '领取渠道id',
`activity_id` varchar(100) not null comment '活动id',
`activity_name` varchar(100) not null comment '活动名称',
primary key(id),
unique key(seller_id, coupon_id)
);

drop table if exists ads_activities;

create table ads_activities (
id int not null auto_increment,
seller_id int not null,
`activity_id` varchar(100) not null comment '活动id',
`activity_name` varchar(100) not null comment '活动名称',
`action_type` varchar(100) not null comment '活动类型',
`channel_id` varchar(100) not null comment '参与门店',
`product_id` varchar(100) not null comment '关联活动商品',
`coupon_id` varchar(100) not null comment '优惠券id',
primary key(id),
unique key(seller_id, activity_id)
);

drop table if exists ads_basic_infos;

create table ads_basic_infos (
seller_id int not null,
oneid int not null,
age int not null,
gender int not null,
tel varchar(128) not null,
unique key(seller_id, oneid)
);

drop table if exists ads_purchases;

create table ads_purchases (
seller_id int not null,
oneid int not null,
order_no varchar(128) not null,
buy_channel varchar(128) not null,
pay_time varchar(128) not null,
store_type varchar(128) not null,
buy_value int not null,
unique key(seller_id, oneid, order_no)
);

drop table if exists ads_daily_purchases;

create table ads_daily_purchases (
seller_id int not null,
oneid int not null,
buy_channel varchar(128) not null,
pay_date varchar(128) not null,
store_type varchar(128) not null,
buy_value int not null,
unique key(seller_id, oneid, store_type)
);

drop table if exists ads_consuming_portraits;

create table ads_consuming_portraits (
seller_id int not null,
oneid int not null,
membership_level varchar(128) not null,
store_type varchar(128) not null,
unique key(seller_id, oneid, store_type)
);

drop table if exists ads_crowds;

create table ads_crowds (
id int not null auto_increment,
seller_id int not null,
crowd_id int not null,
crowd_name varchar(128) not null,
primary key(id),
unique key(seller_id, crowd_id)
);

drop table if exists ads_crowd_instances;

create table ads_crowd_instances (
id int not null auto_increment,
seller_id int not null,
crowd_id int not null,
instance_id int not null,
primary key(id),
unique key(seller_id, instance_id)
);

drop table if exists ads_crowd_instance_members;

create table ads_crowd_instance_members (
seller_id int not null,
oneid int not null,
instance_id int not null,
unique key(seller_id, instance_id, oneid)
);

insert into ads_crowds values (1, 1003, 1, '人群1');

insert into ads_crowd_instances values (1, 1003, 1, 1);

drop table if exists ads_event_address;

create table ads_event_address (
id bigint not null,
oneid int not null,
`a` varchar(100) null,
`id_m` varchar(100) null,
`member_name` varchar(100) null,
`gender` varchar(100) null,
`birthday` varchar(100) null,
`id_p` varchar(100) null,
`time` varchar(100) null,
`email` varchar(100) null,
`reg_date` varchar(100) null,
`reg_store` varchar(100) null,
`membership_level` varchar(100) null,
`id_wx` varchar(100) null,
`official_account` varchar(100) null,
`app_id` varchar(100) null,
`app_name` varchar(100) null,
`province` varchar(100) null,
`city` varchar(100) null,
`area` varchar(100) null,
`ip` varchar(100) null,
`timezone` varchar(100) null,
`mac` varchar(100) null,
`browser` varchar(100) null,
`os` varchar(100) null,
`net` varchar(100) null,
`carrier` varchar(100) null,
`model` varchar(100) null,
`sid` varchar(100) null,
`cookie` varchar(100) null,
`agent` varchar(100) null,
`ute` varchar(100) null,
`seller_id` varchar(100) null,
`channel_id` varchar(100) null,
`channel_name` varchar(100) null,
`current_url` varchar(100) null,
`guest_url` varchar(100) null,
`source_url` varchar(100) null,
`source_id` varchar(100) null,
`source_name` varchar(100) null,
`page_id` varchar(100) null,
`page_name` varchar(100) null,
`assembly_id` varchar(100) null,
`assembly_name` varchar(100) null,
`jump_page_id` varchar(100) null,
`jump_page_name` varchar(100) null,
`a_type` varchar(100) null,
`p_type` varchar(100) null,
`a_source` varchar(100) null,
`version` varchar(100) null,
`shop_id` varchar(100) null,
`receiver_address` varchar(100) null
);

drop table if exists ads_event_order;

create table ads_event_order (
id bigint not null,
oneid int not null,
`a` varchar(100) null,
`id_m` varchar(100) null,
`member_name` varchar(100) null,
`gender` varchar(100) null,
`birthday` varchar(100) null,
`id_p` varchar(100) null,
`time` varchar(100) null,
`email` varchar(100) null,
`reg_date` varchar(100) null,
`reg_store` varchar(100) null,
`membership_level` varchar(100) null,
`id_wx` varchar(100) null,
`official_account` varchar(100) null,
`app_id` varchar(100) null,
`app_name` varchar(100) null,
`province` varchar(100) null,
`city` varchar(100) null,
`area` varchar(100) null,
`ip` varchar(100) null,
`timezone` varchar(100) null,
`mac` varchar(100) null,
`browser` varchar(100) null,
`os` varchar(100) null,
`net` varchar(100) null,
`carrier` varchar(100) null,
`model` varchar(100) null,
`sid` varchar(100) null,
`cookie` varchar(100) null,
`agent` varchar(100) null,
`ute` varchar(100) null,
`seller_id` varchar(100) null,
`channel_id` varchar(100) null,
`channel_name` varchar(100) null,
`current_url` varchar(100) null,
`guest_url` varchar(100) null,
`source_url` varchar(100) null,
`source_id` varchar(100) null,
`source_name` varchar(100) null,
`page_id` varchar(100) null,
`page_name` varchar(100) null,
`assembly_id` varchar(100) null,
`assembly_name` varchar(100) null,
`jump_page_id` varchar(100) null,
`jump_page_name` varchar(100) null,
`a_type` varchar(100) null,
`p_type` varchar(100) null,
`a_source` varchar(100) null,
`version` varchar(100) null,
`coupon_id` varchar(100) null,
`discount` varchar(100) null,
`is_buy_again` varchar(100) null,
`is_coupon_used` varchar(100) null,
`is_point_used` varchar(100) null,
`is_refund` varchar(100) null,
`is_return` varchar(100) null,
`order_id` varchar(100) null,
`order_status` varchar(100) null,
`payment_amount` varchar(100) null,
`payment_method` varchar(100) null,
`payment_time` varchar(100) null,
`points_consumption` varchar(100) null,
`product_amount` varchar(100) null,
`product_id` varchar(100) null,
`product_num` varchar(100) null,
`receiver_address` varchar(100) null,
`refund_amount` varchar(100) null,
`return_order_id` varchar(100) null,
`return_product_id` varchar(100) null,
`to_shop_or_home_delivery` varchar(100) null
);

drop table if exists ads_event_cart;

create table ads_event_cart (
id bigint not null,
oneid int not null,
`a` varchar(100) null,
`id_m` varchar(100) null,
`member_name` varchar(100) null,
`gender` varchar(100) null,
`birthday` varchar(100) null,
`id_p` varchar(100) null,
`time` varchar(100) null,
`email` varchar(100) null,
`reg_date` varchar(100) null,
`reg_store` varchar(100) null,
`membership_level` varchar(100) null,
`id_wx` varchar(100) null,
`official_account` varchar(100) null,
`app_id` varchar(100) null,
`app_name` varchar(100) null,
`province` varchar(100) null,
`city` varchar(100) null,
`area` varchar(100) null,
`ip` varchar(100) null,
`timezone` varchar(100) null,
`mac` varchar(100) null,
`browser` varchar(100) null,
`os` varchar(100) null,
`net` varchar(100) null,
`carrier` varchar(100) null,
`model` varchar(100) null,
`sid` varchar(100) null,
`cookie` varchar(100) null,
`agent` varchar(100) null,
`ute` varchar(100) null,
`seller_id` varchar(100) null,
`channel_id` varchar(100) null,
`channel_name` varchar(100) null,
`current_url` varchar(100) null,
`guest_url` varchar(100) null,
`source_url` varchar(100) null,
`source_id` varchar(100) null,
`source_name` varchar(100) null,
`page_id` varchar(100) null,
`page_name` varchar(100) null,
`assembly_id` varchar(100) null,
`assembly_name` varchar(100) null,
`jump_page_id` varchar(100) null,
`jump_page_name` varchar(100) null,
`a_type` varchar(100) null,
`p_type` varchar(100) null,
`a_source` varchar(100) null,
`version` varchar(100) null,
`is_add_to_shoppingcart` varchar(100) null,
`is_flash_sale` varchar(100) null,
`is_in_stock` varchar(100) null,
`is_modify_good_num_in_shoppingcart` varchar(100) null,
`product_id` varchar(100) null
);

drop table if exists ads_event_share;

create table ads_event_share (
id bigint not null,
oneid int not null,
`a` varchar(100) null,
`id_m` varchar(100) null,
`member_name` varchar(100) null,
`gender` varchar(100) null,
`birthday` varchar(100) null,
`id_p` varchar(100) null,
`time` varchar(100) null,
`email` varchar(100) null,
`reg_date` varchar(100) null,
`reg_store` varchar(100) null,
`membership_level` varchar(100) null,
`id_wx` varchar(100) null,
`official_account` varchar(100) null,
`app_id` varchar(100) null,
`app_name` varchar(100) null,
`province` varchar(100) null,
`city` varchar(100) null,
`area` varchar(100) null,
`ip` varchar(100) null,
`timezone` varchar(100) null,
`mac` varchar(100) null,
`browser` varchar(100) null,
`os` varchar(100) null,
`net` varchar(100) null,
`carrier` varchar(100) null,
`model` varchar(100) null,
`sid` varchar(100) null,
`cookie` varchar(100) null,
`agent` varchar(100) null,
`ute` varchar(100) null,
`seller_id` varchar(100) null,
`channel_id` varchar(100) null,
`channel_name` varchar(100) null,
`current_url` varchar(100) null,
`guest_url` varchar(100) null,
`source_url` varchar(100) null,
`source_id` varchar(100) null,
`source_name` varchar(100) null,
`page_id` varchar(100) null,
`page_name` varchar(100) null,
`assembly_id` varchar(100) null,
`assembly_name` varchar(100) null,
`jump_page_id` varchar(100) null,
`jump_page_name` varchar(100) null,
`a_type` varchar(100) null,
`p_type` varchar(100) null,
`a_source` varchar(100) null,
`version` varchar(100) null,
`is_flash_sale` varchar(100) null,
`is_in_stock` varchar(100) null,
`product_id` varchar(100) null,
`share_channel` varchar(100) null
);

drop table if exists ads_event_coupon;

create table ads_event_coupon (
id bigint not null,
oneid int not null,
`a` varchar(100) null,
`id_m` varchar(100) null,
`member_name` varchar(100) null,
`gender` varchar(100) null,
`birthday` varchar(100) null,
`id_p` varchar(100) null,
`time` varchar(100) null,
`email` varchar(100) null,
`reg_date` varchar(100) null,
`reg_store` varchar(100) null,
`membership_level` varchar(100) null,
`id_wx` varchar(100) null,
`official_account` varchar(100) null,
`app_id` varchar(100) null,
`app_name` varchar(100) null,
`province` varchar(100) null,
`city` varchar(100) null,
`area` varchar(100) null,
`ip` varchar(100) null,
`timezone` varchar(100) null,
`mac` varchar(100) null,
`browser` varchar(100) null,
`os` varchar(100) null,
`net` varchar(100) null,
`carrier` varchar(100) null,
`model` varchar(100) null,
`sid` varchar(100) null,
`cookie` varchar(100) null,
`agent` varchar(100) null,
`ute` varchar(100) null,
`seller_id` varchar(100) null,
`channel_id` varchar(100) null,
`channel_name` varchar(100) null,
`current_url` varchar(100) null,
`guest_url` varchar(100) null,
`source_url` varchar(100) null,
`source_id` varchar(100) null,
`source_name` varchar(100) null,
`page_id` varchar(100) null,
`page_name` varchar(100) null,
`assembly_id` varchar(100) null,
`assembly_name` varchar(100) null,
`jump_page_id` varchar(100) null,
`jump_page_name` varchar(100) null,
`a_type` varchar(100) null,
`p_type` varchar(100) null,
`a_source` varchar(100) null,
`version` varchar(100) null,
`coupon_id` varchar(100) null,
`number_received` varchar(100) null,
`order_id` varchar(100) null,
`used_num` varchar(100) null
);

drop table if exists ads_event_activity;

create table ads_event_activity (
id bigint not null,
oneid int not null,
`a` varchar(100) null,
`id_m` varchar(100) null,
`member_name` varchar(100) null,
`gender` varchar(100) null,
`birthday` varchar(100) null,
`id_p` varchar(100) null,
`time` varchar(100) null,
`email` varchar(100) null,
`reg_date` varchar(100) null,
`reg_store` varchar(100) null,
`membership_level` varchar(100) null,
`id_wx` varchar(100) null,
`official_account` varchar(100) null,
`app_id` varchar(100) null,
`app_name` varchar(100) null,
`province` varchar(100) null,
`city` varchar(100) null,
`area` varchar(100) null,
`ip` varchar(100) null,
`timezone` varchar(100) null,
`mac` varchar(100) null,
`browser` varchar(100) null,
`os` varchar(100) null,
`net` varchar(100) null,
`carrier` varchar(100) null,
`model` varchar(100) null,
`sid` varchar(100) null,
`cookie` varchar(100) null,
`agent` varchar(100) null,
`ute` varchar(100) null,
`seller_id` varchar(100) null,
`channel_id` varchar(100) null,
`channel_name` varchar(100) null,
`current_url` varchar(100) null,
`guest_url` varchar(100) null,
`source_url` varchar(100) null,
`source_id` varchar(100) null,
`source_name` varchar(100) null,
`page_id` varchar(100) null,
`page_name` varchar(100) null,
`assembly_id` varchar(100) null,
`assembly_name` varchar(100) null,
`jump_page_id` varchar(100) null,
`jump_page_name` varchar(100) null,
`a_type` varchar(100) null,
`p_type` varchar(100) null,
`a_source` varchar(100) null,
`version` varchar(100) null,
`activity_id` varchar(100) null,
`activity_name` varchar(100) null,
`coupon_id` varchar(100) null,
`product_id` varchar(100) null
);

drop table if exists ads_event_app;

create table ads_event_app (
id bigint not null,
oneid int not null,
`a` varchar(100) null,
`id_m` varchar(100) null,
`member_name` varchar(100) null,
`gender` varchar(100) null,
`birthday` varchar(100) null,
`id_p` varchar(100) null,
`time` varchar(100) null,
`email` varchar(100) null,
`reg_date` varchar(100) null,
`reg_store` varchar(100) null,
`membership_level` varchar(100) null,
`id_wx` varchar(100) null,
`official_account` varchar(100) null,
`app_id` varchar(100) null,
`app_name` varchar(100) null,
`province` varchar(100) null,
`city` varchar(100) null,
`area` varchar(100) null,
`ip` varchar(100) null,
`timezone` varchar(100) null,
`mac` varchar(100) null,
`browser` varchar(100) null,
`os` varchar(100) null,
`net` varchar(100) null,
`carrier` varchar(100) null,
`model` varchar(100) null,
`sid` varchar(100) null,
`cookie` varchar(100) null,
`agent` varchar(100) null,
`ute` varchar(100) null,
`seller_id` varchar(100) null,
`channel_id` varchar(100) null,
`channel_name` varchar(100) null,
`current_url` varchar(100) null,
`guest_url` varchar(100) null,
`source_url` varchar(100) null,
`source_id` varchar(100) null,
`source_name` varchar(100) null,
`page_id` varchar(100) null,
`page_name` varchar(100) null,
`assembly_id` varchar(100) null,
`assembly_name` varchar(100) null,
`jump_page_id` varchar(100) null,
`jump_page_name` varchar(100) null,
`a_type` varchar(100) null,
`p_type` varchar(100) null,
`a_source` varchar(100) null,
`version` varchar(100) null
);

drop table if exists ads_event_login;

create table ads_event_login (
id bigint not null,
oneid int not null,
`a` varchar(100) null,
`id_m` varchar(100) null,
`member_name` varchar(100) null,
`gender` varchar(100) null,
`birthday` varchar(100) null,
`id_p` varchar(100) null,
`time` varchar(100) null,
`email` varchar(100) null,
`reg_date` varchar(100) null,
`reg_store` varchar(100) null,
`membership_level` varchar(100) null,
`id_wx` varchar(100) null,
`official_account` varchar(100) null,
`app_id` varchar(100) null,
`app_name` varchar(100) null,
`province` varchar(100) null,
`city` varchar(100) null,
`area` varchar(100) null,
`ip` varchar(100) null,
`timezone` varchar(100) null,
`mac` varchar(100) null,
`browser` varchar(100) null,
`os` varchar(100) null,
`net` varchar(100) null,
`carrier` varchar(100) null,
`model` varchar(100) null,
`sid` varchar(100) null,
`cookie` varchar(100) null,
`agent` varchar(100) null,
`ute` varchar(100) null,
`seller_id` varchar(100) null,
`channel_id` varchar(100) null,
`channel_name` varchar(100) null,
`current_url` varchar(100) null,
`guest_url` varchar(100) null,
`source_url` varchar(100) null,
`source_id` varchar(100) null,
`source_name` varchar(100) null,
`page_id` varchar(100) null,
`page_name` varchar(100) null,
`assembly_id` varchar(100) null,
`assembly_name` varchar(100) null,
`jump_page_id` varchar(100) null,
`jump_page_name` varchar(100) null,
`a_type` varchar(100) null,
`p_type` varchar(100) null,
`a_source` varchar(100) null,
`version` varchar(100) null
);

drop table if exists tags_mbr_memberbaseinfo_d;

create table tags_mbr_memberbaseinfo_d (
oneid int not null,
seller_id int not null,
`id_m` varchar(100) not null,
`gender` varchar(100) not null,
`birthday` varchar(100) not null,
`id_p` varchar(100) not null,
`email` varchar(100) not null,
`reg_date` varchar(100) not null,
`reg_store` varchar(100) not null,
`membership_level` varchar(100) not null,
`id_wx` varchar(100) not null,
`official_account` varchar(100) not null,
`province` varchar(100) not null,
`city` varchar(100) not null,
`area` varchar(100) not null,
`current_points` varchar(100) not null,
`used_points` varchar(100) not null,
`available_coupon_num` varchar(100) not null,
`used_coupon_num` varchar(100) not null,
`agebracket` varchar(100) not null,
`constellation` varchar(100) not null
);

drop table if exists tags_mbr_customerlifecyclestage_d;

create table tags_mbr_customerlifecyclestage_d (
oneid int not null,
seller_id int not null,
`customerlifecyclestage` varchar(100) not null
);

drop table if exists tags_mbr_memberbuyinfo_d;

create table tags_mbr_memberbuyinfo_d (
oneid int not null,
seller_id int not null,
`memberbuyinfo` varchar(100) not null
);

drop table if exists tags_mbr_memberloyalty_d;

create table tags_mbr_memberloyalty_d (
oneid int not null,
seller_id int not null,
`memberloyalty` varchar(100) not null
);

drop table if exists tags_mbr_preferredbrand_d;

create table tags_mbr_preferredbrand_d (
oneid int not null,
seller_id int not null,
`preferredbrand` varchar(100) not null
);

drop table if exists tags_mbr_preferredcategory_d;

create table tags_mbr_preferredcategory_d (
oneid int not null,
seller_id int not null,
`preferredcategory` varchar(100) not null
);

drop table if exists tags_mbr_pricesensitivity_d;

create table tags_mbr_pricesensitivity_d (
oneid int not null,
seller_id int not null,
`pricesensitivity` varchar(100) not null
);

drop table if exists tags_mbr_discountsensitivity_d;

create table tags_mbr_discountsensitivity_d (
oneid int not null,
seller_id int not null,
`discountsensitivity` varchar(100) not null
);

drop table if exists tags_mbr_preferredconsumptionchannel_d;

create table tags_mbr_preferredconsumptionchannel_d (
oneid int not null,
seller_id int not null,
`preferredconsumptionchannel` varchar(100) not null
);

drop table if exists tags_mbr_preferredinteractchannel_d;

create table tags_mbr_preferredinteractchannel_d (
oneid int not null,
seller_id int not null,
`preferredinteractchannel` varchar(100) not null
);

drop table if exists tags_mbr_preferredactiontype_d;

create table tags_mbr_preferredactiontype_d (
oneid int not null,
seller_id int not null,
`preferredactiontype` varchar(100) not null
);
