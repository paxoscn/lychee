package com.bugever.lychee.domain;

public class LogicalTableColumn {
    public int id;
    public int table_id;
    public String name;
    public String cn_name;
    public String remarks;
    public int dimension_id;
    public int metrics_id;
    public int is_indexed;
    public int identity_id;
    public String data_type;
    public String desensitization_method;

    // 传值时冗余。可能为维度或指标的名称
    public String ref_name = "";
    // 传值时冗余
    public String identity_name = "";
}
