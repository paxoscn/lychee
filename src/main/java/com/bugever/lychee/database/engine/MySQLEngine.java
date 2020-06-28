package com.bugever.lychee.database.engine;

import java.sql.Connection;

public class MySQLEngine implements Engine {

    public MySQLEngine(String url, String user, String password) {
    }

    @Override
    public void initDataIfNeeded() {

    }

    @Override
    public Connection getConnection() {
        return null;
    }
}
