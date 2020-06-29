package com.bugever.lychee.database.engine;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SQLiteEngine implements Engine {

    private static final Logger log = LoggerFactory.getLogger(SQLiteEngine.class);
    
    private final String url;

    public SQLiteEngine(String url) {
        this.url = url;
    }

    @Override
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url);
    }

    @Override
    public boolean isExistException(SQLException e) {
        // org.sqlite.SQLiteException: [SQLITE_ERROR] SQL error or missing database (table ... already exists)
        return e.getMessage().contains("already exists");
    }
}
