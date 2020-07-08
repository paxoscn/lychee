package com.bugever.lychee.web.servlet.processing;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.JobDependency;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/processing/job' -d '{ "id": 1 }'
@WebServlet("/api/processing/job")
public class Job extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, FlowChildRequest.class, (currentUser, input) -> {
            com.bugever.lychee.domain.Job job;
            if (input.id > 0) {
                job = Database.list(com.bugever.lychee.domain.Job.class,
                        "select id, flow_id, name, queries from m_jobs where id = ? and seller_id = ? and deleted = 0",
                        input.id, currentUser.attributes.get(TOKEN_ATTR_SELLER))
                        .iterator().next();
                job.dependencies = Database.list(JobDependency.class,
                        "select d.id, d.depended_job_id, j.name from m_job_dependencies d join m_jobs j" +
                                " on d.depended_job_id = j.id where d.job_id = ? and d.deleted = 0",
                        job.id);
            } else {
                job = new com.bugever.lychee.domain.Job();
                job.flow_id = input.flow_id;
                job.name = "";
                job.queries = "";
            }
            return job;
        });
    }

    static class FlowChildRequest {
        public int id;
        public int flow_id;
    }
}
