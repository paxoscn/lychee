package com.bugever.loong;

import java.sql.*;

public class TryHiveTest {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("org.apache.hive.jdbc.HiveDriver");
        Connection con = DriverManager.getConnection("jdbc:hive2://bz-test-bigdata-cdh-02:10000/simbabug", "simba", "simba");

        long start = System.currentTimeMillis();

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select count(1) from user_test");
        rs.next();

        System.out.println(rs.getInt(1));

        System.out.println(System.currentTimeMillis() - start);

        con.close();
    }
}
