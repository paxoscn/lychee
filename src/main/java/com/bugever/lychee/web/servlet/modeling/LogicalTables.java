package com.bugever.lychee.web.servlet.modeling;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.LogicalTable;
import com.bugever.lychee.util.ParameterizedQuery;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/modeling/logical-tables' -d '{}'
@WebServlet("/api/modeling/logical-tables")
public class LogicalTables extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, LogicalTablesRequest.class, (currentUser, input) -> {
            ParameterizedQuery query = new ParameterizedQuery(
                    "select id, layer, name, cn_name, remarks, has_oneid, is_fact, creator_id, created_on" +
                            " from m_logical_tables where seller_id = ? and deleted = 0 {layer} {role}" +
                            " order by name",
                    currentUser.attributes.get(TOKEN_ATTR_SELLER)
            );
            if (input.layer.length() > 0) {
                query.replace("layer", "and layer = ?", input.layer);
            }
            if (input.role.length() > 0) {
                query.replace("role", "and is_fact = ?", input.role.equals("fact"));
            }
            return Database.list(LogicalTable.class, query.sql(), query.params());
        });
    }

    public static class LogicalTablesRequest {
        public String layer;
        public String role;
    }
}
