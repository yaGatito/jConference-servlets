package com.conference.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.TimeUnit;

public class DBCPoolTest {
    private static DBCPoolTest instance = null;
    private static final int maxConnections = 20;

    public static DBCPoolTest getInstance() {
        if (instance == null)
            instance = new DBCPoolTest();
        return instance;
    }

    private final BlockingQueue<Connection> connections = new ArrayBlockingQueue<>(maxConnections);

    private DBCPoolTest() {
        try (FileInputStream fis = new FileInputStream("C:\\Users\\Nikita\\IdeaProjects\\jConference\\src\\main\\resources\\db_test.properties")) {
            Properties config = new Properties();
            config.load(fis);
            String url = config.getProperty("url");
            String db = config.getProperty("db");
            String user = config.getProperty("user");
            String password = config.getProperty("password");
            String driver = config.getProperty("driver");
            String fullUrl = url + db + "?user=" + user + "&password=" + password;

            Connection connection;
            while (connections.remainingCapacity() > 0) {
                try {
                    Class.forName(driver);
                    connection = DriverManager.getConnection(fullUrl);
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    connection = null;
                }
                if (connection != null) {
                    connections.add(connection);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        Connection connection;
        try {
            connection = connections.poll(2, TimeUnit.SECONDS);
        } catch (InterruptedException e) {
            e.printStackTrace();
            connection = null;
        }
        return connection;
    }

    public int getConnectionsSize() {
        return connections.size();
    }

    public void putBackConnection(Connection connection) {
        connections.add(connection);
    }
}

