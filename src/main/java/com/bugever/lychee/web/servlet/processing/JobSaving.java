package com.bugever.lychee.web.servlet.processing;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.JobDependency;
import com.bugever.lychee.domain.LogicalTable;
import com.bugever.lychee.domain.LogicalTableColumn;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;
import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_USER;

// curl 'http://127.0.0.1:8080/api/processing/job-saving' -d '{ "name": "" }'
@WebServlet("/api/processing/job-saving")
public class JobSaving extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, com.bugever.lychee.domain.Job.class, (currentUser, input) -> {
            int sellerId = Integer.parseInt(currentUser.attributes.get(TOKEN_ATTR_SELLER));
            int userId = Integer.parseInt(currentUser.attributes.get(TOKEN_ATTR_USER));
            if (input.id > 0) {
                Database.update(sellerId, "m_jobs", input, new HashSet<>(Arrays.asList(new String[0])));
                Database.update("update m_job_dependencies set deleted = 1 where job_id = ?", input.id);
            } else {
                input.id = Database.insert(sellerId, userId, "m_jobs", input, new HashSet<>(Arrays.asList(new String[0])));
            }
            for (JobDependency dependency : input.dependencies) {
                dependency.job_id = input.id;
                Database.insert(sellerId, userId, "m_job_dependencies", dependency, new HashSet<>(Arrays.asList(new String[] { "name" })));
            }
            return null;
        });
    }
}
