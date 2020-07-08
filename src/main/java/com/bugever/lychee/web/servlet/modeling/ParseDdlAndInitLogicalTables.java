package com.bugever.lychee.web.servlet.modeling;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.Dimension;
import com.bugever.lychee.domain.LogicalTableColumn;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/modeling/parse-ddl-and-init-logical-tables' -d '{ "ddl": "" }'
@WebServlet("/api/modeling/parse-ddl-and-init-logical-tables")
public class ParseDdlAndInitLogicalTables extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, ParseDdlAndInitLogicalTablesRequest.class, (currentUser, input) -> {
            ParseDdlAndInitLogicalTablesResponse res = new ParseDdlAndInitLogicalTablesResponse();
            res.tables = input.parse();

            res.dimensions = Database.list(Dimension.class,
                    "select id, name, data_type from m_dimensions where seller_id = ? and deleted = 0",
                    currentUser.attributes.get(TOKEN_ATTR_SELLER));

            Map<String, Dimension> dimensionMap = res.dimensions.stream().collect(Collectors.toMap((d) -> d.name, (d) -> d));
            res.tables.forEach((createTable) -> {
                createTable.dimension_columns.forEach(column -> {
                    Dimension dimension = dimensionMap.get(column.name);
                    if (dimension != null) {
                        column.dimension_id = dimension.id;
                        column.ref_name = dimension.name;
                    }
                });
            });
            return res;
        });
    }

    public static class ParseDdlAndInitLogicalTablesRequest {
        public String ddl;

        public List<com.bugever.lychee.domain.LogicalTable> parse() {
            List<com.bugever.lychee.domain.LogicalTable> tables = new LinkedList<>();

            ddl = ddl.trim().toLowerCase().replace("\t", " ").replace("\n", " ");
            while (ddl.contains("  ")) {
                ddl = ddl.replace("  ", " ");
            }

            Matcher m = Pattern.compile("/\\*.+?\\*/").matcher(ddl);
            while (m.find()) {
                ddl = ddl.replace(m.group(), "");
            }

            for (String query : ddl.split(";")) {
                query = query.trim();
                if (!query.startsWith("create table ")) {
                    continue;
                }

                com.bugever.lychee.domain.LogicalTable table = new com.bugever.lychee.domain.LogicalTable();
                tables.add(table);
                table.query = query.replace(",", ",\n");
                table.cn_name = table.name = query.substring("create table ".length())
                        .replaceFirst(".*exists ", "")
                        .replaceFirst("[ \\(].+", "")
                        .replace("`", "");
                table.remarks = "";
                if (table.name.contains("_") && table.name.length() > 1) {
                    switch (table.name.substring(0, table.name.indexOf("_"))) {
                        case "ads":
                            table.layer = "ADS";
                            break;
                        case "dws":
                            table.layer = "DWS";
                            break;
                        case "dwm":
                            table.layer = "DWM";
                            break;
                        case "dwd":
                        case "dw":
                            table.layer = "DWD";
                            break;
                        default:
                            table.layer = "ODS";
                            break;
                    }
                }
                for (String column : query.substring(query.indexOf("(") + 1, query.indexOf(")")).split("\\,")) {
                    column = column.trim();
                    if (column.contains(" key")) {
                        continue;
                    }

                    StringTokenizer st = new StringTokenizer(column);

                    String columnName = st.nextToken().replace("`", "");
                    if (columnName.equals("oneid")) {
                        table.has_oneid = 1;
                        continue;
                    }

                    LogicalTableColumn tableColumn = new LogicalTableColumn();
                    table.dimension_columns.add(tableColumn);
                    tableColumn.cn_name = tableColumn.name = columnName;
                    tableColumn.remarks = "";
                    tableColumn.desensitization_method = "";
                    switch (st.nextToken().replaceFirst("\\(.+", "")) {
                        case "int":
                        case "bigint":
                        case "smallint":
                        case "tinyint":
                        case "float":
                        case "double":
                        case "decimal":
                            tableColumn.data_type = "number";
                            break;
                        case "date":
                        case "datetime":
                        case "timestamp":
                            tableColumn.data_type = "time";
                            break;
                        default:
                            tableColumn.data_type = "string";
                            break;
                    }
                }
            }

            return tables;
        }
    }

    public static class ParseDdlAndInitLogicalTablesResponse {
        public List<com.bugever.lychee.domain.LogicalTable> tables;
        public List<Dimension> dimensions;
    }
}
