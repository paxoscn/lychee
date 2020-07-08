package com.bugever.lychee.web.servlet.processing;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/processing/flow' -d '{ "id": 0 }'
@WebServlet("/api/processing/flow")
public class Flow extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, FlowChildRequest.class, (currentUser, input) -> {
            com.bugever.lychee.domain.Flow flow;
            if (input.id > 0) {
                flow = Database.list(com.bugever.lychee.domain.Flow.class,
                        "select id, name, crontabs from m_flows where id = ? and seller_id = ? and deleted = 0",
                        input.id, currentUser.attributes.get(TOKEN_ATTR_SELLER))
                        .iterator().next();
            } else {
                flow = new com.bugever.lychee.domain.Flow();
                flow.name = "";
                flow.crontabs = "";
            }
            return flow;
        });
    }

    static class FlowChildRequest {
        public int id;
        public int flow_id;
    }
}
