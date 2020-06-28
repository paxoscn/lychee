package com.bugever.lychee.database.engine;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

public interface Engine {

    void initDataIfNeeded() throws SQLException, IOException;

    Connection getConnection() throws SQLException;
}
