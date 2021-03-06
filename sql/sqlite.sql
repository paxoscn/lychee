create table m_logical_tables (
id int not null primary key,
seller_id int not null,
layer varchar(8) not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
has_oneid tinyint not null default 0,
is_fact tinyint not null default 0,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table m_logical_table_columns (
id int not null primary key,
table_id int not null,
name varchar(128) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
dimension_id int not null default 0,
dimension_group_id int not null default 0,
metrics_id int not null default 0,
is_indexed tinyint not null default 0,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table m_identities (
id int not null primary key,
seller_id int not null,
name varchar(8) not null,
cn_name varchar(128) not null,
remarks varchar(256) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null
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
remarks varchar(256) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table m_physical_tables (
id int not null primary key,
seller_id int not null,
logical_table_id int not null,
data_source_id int not null,
name varchar(128) not null,
remarks varchar(256) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null
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
remarks varchar(256) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table m_data_source_params (
id int not null primary key,
data_source_id int not null,
param_name varchar(128) not null,
param_value varchar(256) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table m_driver_param_definitions (
id int not null primary key,
driver varchar(32) not null,
param_name varchar(128) not null
);

create table if not exists m_snippets (
id int not null primary key,
seller_id int not null,
content text not null,
updated_on datetime not null,
creator_id int not null,
created_on datetime not null
);


create table if not exists m_flows (
id int not null primary key,
seller_id int not null,
name varchar(128) not null,
crontabs varchar(256) not null default '',
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table if not exists m_jobs (
id int not null primary key,
seller_id int not null,
flow_id int not null,
name varchar(128) not null,
queries text not null,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table if not exists m_job_dependencies (
id int not null primary key,
seller_id int not null,
job_id int not null,
depended_job_id int not null,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table if not exists m_batches (
id int not null primary key,
seller_id int not null,
flow_id int not null,
business_time datetime not null,
state varchar(32) not null,
is_adhoc tinyint not null default 0,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table if not exists m_batch_params (
id int not null primary key,
batch_id int not null,
param_name varchar(128) not null,
param_value varchar(256) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table if not exists m_job_instances (
id int not null primary key,
batch_id int not null,
job_id int not null,
run_on datetime not null,
state varchar(32) not null,
creator_id int not null,
created_on datetime not null,
deleted int not null
);

create table if not exists m_migrations (
id int not null primary key,
seller_id int not null,
is_exporting tinyint not null default 0,
creator_id int not null,
created_on datetime not null
);

insert into m_driver_param_definitions values (1, 'Hive2', 'fs');
insert into m_driver_param_definitions values (2, 'Hive2', 'root');
insert into m_driver_param_definitions values (3, 'Hive2', 'queue');