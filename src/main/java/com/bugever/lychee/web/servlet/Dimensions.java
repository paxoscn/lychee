package com.bugever.lychee.web.servlet;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.Dimension;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/modeling/dimensions")
public class Dimensions extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) {
        ServletHandler.handle(request, response, () -> Database.list(Dimension.class,
                "select id, name, cn_name, type, table_id, creator_id, created_on from dimensions where deleted = 0 order by name"));
    }
}
