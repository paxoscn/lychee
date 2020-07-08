create table if not exists m_logical_tables (
id int not null auto_increment,
seller_id int not null,
layer varchar(8) not null comment 'ODS, DWD, DWM, DWS, ADS',
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
has_oneid tinyint not null default 0,
is_fact tinyint not null default 0,
creator_id int not null,
created_on datetime not null,
deleted int not null,
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
is_indexed tinyint not null default 0,
creator_id int not null,
created_on datetime not null,
deleted int not null,
primary key(id),
unique key(table_id, name)
);

create table if not exists m_identities (
id int not null auto_increment,
seller_id int not null,
name varchar(8) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null,
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
data_type varchar(16) not null comment 'string, number, boolean, enum, time',
desensitization_method varchar(16) not null default '' comment ', clean, md5, sha1, sha256',
creator_id int not null,
created_on datetime not null,
deleted int not null,
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
creator_id int not null,
created_on datetime not null,
deleted int not null,
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
creator_id int not null,
created_on datetime not null,
deleted int not null,
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
driver varchar(32) not null comment 'hive2, mysql, clickhouse',
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null,
primary key(id),
unique key(seller_id, name)
);

create table if not exists m_data_source_params (
id int not null auto_increment,
data_source_id int not null,
param_name varchar(128) not null,
param_value varchar(256) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null,
primary key(id),
unique key(data_source_id, param_name)
);

create table if not exists m_driver_param_definitions (
id int not null auto_increment,
driver varchar(32) not null comment 'hive2, mysql, clickhouse',
param_name varchar(128) not null comment 'Preset params not needed: host, port, user, password, database',
primary key(id),
unique key(driver, param_name)
);

create table if not exists m_snippets (
id int not null auto_increment,
seller_id int not null,
content text not null,
updated_on datetime not null,
creator_id int not null,
created_on datetime not null,
primary key(id)
);

create table if not exists m_flows (
id int not null auto_increment,
seller_id int not null,
name varchar(128) not null,
crontabs varchar(256) not null default '' comment 'Splited by newline.',
creator_id int not null,
created_on datetime not null,
deleted int not null,
primary key(id)
);

create table if not exists m_jobs (
id int not null auto_increment,
seller_id int not null,
flow_id int not null,
name varchar(128) not null,
queries text not null,
creator_id int not null,
created_on datetime not null,
deleted int not null,
primary key(id)
);

create table if not exists m_job_dependencies (
id int not null auto_increment,
seller_id int not null,
job_id int not null,
depended_job_id int not null,
creator_id int not null,
created_on datetime not null,
deleted int not null,
primary key(id)
);

create table if not exists m_batches (
id int not null auto_increment,
seller_id int not null,
flow_id int not null,
business_time datetime not null,
state varchar(32) not null comment 'init, running, successful, failed, cancelled',
is_adhoc tinyint not null default 0,
creator_id int not null,
created_on datetime not null,
deleted int not null,
primary key(id)
);

create table if not exists m_batch_params (
id int not null auto_increment,
batch_id int not null,
param_name varchar(128) not null,
param_value varchar(256) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null,
primary key(id)
);

create table if not exists m_job_instances (
id int not null auto_increment,
batch_id int not null,
job_id int not null,
run_on datetime not null,
state varchar(32) not null comment 'init, waiting, running, successful, failed, cancelled',
creator_id int not null,
created_on datetime not null,
deleted int not null,
primary key(id)
);

create table if not exists m_migrations (
id int not null auto_increment,
seller_id int not null,
is_exporting tinyint not null default 0,
creator_id int not null,
created_on datetime not null,
primary key(id)
);

insert into m_driver_param_definitions values (1, 'hive2', 'fs');
insert into m_driver_param_definitions values (2, 'hive2', 'root');
insert into m_driver_param_definitions values (3, 'hive2', 'queue');