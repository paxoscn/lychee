package com.bugever.lychee.web.servlet.processing;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.Batch;
import com.bugever.lychee.domain.Flow;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/processing/flows' -d '{}'
@WebServlet("/api/processing/flows")
public class Flows extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, (currentUser) -> Database.list(Flow.class,
                "select id, name, crontabs," +
                        " creator_id, created_on from m_flows where seller_id = ? and deleted = 0" +
                        " order by created_on desc",
                currentUser.attributes.get(TOKEN_ATTR_SELLER)));
    }
}
