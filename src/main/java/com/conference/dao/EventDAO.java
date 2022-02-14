package com.conference.dao;

import com.conference.bean.Event;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO extends DAO {

    private static final String CREATE_EVENT =
            "INSERT INTO events (id, topic, description,date,fromtime,totime,location) " +
                    "VALUES (default, ?, ?, ?, ?, ?, ?)";

    public boolean createEvent(Event event){
        try (Connection con = getConnection();
             PreparedStatement statement = con.prepareStatement(CREATE_EVENT)) {
            statement.setString(1,event.getTopic());
            statement.setString(2,event.getDescription());
            statement.setString(3,event.getDate());
            statement.setString(4,event.getFromtime());
            statement.setString(5,event.getTotime());
            statement.setString(6,event.getLocation().getAddress());
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String DELETE_EVENT =
            "DELETE FROM events WHERE id = ?";

    public boolean deleteEvent(int id){
        try (Connection con = getConnection();
             PreparedStatement statement = con.prepareStatement(DELETE_EVENT)) {
            statement.setInt(1,id);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String UPDATE_EVENT =
            "UPDATE events SET date = ?, fromtime = ?, totime = ?, location = ?,status = ? WHERE id = ?";

    public boolean updateEvent(Event event){
        try (Connection con = getConnection();
             PreparedStatement statement = con.prepareStatement(UPDATE_EVENT)) {
            statement.setString(1,event.getDate());
            statement.setString(2,event.getFromtime());
            statement.setString(3,event.getTotime());
            statement.setString(4,event.getLocation().getAddress());
            statement.setInt(5,event.getStatus());
            statement.setInt(6,event.getId());
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Event> select(String where, int value, String limit, int offset, String order) {

        List<Event> events;
        try (Connection con = getConnection();
             PreparedStatement statement = con.prepareStatement("SELECT * FROM events WHERE " + where + " = " + value + "  ORDER BY " + order + " LIMIT " + limit + " OFFSET " + offset)) {
            ResultSet set = statement.executeQuery();
            events = new ArrayList<>();
            while (set.next()){
                int id = set.getInt("id");
                String topic = set.getString("topic");
                String description = set.getString("description");
                String fromtime = set.getString("fromtime");
                String totime = set.getString("totime");
                String date = set.getString("date");
                String location = set.getString("location");
                int status = set.getInt("status");
                events.add(new Event(id,topic,description,fromtime,totime,date,location, status));
            }
            set.close();
        } catch (SQLException e) {
            e.printStackTrace();
            events = null;
        }
        return events;
    }

    public static void main(String[] args) throws IllegalAccessException {
        System.out.println(new EventDAO().select("id",7,"1",0,"date, fromtime"));
    }
}
