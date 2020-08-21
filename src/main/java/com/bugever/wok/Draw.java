package com.bugever.wok;

import com.bugever.wok.domain.Column;
import com.bugever.wok.domain.Table;

import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;

public class Draw {

    private Map<String, String> refToTable = new HashMap<>();
    private String[] excludedTablePatterns;
    private Set<String> excludedColumns;

    public Draw(Map<String, String> refToTable, String[] excludedTablePatterns, Set<String> excludedColumns) {
        this.refToTable = refToTable;
        this.excludedTablePatterns = excludedTablePatterns;
        this.excludedColumns = excludedColumns;
    }

    public void start() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://rm-bp18a079063jufo39o.mysql.rds.aliyuncs.com:3306/simba", "simba", "z9es9EoHD0VKLg");

        List<String> allTableNames = showTables(con);

        List<String> tableNames = allTableNames.stream()
                .filter((tableName) -> !excluded(tableName))
                .filter((tableName) -> !allTableNames.contains(tableName + "_v2"))
                .collect(Collectors.toList());

        Map<String, Table> nameToTable = new HashMap<>();
        for (String tableName : tableNames) {
            Table table = showCreateTable(con, tableName);
            nameToTable.put(tableName, table);
        }

        con.close();

        drawUML(nameToTable);
    }

    private void drawUML(Map<String, Table> nameToTable) {
        StringBuilder umlString = new StringBuilder();

        umlString.append("@startuml\n");

        StringBuilder refsString = new StringBuilder();

        for (Table table : nameToTable.values()) {
            StringBuilder tableString = new StringBuilder();

            String className = className(table);

            tableString.append("class " + className + " {\n");

            for (Column column : table.getColumns()) {
                tableString.append("  " + column.getName() + (column.getComment().length() > 0 ? ("__" + column.getComment().replace(" ", "_").replace("(", "<").replace(")", ">")) : "") + " " + column.getType() + "\n");

                String refTargetTable = refToTable.get(column.getName());
                if (refTargetTable != null) {
                    refsString.append(className + " \"N\" -- \"1\" " + className(nameToTable.get(refTargetTable)) + "\n");
                }
            }

            tableString.append("}\n");

            umlString.append(tableString);
        }

        umlString.append(refsString);

        umlString.append("@enduml\n");

        System.out.println(umlString);
    }

    private String className(Table table) {
        return table.getName() + (table.getComment().length() > 0 ? ("__" + table.getComment().replace(" ", "_")) : "");
    }

    private Table showCreateTable(Connection con, String tableName) throws SQLException {
        Table table = new Table(tableName);

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("show create table " + tableName);

        rs.next();

        String ddl = rs.getString(2);
        String[] lines = ddl.split("\n");
        for (String line : lines) {
            line = line.trim();
            if (line.startsWith("`")) {
                String[] ps = line.split(" ");
                String columnName = ps[0].replace("`", "");

                if (excludedColumns.contains(columnName)) {
                    continue;
                }

                String columnType = ps[1].replaceFirst("\\(.+", "");
                String comment = "";
                if (line.contains("COMMENT")) {
                    comment = line.substring(line.indexOf("COMMENT") + 9, line.lastIndexOf("'")).trim()
                            .replace("--", ":")
                            .replaceFirst("[\\s;,.:；，。：].*", "")
                            .replace("\\r", "");
                }
                table.addColumn(new Column(columnName, columnType, comment));
            } else if (line.contains("KEY")) {
                String[] ps = line.split(" ");
                String[] keys = ps[ps.length - 1].replace("`", "").replace("(", "").replace(")", "").replace(",", "").split("\\,");
                table.addKeys(keys);
            } else if (line.contains("ENGINE")) {
                if (line.contains("COMMENT")) {
                    String[] ps = line.split(" ");
                    String comment = ps[ps.length - 1].trim().replaceFirst("^.+=", "").replace("'", "");
                    table.setComment(comment);
                }
            }
        }

        return table;
    }

    private List<String> showTables(Connection con) throws SQLException {
        List<String> tables = new LinkedList<>();

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("show tables");

        while (rs.next()) {
            String table = rs.getString(1);
            tables.add(table);
        }

        return tables;
    }

    private boolean excluded(String tableName) {
        for (String pattern : excludedTablePatterns) {
            if (tableName.matches(pattern)) {
                return true;
            }
        }
        return false;
    }

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        new Draw(
                new HashMap() {{
//                    put("project_id", "tbl_simba_project");
                    put("job_id", "tbl_simba_job_base");
                    put("role_id", "tbl_simba_role");
                }},
                new String[] {
                        ".*test.*",
                        ".*tmp.*",
                        ".*_bak.*",
                        ".*_dep.*",
                        ".*[^v]([0-9]+)",
                        ".*_xysh"
                },
                new HashSet<>(Arrays.asList(new String[] {
                        "id",
                        "create_time",
                        "create_user",
                        "modify_time",
                        "modify_user",
                        "deleted"
                }))).start();
    }
}
