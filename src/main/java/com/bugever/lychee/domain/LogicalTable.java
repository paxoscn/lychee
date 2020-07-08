package com.bugever.lychee.domain;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class LogicalTable {
    public int id;
    public String layer;
    public String name;
    public String cn_name;
    public String remarks;
    public int has_oneid;
    public int is_fact;
    public int creator_id;
    public Date created_on;
    public List<LogicalTableColumn> dimension_columns = new LinkedList<>();
    public List<LogicalTableColumn> metrics_columns = new LinkedList<>();

    // 从DDL生成逻辑表时用来暂存表创建语句
    public String query;
}
