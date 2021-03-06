package com.bugever.lychee.web.servlet.processing;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.Batch;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/processing/batches' -d '{}'
@WebServlet("/api/processing/batches")
public class Batches extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, (currentUser) -> Database.list(Batch.class,
                "select id, flow_id, is_adhoc, business_time, state," +
                        " creator_id, created_on from m_batches where seller_id = ? and deleted = 0" +
                        " order by created_on desc",
                currentUser.attributes.get(TOKEN_ATTR_SELLER)));
    }
}
