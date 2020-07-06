package com.bugever.lychee.web.servlet.system;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.LogicalTable;
import com.bugever.lychee.domain.Migration;
import com.bugever.lychee.util.ParameterizedQuery;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/system/logical-tables' -d '{}'
@WebServlet("/api/system/migrations")
public class Migrations extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, (currentUser) -> {
            ParameterizedQuery query = new ParameterizedQuery(
                    "select id, is_exporting, creator_id, created_on" +
                            " from m_migrations where seller_id = ?" +
                            " order by created_on desc",
                    currentUser.attributes.get(TOKEN_ATTR_SELLER)
            );
            return Database.list(Migration.class, query.sql(), query.params());
        });
    }
}
