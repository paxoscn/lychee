package com.bugever.loong;

import java.sql.*;

public class TryHive {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("org.apache.hive.jdbc.HiveDriver");
//        Connection con = DriverManager.getConnection("jdbc:hive2://localhost:10000/jieke", "hive2", "hive2");
        Connection con = DriverManager.getConnection("jdbc:hive2://172.16.11.131:10000/default", "hdfs", "");
        Statement stmt = con.createStatement();

//        ResultSet rs = stmt.executeQuery("select count(1) from test");
        ResultSet rs = stmt.executeQuery("show tables");
        rs.next();

        System.out.println(rs.getInt(1));

        con.close();
    }
}
