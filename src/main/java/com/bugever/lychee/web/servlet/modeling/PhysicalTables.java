package com.bugever.lychee.web.servlet.modeling;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.PhysicalTable;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/modeling/physical-tables' -d '{}'
@WebServlet("/api/modeling/physical-tables")
public class PhysicalTables extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, (currentUser) -> Database.list(PhysicalTable.class,
                "select pt.id, lt.name logical_table_name, ds.name data_source_name," +
                        " pt.name, pt.remarks, pt.creator_id, pt.created_on" +
                        " from m_physical_tables pt" +
                        " join m_logical_tables lt on pt.logical_table_id = lt.id" +
                        " join m_data_sources ds on pt.data_source_id = ds.id" +
                        " where pt.seller_id = ? and pt.deleted = 0" +
                        " order by pt.name",
                currentUser.attributes.get(TOKEN_ATTR_SELLER)));
    }
}
