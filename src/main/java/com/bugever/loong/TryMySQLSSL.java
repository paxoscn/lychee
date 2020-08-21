package com.bugever.loong;

import java.sql.*;

public class TryMySQLSSL {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://datp-prd-pas-e2-mysql001.mysql.database.chinacloudapi.cn/aeondb?useSSL=true&verifyServerCertificate=false", "JK001@datp-prd-pas-e2-mysql001", "JK@1234");
        Statement stmt = con.createStatement();

        ResultSet rs = stmt.executeQuery("select count(1) from classmst");
        rs.next();

        System.out.println(rs.getInt(1));

        con.close();
    }
}
