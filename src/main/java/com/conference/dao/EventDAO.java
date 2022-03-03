package com.conference.dao;

import com.conference.entity.Event;
import com.conference.entity.Lecture;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO extends DAO {

    private static final String CREATE_EVENT =
            "INSERT INTO events (id, topic, description,date,fromtime,totime,location) " +
                    "VALUES (default, ?, ?, ?, ?, ?, ?)";

    public boolean createEvent(Connection con, Event event){
        try (PreparedStatement statement = con.prepareStatement(CREATE_EVENT)) {
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

    public boolean deleteEvent(Connection con,int id){
        try (PreparedStatement statement = con.prepareStatement(DELETE_EVENT)) {
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

    public boolean updateEvent(Connection con, Event event){
        try (PreparedStatement statement = con.prepareStatement(UPDATE_EVENT)) {
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

    public List<Event> select(Connection con, String where, int value, String limit, int offset, String order) {

        List<Event> events;
        try (PreparedStatement statement = con.prepareStatement(
                     "SELECT * FROM events WHERE " + where + " = " + value + "  ORDER BY " + order + " LIMIT " + limit + " OFFSET " + offset);
             PreparedStatement lec = con.prepareStatement(
                     "SELECT id,topic,status,event,speaker FROM lectures WHERE event = ? AND status = 3");
             PreparedStatement selectListeners = con.prepareStatement(
                     "SELECT count(listener) FROM listeners WHERE event = ?"
             )) {
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
                Event event = new Event(id,topic,description,fromtime,totime,date,location, status);

                selectListeners.setInt(1,id);
                ResultSet listenersSet = selectListeners.executeQuery();
                listenersSet.next();
                int listeners = listenersSet.getInt(1);
                event.setListeners(listeners);

                List<Lecture> lectures = new ArrayList<>();
                lec.setInt(1,id);
                ResultSet lecturesSet = lec.executeQuery();
                while (lecturesSet.next()){
                    lectures.add(
                            new Lecture(lecturesSet.getInt(1),
                                    lecturesSet.getString(2),
                                    lecturesSet.getInt(3),
                                    lecturesSet.getInt(4),
                                    lecturesSet.getInt(5)));
                }
                event.setLectures(lectures);
                events.add(event);
            }
            set.close();
        } catch (SQLException e) {
            e.printStackTrace();
            events = null;
        }
        return events;
    }
}
