package com.conference.dao;

import com.conference.bean.Event;
import com.conference.bean.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ListenersDAO {
    private final static String URL = "jdbc:postgresql://localhost:5432/conf";
    private final static String UNAME = "postuser";
    private final static String UPASS = "root";

    private final static String FULL = URL + "?user=" + UNAME + "&password=" + UPASS;
    private final static String DRIVER = "org.postgresql.Driver";



    private Connection getConnection(){
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

    static class Listener{
        int event;
        int user;
    }

    private static final String CREATE_LISTENER = "\n" +
            "INSERT INTO listeners (event, listener) " +
            "VALUES (?, ?)";

    public boolean createListener(int event, int listener){
        try (Connection con = getConnection(); PreparedStatement statement = con.prepareStatement(CREATE_LISTENER)) {
            statement.setInt(1,event);
            statement.setInt(2,listener);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String DELETE_LISTENER = "DELETE FROM listeners WHERE (event = ?) AND (listener = ?)";

    public boolean deleteListener(int event, int listener){
        try (Connection con = getConnection(); PreparedStatement statement = con.prepareStatement(DELETE_LISTENER)) {
            statement.setInt(1,event);
            statement.setInt(2,listener);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String SELECT_EVENTS_OF_LISTENER = "SELECT event FROM listeners WHERE listener = ?";

    public List<Event> selectEventsOfListeners(int listener){
        try (Connection con = getConnection(); PreparedStatement statement = con.prepareStatement(SELECT_EVENTS_OF_LISTENER)) {
            statement.setInt(1,listener);
            ResultSet set = statement.executeQuery();
            List<Event> events = new ArrayList<>();
            EventDAO edao = new EventDAO();
            while (set.next()){
                events.addAll(edao.selectBy(SELECT.ID, set.getInt(1)));
            }
            set.close();
            return events;
        } catch (SQLException | IllegalAccessException e) {
            e.printStackTrace();
            return null;
        }
    }
}
