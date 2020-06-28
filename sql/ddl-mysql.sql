create table if not exists m_logical_tables (
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

create table if not exists m_logical_table_columns (
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

create table if not exists m_identities (
id int not null auto_increment,
seller_id int not null,
name varchar(8) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
primary key(id),
unique key(seller_id, name)
);

create table if not exists m_dimension_groups (
id int not null auto_increment,
seller_id int not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
primary key(id),
unique key(seller_id, cn_name)
);

create table if not exists m_grouped_dimensions (
id int not null auto_increment,
group_id int not null,
dimension_id int not null,
remarks varchar(256) not null,
primary key(id),
unique key(group_id, dimension_id)
);

create table if not exists m_dimensions (
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

create table if not exists m_dimension_dictionaries (
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

create table if not exists m_metrics (
id int not null auto_increment,
seller_id int not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
primary key(id),
unique key(seller_id, name)
);

create table if not exists m_physical_tables (
id int not null auto_increment,
seller_id int not null,
logical_table_id int not null,
data_source_id int not null,
name varchar(128) not null,
remarks varchar(256) not null,
primary key(id),
unique key(seller_id, name)
);

create table if not exists m_physical_table_columns (
id int not null auto_increment,
physical_table_id int not null,
logical_table_column_id int not null default 0,
physical_name varchar(128) not null,
primary key(id),
unique key(physical_table_id, logical_table_column_id)
);

create table if not exists m_data_sources (
id int not null auto_increment,
seller_id int not null,
driver varchar(32) not null comment 'Hive, MySQL, Clickhouse',
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
primary key(id),
unique key(seller_id, name)
);

create table if not exists m_data_source_params (
id int not null auto_increment,
data_source_id int not null,
param_name varchar(128) not null,
param_value varchar(256) not null,
primary key(id),
unique key(data_source_id, param_name)
);

create table if not exists m_driver_param_definitions (
id int not null auto_increment,
driver varchar(32) not null comment 'Hive, MySQL, Clickhouse',
param_name varchar(128) not null,
primary key(id),
unique key(driver, param_name)
);