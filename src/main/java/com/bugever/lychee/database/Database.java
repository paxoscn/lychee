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
import java.sql.*;
import java.util.Date;
import java.util.*;

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

    public static <E> List<E> list(Class<E> entityType, String sql, Object... params) throws Exception {
        try (Connection conn = engine.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.length; ++i) {
                stmt.setObject(i + 1, params[i]);
            }
            List<E> entities = new LinkedList<>();
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    E entity = entityType.newInstance();
                    entities.add(entity);

                    for (int col = 1; col <= rs.getMetaData().getColumnCount(); col++) {
                        setField(entity, rs, col);
                    }
                }
            }
            return entities;
        }
    }

    public static void update(String sql, Object... params) throws Exception {
        if (sql.contains("insert")) {
            throw new SQLException("update() does not support inserting as it would break id constraint. Use insert() instead.");
        }
        try (Connection conn = engine.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.length; ++i) {
                stmt.setObject(i + 1, params[i]);
            }
            stmt.executeUpdate();
        }
    }

    // Using synchronized for id generating. Single node deployment supported only.
    public static synchronized <E> int insert(int sellerId, int userId, String table, E entity, Set<String> excludedFields) throws Exception {
        List<String> columnNames = new LinkedList<>();
        List<Object> columnValues = new LinkedList<>();
        if (sellerId > 0) {
            columnNames.add("seller_id");
            columnValues.add(sellerId);
        }
        columnNames.add("id");
        columnNames.add("creator_id");
        columnNames.add("created_on");
        columnNames.add("deleted");
        columnValues.add(nextId(table));
        columnValues.add(userId);
        columnValues.add(new Date());
        columnValues.add(0);
        for (Field field : entity.getClass().getFields()) {
            if (field.getName().equals("id")
                    || Collection.class.isAssignableFrom(field.getType())
                    || excludedFields.contains(field.getName())) {
                continue;
            }
            columnNames.add(field.getName());
            columnValues.add(field.get(entity));
        }

        String columnNamesSql = "";
        String columnValuesSql = "";
        boolean started = false;
        for (String columnName : columnNames) {
            if (started) {
                columnNamesSql += ", ";
                columnValuesSql += ", ";
            } else {
                started = true;
            }
            columnNamesSql += columnName;
            columnValuesSql += "?";
        }
        String sql = "insert into " + table + " (" + columnNamesSql + ") values (" + columnValuesSql + ")";

        try (Connection conn = engine.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            for (int i = 0; i < columnValues.size(); ++i) {
                stmt.setObject(i + 1, columnValues.get(i));
            }
            int updated = stmt.executeUpdate();
            if (updated < 1) {
                throw new SQLException("Inserting failed");
            }
            ResultSet rs = stmt.getGeneratedKeys();
            rs.next();
            int key = rs.getInt(1);
            return key;
        }
    }

    public static <E> void update(int sellerId, String table, E entity, Set<String> excludedFields) throws Exception {
        List<String> columnNames = new LinkedList<>();
        List<Object> columnValues = new LinkedList<>();
        for (Field field : entity.getClass().getFields()) {
            if (field.getName().equals("id")
                    || field.getName().equals("creator_id")
                    || field.getName().equals("created_on")
                    || Collection.class.isAssignableFrom(field.getType())
                    || excludedFields.contains(field.getName())) {
                continue;
            }
            columnNames.add(field.getName());
            columnValues.add(field.get(entity));
        }

        String columnsSql = "";
        boolean started = false;
        for (String columnName : columnNames) {
            if (started) {
                columnsSql += ", ";
            } else {
                started = true;
            }
            columnsSql += columnName + " = ?";
        }
        String sql = "update " + table + " set " + columnsSql + " where seller_id = ? and id = ?";
        columnValues.add(sellerId);
        columnValues.add(entity.getClass().getField("id").get(entity));

        try (Connection conn = engine.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (int i = 0; i < columnValues.size(); ++i) {
                stmt.setObject(i + 1, columnValues.get(i));
            }
            stmt.executeUpdate();
        }
    }

    private static void initDataIfNeeded(String protocol) throws SQLException, IOException {
        try (Connection conn = engine.getConnection()) {
            for (String sql : FileUtils.readFileToString(
                    new File("sql/" + protocol + ".sql"), "UTF-8").split(";")) {
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

    private static int nextId(String table) throws SQLException {
        try (Connection conn = engine.getConnection();
             PreparedStatement stmt = conn.prepareStatement("select max(id) from " + table);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) + 1;
            } else {
                return 1;
            }
        }
    }
}
