package com.bugever.lychee.database.engine;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySQLEngine implements Engine {

    private final String url;
    private final String user;
    private final String password;

    public MySQLEngine(String url, String user, String password) {
        this.url = url;
        this.user = user;
        this.password = password;
    }

    @Override
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }

    @Override
    public boolean isExistException(SQLException e) {
        return false;
    }
}
