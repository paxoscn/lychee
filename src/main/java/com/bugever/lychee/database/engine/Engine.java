package com.bugever.lychee.database.engine;

import java.sql.Connection;
import java.sql.SQLException;

public interface Engine {

    Connection getConnection() throws SQLException;

    boolean isExistException(SQLException e);
}
