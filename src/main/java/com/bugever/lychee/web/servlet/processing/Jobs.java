package com.bugever.lychee.web.servlet.processing;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.DAG;
import com.bugever.lychee.domain.Job;
import com.bugever.lychee.domain.JobDependency;
import com.bugever.lychee.web.servlet.Helper;
import com.bugever.lychee.web.servlet.ServletHandler;
import com.bugever.visa.CurrentUser;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/processing/jobs' -d '{}'
@WebServlet("/api/processing/jobs")
public class Jobs extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, Helper.IdRequest.class, (currentUser, input) -> dag(currentUser, input.id));
    }

    static DAG dag(CurrentUser currentUser, int flowId) throws Exception {
        DAG dag = new DAG();
        dag.jobs = Database.list(Job.class,
                "select id, name, sql_job_id, syn_job_id, creator_id, created_on" +
                        " from m_jobs where flow_id = ? and seller_id = ? and deleted = 0",
                flowId, currentUser.attributes.get(TOKEN_ATTR_SELLER));
        dag.deps = Database.list(JobDependency.class,
                "select id, job_id, depended_job_id, creator_id, created_on" +
                        " from m_job_dependencies where seller_id = ? and deleted = 0",
                currentUser.attributes.get(TOKEN_ATTR_SELLER));
        return dag;
    }
}
