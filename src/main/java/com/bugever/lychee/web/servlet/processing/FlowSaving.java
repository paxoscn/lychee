package com.bugever.lychee.web.servlet.processing;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.JobDependency;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.HashSet;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;
import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_USER;

// curl 'http://127.0.0.1:8080/api/processing/flow-saving' -d '{ "name": "" }'
@WebServlet("/api/processing/flow-saving")
public class FlowSaving extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, com.bugever.lychee.domain.Flow.class, (currentUser, input) -> {
            int sellerId = Integer.parseInt(currentUser.attributes.get(TOKEN_ATTR_SELLER));
            int userId = Integer.parseInt(currentUser.attributes.get(TOKEN_ATTR_USER));
            if (input.id > 0) {
                Database.update(sellerId, "m_flows", input, new HashSet<>(Arrays.asList(new String[0])));
            } else {
                input.id = Database.insert(sellerId, userId, "m_flows", input, new HashSet<>(Arrays.asList(new String[0])));
            }
            return null;
        });
    }
}
