package com.bugever.lychee.database.engine;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class SQLiteEngine implements Engine {

    private static final Logger log = LoggerFactory.getLogger(SQLiteEngine.class);
    
    private final String url;

    public SQLiteEngine(String url) {
        this.url = url;
    }

    @Override
    public void initDataIfNeeded() throws SQLException, IOException {
        try (Connection conn = DriverManager.getConnection(url)) {
            for (String sql : FileUtils.readFileToString(
                    new File("sql/ddl-sqlite.sql"), "UTF-8").split(";")) {
                try (Statement stmt = conn.createStatement()) {
                    int rows = stmt.executeUpdate(sql);
                    System.out.println(sql + " = " + rows);
                } catch (SQLException e) {
                    // 遇到"org.sqlite.SQLiteException: [SQLITE_ERROR] SQL error or missing database (table ... already exists)"异常表示数据库已被初始化过，直接返回即可。
                    if (e.getMessage().contains("already exists")) {
                        log.info("Database ready: {}", url);
                        return;
                    } else {
                        throw e;
                    }
                }
            }
            log.info("Database init done: {}", url);
        }
    }

    @Override
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url);
    }
}
