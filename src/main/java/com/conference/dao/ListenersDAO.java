package com.conference.dao;

import com.conference.entity.Event;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ListenersDAO  {

    private static final String CREATE_LISTENER = "\n" +
            "INSERT INTO listeners (event, listener) " +
            "VALUES (?, ?)";

    public boolean createListener(Connection con, int event, int listener){
        try (PreparedStatement statement = con.prepareStatement(CREATE_LISTENER)) {
            statement.setInt(1,event);
            statement.setInt(2,listener);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    private static final String DELETE_LISTENER = "DELETE FROM listeners WHERE (event = ?) AND (listener = ?)";

    public boolean deleteListener(Connection con, int event, int listener){
        try (PreparedStatement statement = con.prepareStatement(DELETE_LISTENER)) {
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

    public List<Event> selectEventsOfListeners(Connection con,int listener){
        try ( PreparedStatement statement = con.prepareStatement(SELECT_EVENTS_OF_LISTENER)) {
            statement.setInt(1,listener);
            ResultSet set = statement.executeQuery();
            List<Event> events = new ArrayList<>();
            EventDAO edao = new EventDAO();
            while (set.next()){
                events.addAll(edao.select(con,"id", set.getInt(1), "all", 0,"id"));
            }
            set.close();
            return events;
        } catch (SQLException  e) {
            e.printStackTrace();
            return null;
        }
    }

    private static final String SELECT_COUNT_OF_LISTENERS = "SELECT COUNT(listener) FROM listeners WHERE event = ?";

    public int selectCountOfListeners(Connection con, int event){
        try ( PreparedStatement statement = con.prepareStatement(SELECT_COUNT_OF_LISTENERS)) {
            statement.setInt(1,event);
            ResultSet set = statement.executeQuery();
            int amountOfListeners = 0;
            while (set.next()){
                amountOfListeners = set.getInt(1);
            }
            set.close();
            return amountOfListeners;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
}
