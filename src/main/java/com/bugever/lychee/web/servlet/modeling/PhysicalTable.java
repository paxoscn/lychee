package com.bugever.lychee.web.servlet.modeling;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.util.ParameterizedQuery;
import com.bugever.lychee.web.servlet.Helper;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/modeling/physical-table' -d '{ "id": 0 }'
@WebServlet("/api/modeling/physical-table")
public class PhysicalTable extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, Helper.IdRequest.class, (currentUser, input) -> {
            com.bugever.lychee.domain.PhysicalTable dimension = new com.bugever.lychee.domain.PhysicalTable();
            if (input.id > 0) {
                ParameterizedQuery query = new ParameterizedQuery(
                        "select pt.id, pt.logical_table_id, lt.name logical_table_name," +
                                " pt.data_source_id, ds.name data_source_name," +
                                " pt.name, pt.remarks, pt.creator_id, pt.created_on" +
                                " from m_physical_tables pt" +
                                " join m_logical_tables lt on pt.logical_table_id = lt.id" +
                                " join m_data_sources ds on pt.data_source_id = ds.id" +
                                " where pt.id = ? and pt.seller_id = ? and pt.deleted = 0",
                        input.id, currentUser.attributes.get(TOKEN_ATTR_SELLER)
                );
                List<com.bugever.lychee.domain.PhysicalTable> list = Database.list(com.bugever.lychee.domain.PhysicalTable.class, query.sql(), query.params());
                if (!list.isEmpty()) {
                    dimension = list.iterator().next();
                }
            }
            return dimension;
        });
    }
}
