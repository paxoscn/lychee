package com.bugever.lychee.domain;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class Job {
    public int id;
    public int flow_id;
    public String name;
    public String queries;
    public int creator_id;
    public Date created_on;
    public List<JobDependency> dependencies = new LinkedList<>();
}
