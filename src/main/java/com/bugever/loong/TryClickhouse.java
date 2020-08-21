package com.bugever.loong;

import java.sql.*;

public class TryClickhouse {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("ru.yandex.clickhouse.ClickHouseDriver");
        Connection con = DriverManager.getConnection("jdbc:clickhouse://localhost:8123/system", "default", "");
        Statement stmt = con.createStatement();

        ResultSet rs = stmt.executeQuery("select count(1) from tables");
        rs.next();

        System.out.println(rs.getInt(1));

        con.close();
    }
}
