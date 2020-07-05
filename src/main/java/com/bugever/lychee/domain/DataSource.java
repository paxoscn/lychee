package com.bugever.lychee.domain;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class DataSource {
    public int id;
    public String driver;
    public String name;
    public String cn_name;
    public String remarks;
    public int creator_id;
    public Date created_on;
    public List<DataSourceParam> params = new LinkedList<>();
}
