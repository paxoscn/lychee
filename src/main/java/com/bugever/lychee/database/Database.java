package com.bugever.lychee.database;

import com.bugever.lychee.database.engine.Engine;
import com.bugever.lychee.database.engine.MySQLEngine;
import com.bugever.lychee.database.engine.SQLiteEngine;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class Database {

    private static final Logger log = LoggerFactory.getLogger(Database.class);

    private static Engine engine;

    public static void init(String url, String user, String password) throws SQLException, IOException {
        String protocol = url.split(":")[1];
        switch (protocol) {
            case "mysql":
                engine = new MySQLEngine(url, user, password);
                break;
            default:
                engine = new SQLiteEngine(url);
                break;
        }
        initDataIfNeeded(protocol);
    }

    public static <E> List<E> list(Class<E> entityType, String sql) throws Exception {
        try (Connection conn = engine.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            List<E> entities = new LinkedList<>();
            while (rs.next()) {
                E entity = entityType.newInstance();
                entities.add(entity);

                for (int col = 1; col <= rs.getMetaData().getColumnCount(); col++) {
                    setField(entity, rs, col);
                }
            }
            return entities;
        }
    }

    private static void initDataIfNeeded(String protocol) throws SQLException, IOException {
        try (Connection conn = engine.getConnection()) {
            for (String sql : FileUtils.readFileToString(
                    new File("sql/ddl-" + protocol + ".sql"), "UTF-8").split(";")) {
                try (Statement stmt = conn.createStatement()) {
                    int rows = stmt.executeUpdate(sql);
                    System.out.println(sql + " = " + rows);
                } catch (SQLException e) {
                    // 遇到表示实体重复的异常则意味着数据库已被初始化过，直接返回即可。
                    if (engine.isExistException(e)) {
                        log.info("Database ready: {}", protocol);
                        return;
                    } else {
                        throw e;
                    }
                }
            }
            log.info("Database init done: {}", protocol);
        }
    }

    private static <E> void setField(E entity, ResultSet rs, int col) throws SQLException, NoSuchFieldException, IllegalAccessException {
        Field field = entity.getClass().getField(rs.getMetaData().getColumnName(col));
        Object value;
        if (field.getType().equals(String.class)) {
            value = rs.getString(col);
        } else if (field.getType().equals(int.class)) {
            value = rs.getInt(col);
        } else if (field.getType().equals(Date.class)) {
            value = rs.getTimestamp(col);
        } else {
            throw new SQLException("Type " + field.getType() + " of field " + field + " not supported");
        }
        field.set(entity, value);
    }
}
