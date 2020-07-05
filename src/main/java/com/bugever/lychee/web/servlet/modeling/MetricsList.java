package com.bugever.lychee.web.servlet.modeling;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.Metrics;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/modeling/dimensions' -d '{}'
@WebServlet("/api/modeling/metrics-list")
public class MetricsList extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, (currentUser) -> Database.list(Metrics.class,
                "select id, name, cn_name, remarks," +
                        " creator_id, created_on from m_metrics where seller_id = ? and deleted = 0" +
                        " order by name",
                currentUser.attributes.get(TOKEN_ATTR_SELLER)));
    }
}
