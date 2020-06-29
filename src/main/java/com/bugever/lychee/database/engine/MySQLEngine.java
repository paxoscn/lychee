package com.bugever.lychee.database.engine;

import java.sql.Connection;
import java.sql.SQLException;

public class MySQLEngine implements Engine {

    public MySQLEngine(String url, String user, String password) {
    }

    @Override
    public Connection getConnection() {
        return null;
    }

    @Override
    public boolean isExistException(SQLException e) {
        return false;
    }
}
