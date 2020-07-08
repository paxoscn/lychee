package com.bugever.lychee.web.servlet.modeling;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.LogicalTable;
import com.bugever.lychee.domain.LogicalTableColumn;
import com.bugever.lychee.util.ParameterizedQuery;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;
import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_USER;

// curl 'http://127.0.0.1:8080/api/modeling/logical-tables-saving' -d '{ "tables": [], "data_source_id": 0 }'
@WebServlet("/api/modeling/logical-tables-saving")
public class LogicalTablesSaving extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, LogicalTablesSavingRequest.class, (currentUser, input) -> {
            int sellerId = Integer.parseInt(currentUser.attributes.get(TOKEN_ATTR_SELLER));
            int userId = Integer.parseInt(currentUser.attributes.get(TOKEN_ATTR_USER));
            for (LogicalTable table : input.tables) {
                if (table.id > 0) {
                    Database.update(sellerId, "m_logical_tables", table, new HashSet<>(Arrays.asList(new String[] { "query" })));
                    Database.update("update m_logical_table_columns set deleted = 1 where table_id = ?", table.id);
                } else {
                    table.id = Database.insert(sellerId, userId, "m_logical_tables", table, new HashSet<>(Arrays.asList(new String[] { "query" })));
                }
                for (LogicalTableColumn column : table.dimension_columns) {
                    if (column.dimension_id < 1) {
                        column.dimension_id = Database.insert(sellerId, userId, "m_dimensions", column, new HashSet<>(Arrays.asList(new String[] { "table_id", "dimension_id", "metrics_id", "is_indexed", "ref_name", "identity_name" })));
                    }
                    column.table_id = table.id;
                    Database.insert(0, userId, "m_logical_table_columns", column, new HashSet<>(Arrays.asList(new String[] { "identity_id", "data_type", "desensitization_method", "ref_name", "identity_name" })));
                }
                for (LogicalTableColumn column : table.metrics_columns) {
                    if (column.metrics_id < 1) {
                        column.metrics_id = Database.insert(sellerId, userId, "m_metrics", column, new HashSet<>(Arrays.asList(new String[] { "table_id", "dimension_id", "metrics_id", "is_indexed", "identity_id", "data_type", "desensitization_method", "ref_name", "identity_name" })));
                    }
                    column.table_id = table.id;
                    Database.insert(0, userId, "m_logical_table_columns", column, new HashSet<>(Arrays.asList(new String[] { "identity_id", "data_type", "desensitization_method", "ref_name", "identity_name" })));
                }
                if (input.data_source_id > 0) {
                    com.bugever.lychee.domain.PhysicalTable physicalTable = new com.bugever.lychee.domain.PhysicalTable();
                    physicalTable.logical_table_id = table.id;
                    physicalTable.data_source_id = input.data_source_id;
                    physicalTable.name = table.name;
                    physicalTable.remarks = table.remarks;
                    Database.insert(sellerId, userId, "m_physical_tables", physicalTable, new HashSet<>(Arrays.asList(new String[] { "logical_table_name", "data_source_name" })));
                }
            }
            return null;
        });
    }

    public static class LogicalTablesSavingRequest {
        public List<LogicalTable> tables;
        public int data_source_id;
    }
}
