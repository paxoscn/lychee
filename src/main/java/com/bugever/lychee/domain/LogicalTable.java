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
    public List<LogicalTableColumn> columns = new LinkedList<>();
}
