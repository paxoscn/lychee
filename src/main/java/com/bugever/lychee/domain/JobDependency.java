package com.bugever.lychee.domain;

import java.util.Date;

public class JobDependency {
    public int id;
    public int job_id;
    public int depended_job_id;
    public int creator_id;
    public Date created_on;

    // 传值时冗余
    public String name = "";
}
