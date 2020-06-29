package com.bugever.lychee.web.servlet;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.Dimension;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// curl 'http://127.0.0.1:8080/api/modeling/dimensions' -d '{}'
@WebServlet("/api/modeling/dimensions")
public class Dimensions extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                         HttpServletResponse response) {
        ServletHandler.handle(request, response, (currentUser) -> Database.list(Dimension.class,
                "select id, seller_id, name, cn_name, remarks, identity_id, data_type," +
                        " creator_id, created_on from m_dimensions where deleted = 0 order by name"));
    }
}
