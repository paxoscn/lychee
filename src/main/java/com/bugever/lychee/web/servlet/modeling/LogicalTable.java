package com.bugever.lychee.web.servlet.modeling;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.LogicalTableColumn;
import com.bugever.lychee.util.ParameterizedQuery;
import com.bugever.lychee.web.servlet.Helper;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/modeling/logical-table' -d '{ "id": 0 }'
@WebServlet("/api/modeling/logical-table")
public class LogicalTable extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, Helper.IdRequest.class, (currentUser, input) -> {
            com.bugever.lychee.domain.LogicalTable logicalTable = new com.bugever.lychee.domain.LogicalTable();
            if (input.id > 0) {
                ParameterizedQuery query = new ParameterizedQuery(
                        "select id, layer, name, cn_name, remarks, has_oneid, is_fact, creator_id, created_on" +
                                " from m_logical_tables where id = ? and seller_id = ? and deleted = 0",
                        input.id, currentUser.attributes.get(TOKEN_ATTR_SELLER)
                );
                List<com.bugever.lychee.domain.LogicalTable> list = Database.list(com.bugever.lychee.domain.LogicalTable.class, query.sql(), query.params());
                if (!list.isEmpty()) {
                    logicalTable = list.iterator().next();
                    List<LogicalTableColumn> columns = Database.list(LogicalTableColumn.class,
                            "select c.id, c.name, c.cn_name, case when c.metrics_id > 0 then m.name else d.name end ref_name, c.remarks, c.dimension_id, c.metrics_id, c.is_indexed," +
                                    " d.identity_id, d.data_type, d.desensitization_method" +
                                    " from m_logical_table_columns c" +
                                    " left join m_dimensions d on c.dimension_id = d.id" +
                                    " left join m_metrics m on c.metrics_id = m.id" +
                                    " where c.table_id = ? and c.deleted = 0" +
                                    " order by c.name",
                            logicalTable.id);
                    for (LogicalTableColumn column : columns) {
                        if (column.metrics_id > 0) {
                            column.dimension_id = -1;
                            logicalTable.metrics_columns.add(column);
                        } else {
                            logicalTable.dimension_columns.add(column);
                        }
                    }
                }
            }
            return logicalTable;
        });
    }
}
