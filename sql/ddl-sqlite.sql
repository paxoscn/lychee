create table m_logical_tables (
id int not null primary key,
seller_id int not null,
layer varchar(8) not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
has_oneid tinyint not null default 0
);

create table m_logical_table_columns (
id int not null primary key,
table_id int not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
dimension_id int not null default 0,
dimension_group_id int not null default 0,
metrics_id int not null default 0
);

create table m_identities (
id int not null primary key,
seller_id int not null,
name varchar(8) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null
);

create table m_dimension_groups (
id int not null primary key,
seller_id int not null,
cn_name varchar(128) not null,
remarks varchar(256) not null
);

create table m_grouped_dimensions (
id int not null primary key,
group_id int not null,
dimension_id int not null,
remarks varchar(256) not null
);

create table m_dimensions (
id int not null primary key,
seller_id int not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
identity_id int not null default 0,
data_type varchar(16) not null,
desensitization_method varchar(16) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table m_dimension_dictionaries (
id int not null primary key,
dimension_id int not null,
physical_table_data_source_id int not null default 0,
physical_table_name varchar(128) not null default '',
parent_name_column varchar(128) not null default '',
name_column varchar(128) not null default '',
cn_name_column varchar(128) not null default '',
query varchar(512) not null default '',
remarks varchar(256) not null
);

create table m_metrics (
id int not null primary key,
seller_id int not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null
);

create table m_physical_tables (
id int not null primary key,
seller_id int not null,
logical_table_id int not null,
data_source_id int not null,
name varchar(128) not null,
remarks varchar(256) not null
);

create table m_physical_table_columns (
id int not null primary key,
physical_table_id int not null,
logical_table_column_id int not null default 0,
physical_name varchar(128) not null
);

create table m_data_sources (
id int not null primary key,
seller_id int not null,
driver varchar(32) not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null
);

create table m_data_source_params (
id int not null primary key,
data_source_id int not null,
param_name varchar(128) not null,
param_value varchar(256) not null
);

create table m_driver_param_definitions (
id int not null primary key,
driver varchar(32) not null,
param_name varchar(128) not null
);