package com.conference.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class DAO {
    private static final String URL = "jdbc:postgresql://localhost:5432/conf";
    private static final String UNAME = "postuser";
    private static final String UPASS = "root";

    private static final String FULL = URL + "?user=" + UNAME + "&password=" + UPASS;
    private static final String DRIVER = "org.postgresql.Driver";

    protected Connection getConnection(){
        Connection connection;
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(FULL);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            connection = null;
        }
        return connection;
    }
}
