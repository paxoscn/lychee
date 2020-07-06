package com.bugever.lychee.domain;

import java.util.Date;

public class JobInstance {
    public int id;
    public int batch_id;
    public int job_id;
    public Date run_on;
    public String state;
    public int creator_id;
    public Date created_on;
}
