package com.bugever.lychee.database;

import com.bugever.lychee.database.engine.Engine;
import com.bugever.lychee.database.engine.MySQLEngine;
import com.bugever.lychee.database.engine.SQLiteEngine;

import java.io.IOException;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

public class Database {

    private static Engine engine;

    public static void init(String url, String user, String password) throws SQLException, IOException {
        switch (url.split(":")[1]) {
            case "mysql":
                engine = new MySQLEngine(url, user, password);
                break;
            default:
                engine = new SQLiteEngine(url);
                break;
        }
        engine.initDataIfNeeded();
    }

    public static <E> List<E> list(Class<E> entityType, String sql) throws Exception {
        try (Connection conn = engine.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            List<E> entities = new LinkedList<>();
            while (rs.next()) {
                E entity = entityType.newInstance();
                entities.add(entity);

                for (int col = 0; col < rs.getMetaData().getColumnCount(); col++) {
                    setField(entity, rs, col);
                }
            }
            return entities;
        }
    }

    private static <E> void setField(E entity, ResultSet rs, int col) throws SQLException, NoSuchFieldException, IllegalAccessException {
        Field field = entity.getClass().getField(camelCase(rs.getMetaData().getColumnName(col)));
        Object value;
        if (field.getType().equals(String.class)) {
            value = rs.getString(col);
        } else if (field.getType().equals(int.class)) {
            value = rs.getInt(col);
        } else {
            throw new SQLException("Type " + field.getType() + " of field " + field + " not supported");
        }
        field.set(entity, value);
    }

    private static String camelCase(String columnName) {
        return columnName;
    }
}
