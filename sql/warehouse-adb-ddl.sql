drop table if exists m_logical_tables;

create table m_logical_tables (
id int,
seller_id int,
layer string comment 'ODS, DWD, DWM, DWS, ADS',
name string,
cn_name string,
remarks string,
has_oneid tinyint,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists m_logical_table_columns;

create table m_logical_table_columns (
id int,
table_id int,
name string,
cn_name string,
remarks string,
dimension_id int comment '与metrics_id二选一',
dimension_group_id int comment '当dimension_id有值且该列属于一个维度组时有值',
metrics_id int comment '与dimension_id二选一',
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');











drop table if exists m_identities;

create table m_identities (
id int,
seller_id int,
name string,
cn_name string,
remarks string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists m_dimension_groups;

create table m_dimension_groups (
id int,
seller_id int,
cn_name string,
remarks string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists m_grouped_dimensions;

create table m_grouped_dimensions (
id int,
group_id int,
dimension_id int,
remarks string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists m_dimensions;

create table m_dimensions (
id int,
seller_id int,
name string,
cn_name string,
remarks string,
identity_id int,
data_type string comment 'number, boolean, enum, string, time',
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');




drop table if exists m_dimension_dictionaries;

create table m_dimension_dictionaries (
id int,
dimension_id int,
physical_table_data_source_id int comment '与query二选一',
physical_table_name string default '',
parent_name_column string default '',
name_column string default '',
cn_name_column string default '',
query string default '',
remarks string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists m_metrics;

create table m_metrics (
id int,
seller_id int,
name string,
cn_name string,
remarks string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists m_physical_tables;

create table m_physical_tables (
id int,
seller_id int,
logical_table_id int,
data_source_id int,
name string,
remarks string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists m_physical_table_columns;

create table m_physical_table_columns (
id int,
physical_table_id int,
logical_table_column_id int,
physical_name string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists m_data_sources;

create table m_data_sources (
id int,
seller_id int,
driver string comment 'Hive, MySQL, Clickhouse',
name string,
cn_name string,
remarks string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists m_data_source_params;

create table m_data_source_params (
id int,
data_source_id int,
param_name string,
param_value string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists m_driver_param_definitions;

create table m_driver_param_definitions (
id int,
driver string comment 'Hive, MySQL, Clickhouse',
param_name string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists ads_dict_event_types;

create table ads_dict_event_types (
id int,
seller_id int,
value string,
name string,
table_id int,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists ads_dict_genders;

create table ads_dict_genders (
id int,
seller_id int,
value string,
name string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists ads_buy_channels;

create table ads_buy_channels (
id int,
seller_id int,
parent_id int,
channel_id int,
channel_name string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists ads_dict_membership_levels;

create table ads_dict_membership_levels (
id int,
seller_id int,
value string,
name string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists ads_dict_store_types;

create table ads_dict_store_types (
id int,
seller_id int,
value string,
name string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');


drop table if exists ads_channels;

create table ads_channels (
id int,
seller_id int,
`channel_source` string comment '渠道来源',
`channel_category1` string comment '一级渠道类型',
`channel_category2` string comment '二级渠道类型',
`channel_category3` string comment '三级渠道类型',
`channel_id` string comment '渠道id',
`channel_name` string comment '渠道名称',
`detail_address` string comment '详细地址',
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_products;

create table ads_products (
id int,
seller_id int,
`product_id` string comment '商品id',
`product_name` string comment '商品名称',
`brand_id` string comment '品牌id',
`brand_name` string comment '品牌名称',
`category_level1_id` string comment '一级品类',
`category_level2_id` string comment '二级品类',
`category_level3_id` string comment '三级品类',
`price` int comment '价格',
`specification` string comment '规格',
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_coupons;

create table ads_coupons (
id int,
seller_id int,
`coupon_id` string comment '优惠券id',
`coupon_name` string comment '优惠券名称',
`start_date` int comment '有效起始期',
`end_date` int comment '有效截至期',
`coupon_type` string comment '优惠券类型',
`discount_amount` int comment '折扣金额',
`discount_ratio` int comment '折扣比例',
`channel_id` string comment '领取渠道id',
`activity_id` string comment '活动id',
`activity_name` string comment '活动名称',
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_activities;

create table ads_activities (
id int,
seller_id int,
`activity_id` string comment '活动id',
`activity_name` string comment '活动名称',
`action_type` string comment '活动类型',
`channel_id` string comment '参与门店',
`product_id` string comment '关联活动商品',
`coupon_id` string comment '优惠券id',
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_basic_infos;

create table ads_basic_infos (
seller_id int,
oneid int,
age int,
gender int,
tel string,
primary key(seller_id, oneid)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_purchases;

create table ads_purchases (
seller_id int,
oneid int,
order_no string,
buy_channel string,
pay_time string,
store_type string,
buy_value int,
primary key(seller_id, oneid, order_no)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_daily_purchases;

create table ads_daily_purchases (
seller_id int,
oneid int,
buy_channel string,
pay_date string,
store_type string,
buy_value int,
primary key(seller_id, oneid, store_type)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_consuming_portraits;

create table ads_consuming_portraits (
seller_id int,
oneid int,
membership_level string,
store_type string,
primary key(seller_id, oneid, store_type)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_crowds;

create table ads_crowds (
id int,
seller_id int,
crowd_id int,
crowd_name string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_crowd_instances;

create table ads_crowd_instances (
id int,
seller_id int,
crowd_id int,
instance_id int,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_crowd_instance_members;

create table ads_crowd_instance_members (
seller_id int,
oneid int,
instance_id int,
primary key(seller_id, instance_id, oneid)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');



drop table if exists ads_event_address;

create table ads_event_address (
id int,
oneid int,
`a` string,
`id_m` string,
`member_name` string,
`gender` string,
`birthday` string,
`id_p` string,
`time` string,
`email` string,
`reg_date` string,
`reg_store` string,
`membership_level` string,
`id_wx` string,
`official_account` string,
`app_id` string,
`app_name` string,
`province` string,
`city` string,
`area` string,
`ip` string,
`timezone` string,
`mac` string,
`browser` string,
`os` string,
`net` string,
`carrier` string,
`model` string,
`sid` string,
`cookie` string,
`agent` string,
`ute` string,
`seller_id` string,
`channel_id` string,
`channel_name` string,
`current_url` string,
`guest_url` string,
`source_url` string,
`source_id` string,
`source_name` string,
`page_id` string,
`page_name` string,
`assembly_id` string,
`assembly_name` string,
`jump_page_id` string,
`jump_page_name` string,
`a_type` string,
`p_type` string,
`a_source` string,
`version` string,
`shop_id` string,
`receiver_address` string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_event_order;

create table ads_event_order (
id int,
oneid int,
`a` string,
`id_m` string,
`member_name` string,
`gender` string,
`birthday` string,
`id_p` string,
`time` string,
`email` string,
`reg_date` string,
`reg_store` string,
`membership_level` string,
`id_wx` string,
`official_account` string,
`app_id` string,
`app_name` string,
`province` string,
`city` string,
`area` string,
`ip` string,
`timezone` string,
`mac` string,
`browser` string,
`os` string,
`net` string,
`carrier` string,
`model` string,
`sid` string,
`cookie` string,
`agent` string,
`ute` string,
`seller_id` string,
`channel_id` string,
`channel_name` string,
`current_url` string,
`guest_url` string,
`source_url` string,
`source_id` string,
`source_name` string,
`page_id` string,
`page_name` string,
`assembly_id` string,
`assembly_name` string,
`jump_page_id` string,
`jump_page_name` string,
`a_type` string,
`p_type` string,
`a_source` string,
`version` string,
`coupon_id` string,
`discount` string,
`is_buy_again` string,
`is_coupon_used` string,
`is_point_used` string,
`is_refund` string,
`is_return` string,
`order_id` string,
`order_status` string,
`payment_amount` string,
`payment_method` string,
`payment_time` string,
`points_consumption` string,
`product_amount` string,
`product_id` string,
`product_num` string,
`receiver_address` string,
`refund_amount` string,
`return_order_id` string,
`return_product_id` string,
`to_shop_or_home_delivery` string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_event_cart;

create table ads_event_cart (
id int,
oneid int,
`a` string,
`id_m` string,
`member_name` string,
`gender` string,
`birthday` string,
`id_p` string,
`time` string,
`email` string,
`reg_date` string,
`reg_store` string,
`membership_level` string,
`id_wx` string,
`official_account` string,
`app_id` string,
`app_name` string,
`province` string,
`city` string,
`area` string,
`ip` string,
`timezone` string,
`mac` string,
`browser` string,
`os` string,
`net` string,
`carrier` string,
`model` string,
`sid` string,
`cookie` string,
`agent` string,
`ute` string,
`seller_id` string,
`channel_id` string,
`channel_name` string,
`current_url` string,
`guest_url` string,
`source_url` string,
`source_id` string,
`source_name` string,
`page_id` string,
`page_name` string,
`assembly_id` string,
`assembly_name` string,
`jump_page_id` string,
`jump_page_name` string,
`a_type` string,
`p_type` string,
`a_source` string,
`version` string,
`is_add_to_shoppingcart` string,
`is_flash_sale` string,
`is_in_stock` string,
`is_modify_good_num_in_shoppingcart` string,
`product_id` string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_event_share;

create table ads_event_share (
id int,
oneid int,
`a` string,
`id_m` string,
`member_name` string,
`gender` string,
`birthday` string,
`id_p` string,
`time` string,
`email` string,
`reg_date` string,
`reg_store` string,
`membership_level` string,
`id_wx` string,
`official_account` string,
`app_id` string,
`app_name` string,
`province` string,
`city` string,
`area` string,
`ip` string,
`timezone` string,
`mac` string,
`browser` string,
`os` string,
`net` string,
`carrier` string,
`model` string,
`sid` string,
`cookie` string,
`agent` string,
`ute` string,
`seller_id` string,
`channel_id` string,
`channel_name` string,
`current_url` string,
`guest_url` string,
`source_url` string,
`source_id` string,
`source_name` string,
`page_id` string,
`page_name` string,
`assembly_id` string,
`assembly_name` string,
`jump_page_id` string,
`jump_page_name` string,
`a_type` string,
`p_type` string,
`a_source` string,
`version` string,
`is_flash_sale` string,
`is_in_stock` string,
`product_id` string,
`share_channel` string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_event_coupon;

create table ads_event_coupon (
id int,
oneid int,
`a` string,
`id_m` string,
`member_name` string,
`gender` string,
`birthday` string,
`id_p` string,
`time` string,
`email` string,
`reg_date` string,
`reg_store` string,
`membership_level` string,
`id_wx` string,
`official_account` string,
`app_id` string,
`app_name` string,
`province` string,
`city` string,
`area` string,
`ip` string,
`timezone` string,
`mac` string,
`browser` string,
`os` string,
`net` string,
`carrier` string,
`model` string,
`sid` string,
`cookie` string,
`agent` string,
`ute` string,
`seller_id` string,
`channel_id` string,
`channel_name` string,
`current_url` string,
`guest_url` string,
`source_url` string,
`source_id` string,
`source_name` string,
`page_id` string,
`page_name` string,
`assembly_id` string,
`assembly_name` string,
`jump_page_id` string,
`jump_page_name` string,
`a_type` string,
`p_type` string,
`a_source` string,
`version` string,
`coupon_id` string,
`number_received` string,
`order_id` string,
`used_num` string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_event_activity;

create table ads_event_activity (
id int,
oneid int,
`a` string,
`id_m` string,
`member_name` string,
`gender` string,
`birthday` string,
`id_p` string,
`time` string,
`email` string,
`reg_date` string,
`reg_store` string,
`membership_level` string,
`id_wx` string,
`official_account` string,
`app_id` string,
`app_name` string,
`province` string,
`city` string,
`area` string,
`ip` string,
`timezone` string,
`mac` string,
`browser` string,
`os` string,
`net` string,
`carrier` string,
`model` string,
`sid` string,
`cookie` string,
`agent` string,
`ute` string,
`seller_id` string,
`channel_id` string,
`channel_name` string,
`current_url` string,
`guest_url` string,
`source_url` string,
`source_id` string,
`source_name` string,
`page_id` string,
`page_name` string,
`assembly_id` string,
`assembly_name` string,
`jump_page_id` string,
`jump_page_name` string,
`a_type` string,
`p_type` string,
`a_source` string,
`version` string,
`activity_id` string,
`activity_name` string,
`coupon_id` string,
`product_id` string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_event_app;

create table ads_event_app (
id int,
oneid int,
`a` string,
`id_m` string,
`member_name` string,
`gender` string,
`birthday` string,
`id_p` string,
`time` string,
`email` string,
`reg_date` string,
`reg_store` string,
`membership_level` string,
`id_wx` string,
`official_account` string,
`app_id` string,
`app_name` string,
`province` string,
`city` string,
`area` string,
`ip` string,
`timezone` string,
`mac` string,
`browser` string,
`os` string,
`net` string,
`carrier` string,
`model` string,
`sid` string,
`cookie` string,
`agent` string,
`ute` string,
`seller_id` string,
`channel_id` string,
`channel_name` string,
`current_url` string,
`guest_url` string,
`source_url` string,
`source_id` string,
`source_name` string,
`page_id` string,
`page_name` string,
`assembly_id` string,
`assembly_name` string,
`jump_page_id` string,
`jump_page_name` string,
`a_type` string,
`p_type` string,
`a_source` string,
`version` string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists ads_event_login;

create table ads_event_login (
id int,
oneid int,
`a` string,
`id_m` string,
`member_name` string,
`gender` string,
`birthday` string,
`id_p` string,
`time` string,
`email` string,
`reg_date` string,
`reg_store` string,
`membership_level` string,
`id_wx` string,
`official_account` string,
`app_id` string,
`app_name` string,
`province` string,
`city` string,
`area` string,
`ip` string,
`timezone` string,
`mac` string,
`browser` string,
`os` string,
`net` string,
`carrier` string,
`model` string,
`sid` string,
`cookie` string,
`agent` string,
`ute` string,
`seller_id` string,
`channel_id` string,
`channel_name` string,
`current_url` string,
`guest_url` string,
`source_url` string,
`source_id` string,
`source_name` string,
`page_id` string,
`page_name` string,
`assembly_id` string,
`assembly_name` string,
`jump_page_id` string,
`jump_page_name` string,
`a_type` string,
`p_type` string,
`a_source` string,
`version` string,
primary key(id)
)
PARTITION BY HASH KEY (`id`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_memberbaseinfo_d;

create table tags_mbr_memberbaseinfo_d (
oneid int,
seller_id int,
`id_m` string,
`gender` string,
`birthday` string,
`id_p` string,
`email` string,
`reg_date` string,
`reg_store` string,
`membership_level` string,
`id_wx` string,
`official_account` string,
`province` string,
`city` string,
`area` string,
`current_points` string,
`used_points` string,
`available_coupon_num` string,
`used_coupon_num` string,
`agebracket` string,
`constellation` string,
primary key(oneid)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_customerlifecyclestage_d;

create table tags_mbr_customerlifecyclestage_d (
oneid int,
seller_id int,
`customerlifecyclestage` string,
primary key(oneid, seller_id)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_memberbuyinfo_d;

create table tags_mbr_memberbuyinfo_d (
oneid int,
seller_id int,
`memberbuyinfo` string,
primary key(oneid, seller_id)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_memberloyalty_d;

create table tags_mbr_memberloyalty_d (
oneid int,
seller_id int,
`memberloyalty` string,
primary key(oneid, seller_id)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_preferredbrand_d;

create table tags_mbr_preferredbrand_d (
oneid int,
seller_id int,
`preferredbrand` string,
primary key(oneid, seller_id)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_preferredcategory_d;

create table tags_mbr_preferredcategory_d (
oneid int,
seller_id int,
`preferredcategory` string,
primary key(oneid, seller_id)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_pricesensitivity_d;

create table tags_mbr_pricesensitivity_d (
oneid int,
seller_id int,
`pricesensitivity` string,
primary key(oneid, seller_id)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_discountsensitivity_d;

create table tags_mbr_discountsensitivity_d (
oneid int,
seller_id int,
`discountsensitivity` string,
primary key(oneid, seller_id)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_preferredconsumptionchannel_d;

create table tags_mbr_preferredconsumptionchannel_d (
oneid int,
seller_id int,
`preferredconsumptionchannel` string,
primary key(oneid, seller_id)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_preferredinteractchannel_d;

create table tags_mbr_preferredinteractchannel_d (
oneid int,
seller_id int,
`preferredinteractchannel` string,
primary key(oneid, seller_id)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');

drop table if exists tags_mbr_preferredactiontype_d;

create table tags_mbr_preferredactiontype_d (
oneid int,
seller_id int,
`preferredactiontype` string,
primary key(oneid, seller_id)
)
PARTITION BY HASH KEY (`oneid`) PARTITION NUM 128
TABLEGROUP cdp
OPTIONS (UPDATETYPE='realtime');