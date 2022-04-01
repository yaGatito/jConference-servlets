package com.conference.dao;

import com.conference.entity.Event;
import com.conference.entity.Lecture;
import com.conference.entity.Tag;
import com.conference.entity.User;
import com.conference.util.MailSender;

import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;

public class EventDAO {

    public boolean createEvent(Connection con, Event event) {
        try (PreparedStatement statement = con.prepareStatement(
                "INSERT INTO events (id, topic, date, fromtime, totime, location, status) VALUES (default, ?, ?, ?, ?, ?, ?)");
             PreparedStatement getId = con.prepareStatement(
                     "SELECT id FROM events WHERE status = ?");
             PreparedStatement reset = con.prepareStatement(
                     "UPDATE events SET status = ? WHERE id = ?")) {

            //Creating unique status for fast searching just created event
            int uniqueStatus = (int) (Math.random() * 1000000) + 2;

            //Creating event
            con.setAutoCommit(false);
            statement.setString(1, event.getTopic());
            statement.setString(2, event.getDate());
            statement.setString(3, event.getFromtime());
            statement.setString(4, event.getTotime());
            statement.setString(5, event.getLocation().getAddress());
            statement.setInt(6, uniqueStatus);
            statement.executeUpdate();

            //Getting id of created event
            getId.setInt(1, uniqueStatus);
            ResultSet set = getId.executeQuery();
            set.next();
            int eventId = set.getInt(1);

            //Reset status
            reset.setInt(1, 1);
            reset.setInt(2, eventId);
            reset.executeUpdate();

            //Associating event to tags
            TagDAO tdao = new TagDAO();
            List<Tag> tags = event.getTags();
            tdao.associateTagToEvent(con, eventId, tags);

            con.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static final String DELETE_EVENT =
            "DELETE FROM events WHERE id = ?";

    public boolean deleteEvent(Connection con, int id) {
        try (PreparedStatement statement = con.prepareStatement(DELETE_EVENT)) {
            statement.setInt(1, id);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Map<String, String> updateEvent(Connection con, Event event) {
        try (PreparedStatement statement = con.prepareStatement(
                "UPDATE events SET topic = ?, date = ?, fromtime = ?, totime = ?, " +
                        "location = ?,status = ? WHERE id = ?")) {
            con.setAutoCommit(false);

            Event previousEvent = select(con, "id", event.getId(), "1", 0, "id", "en").get(0);

            statement.setString(1, event.getTopic());
            statement.setString(2, event.getDate());
            statement.setString(3, event.getFromtime());
            statement.setString(4, event.getTotime());
            statement.setString(5, event.getLocation().getAddress());
            statement.setInt(6, event.getStatus());
            statement.setInt(7, event.getId());
            statement.executeUpdate();

            Map<String, String> changes = new HashMap<>();
            if (!previousEvent.getFromtime().equals(event.getFromtime())) {
                changes.put("Start time", event.getFromtime());
            }
            if (!previousEvent.getTotime().equals(event.getTotime())) {
                changes.put("End time", event.getTotime());
            }
            if (!previousEvent.getDate().equals(event.getDate())) {
                changes.put("Date", event.getDate());
            }
            if (!previousEvent.getLocation().getAddress().equals(event.getLocation().getAddress())) {
                changes.put("<a href=" + event.getLocation().getAddress() + ">Location</a>", event.getLocation().getShortName());
            }

            TagDAO tdao = new TagDAO();
            if (!tdao.updatingTagsOfEvent(con, event.getId(), event.getTags())) {
                return null;
            }

            con.commit();
            return changes;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Event> select(Connection con, String where, int value, String limit, int offset, String order, String locale) {

        List<Event> events;
        try (PreparedStatement statement = con.prepareStatement(
                "SELECT * FROM events WHERE " + where + " = " + value + "  ORDER BY " + order + " LIMIT " + limit + " OFFSET " + offset);
             PreparedStatement lec = con.prepareStatement(
                     "SELECT id,topic,status,event,speaker FROM lectures WHERE event = ? AND status = 3");
             PreparedStatement selectListeners = con.prepareStatement(
                     "SELECT count(listener) FROM listeners WHERE event = ?"
             )) {
            UserDAO udao = new UserDAO();
            ResultSet set = statement.executeQuery();
            events = new ArrayList<>();
            while (set.next()) {
                int id = set.getInt("id");
                String topic = set.getString("topic");
                List<Tag> tags = new TagDAO().selectForEvents(con, id, locale);
                String fromtime = set.getString("fromtime");
                String totime = set.getString("totime");
                String date = set.getString("date");
                String location = set.getString("location");
                int status = set.getInt("status");
                Event event = new Event(id, topic, tags, fromtime, totime, date, location, status);

                selectListeners.setInt(1, id);
                ResultSet listenersSet = selectListeners.executeQuery();
                listenersSet.next();
                int listeners = listenersSet.getInt(1);
                event.setListeners(listeners);

                List<Lecture> lectures = new ArrayList<>();
                lec.setInt(1, id);
                ResultSet lecturesSet = lec.executeQuery();
                while (lecturesSet.next()) {
                    lectures.add(
                            new Lecture(lecturesSet.getInt(1),
                                    lecturesSet.getString(2),
                                    lecturesSet.getInt(3),
                                    event,
                                    udao.getByID(con, lecturesSet.getInt(5))
                            ));
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

    public Set<User> selectRecipients(Connection c, int event) {
        try (
                PreparedStatement listenersStmt = c.prepareStatement(
                        "SELECT listener FROM listeners WHERE event = ?");
                PreparedStatement speakersStmt = c.prepareStatement(
                        "SELECT speaker FROM lectures WHERE event = ? AND status = 3")
        ) {
            Set<User> recipients = new LinkedHashSet<>();
            UserDAO udao = new UserDAO();

            listenersStmt.setInt(1, event);
            ResultSet listenersSet = listenersStmt.executeQuery();
            while (listenersSet.next()) {
                User user = udao.getByID(c, listenersSet.getInt(1));
                if (user.getNotify()) {
                    recipients.add(user);
                }
            }

            speakersStmt.setInt(1, event);
            ResultSet speakersSet = speakersStmt.executeQuery();
            while (speakersSet.next()) {
                User user = udao.getByID(c, speakersSet.getInt(1));
                if (user.getNotify()) {
                    recipients.add(user);
                }
            }
            return recipients;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
