package com.bugever.lychee.web.servlet.processing;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.*;
import com.bugever.lychee.util.ParameterizedQuery;
import com.bugever.lychee.web.servlet.Helper;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/processing/batch' -d '{ "id": 0 }'
@WebServlet("/api/processing/batch")
public class Batch extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, BatchRequest.class, (currentUser, input) -> {
            DAG dag;
            if (input.id > 0) {
                com.bugever.lychee.domain.Batch batch = Database.list(com.bugever.lychee.domain.Batch.class,
                        "select flow_id from m_batches where id = ? and seller_id = ? and deleted = 0",
                        input.id, currentUser.attributes.get(TOKEN_ATTR_SELLER))
                        .iterator().next();
                dag = Jobs.dag(currentUser, batch.flow_id);
                dag.instances = Database.list(JobInstance.class,
                        "select id, job_id, run_on, state" +
                                " from m_job_instances where batch_id = ? and deleted = 0",
                        input.id);
            } else {
                dag = Jobs.dag(currentUser, input.flow_id);
            }
            return dag;
        });
    }

    public static class BatchRequest {
        public int id;
        public int flow_id;
    }
}
