package com.conference.dao;

import com.conference.bean.Event;
import com.conference.bean.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {
    private final static String URL = "jdbc:postgresql://localhost:5432/conf";
    private final static String UNAME = "postuser";
    private final static String UPASS = "root";

    private final static String FULL = URL + "?user=" + UNAME + "&password=" + UPASS;
    private final static String DRIVER = "org.postgresql.Driver";


    private Connection getConnection(){
        Connection connection;
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL,UNAME,UPASS);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            connection = null;
        }
        return connection;
    }

    private static final String CREATE_TOPIC =
            "INSERT INTO events (id, topic, description) " +
                    "VALUES (default, ?, ?)";

    public boolean createTopic(Event event){
        try (PreparedStatement statement = getConnection().prepareStatement(CREATE_TOPIC)) {
            statement.setString(1,event.getTopic());
            statement.setString(2,event.getDescription());
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String CREATE_EVENT =
            "INSERT INTO events (id, topic, description, time, date, online, location, speaker) " +
                    "VALUES (default, ?, ?, ?, ?, ?, ?, ?)";

    public boolean createEvent(Event event){
        try (PreparedStatement statement = getConnection().prepareStatement(CREATE_EVENT)) {
            statement.setString(1,event.getTopic());
            statement.setString(2,event.getDescription());
            statement.setString(3,event.getTime());
            statement.setString(4,event.getDate());
            statement.setBoolean(5,event.getCondition());
            statement.setString(6,event.getLocation());
            statement.setInt(7,event.getSpeaker());
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String SELECT_ALL_READY = "SELECT * FROM events WHERE location IS NOT NULL AND time IS NOT NULL AND date IS NOT NULL";

    public List<Event> selectAllReady(){
        List<Event> events;
        try (PreparedStatement statement = getConnection().prepareStatement(SELECT_ALL_READY)) {
            events = new ArrayList<>();
            ResultSet set = statement.executeQuery();
            while (set.next()){
                int id = set.getInt("id");
                String topic = set.getString("topic");
                String description = set.getString("description");
                String time = set.getString("time");
                String date = set.getString("date");
                boolean online = set.getBoolean("online");
                String location = set.getString("location");
                int speaker = set.getInt("speaker");
                events.add(new Event(id,topic,description,speaker,time,date,online,location));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            events = null;
        }
        return events;
    }
}
