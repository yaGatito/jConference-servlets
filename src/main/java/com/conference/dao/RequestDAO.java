package com.conference.dao;

import com.conference.entity.Event;
import com.conference.entity.Lecture;
import com.conference.entity.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RequestDAO  {
    private static final UserDAO udao = new UserDAO();
    private static final EventDAO edao = new EventDAO();

    public boolean createRequest(Connection c, int speaker, int lecture) {
        try (PreparedStatement ps = c.prepareStatement(
                     "INSERT INTO requests (speaker, lecture) VALUES (?,?)")) {
            ps.setInt(1, speaker);
            ps.setInt(2, lecture);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> selectSpeakersFromRequests(Connection c, int lecture) {
        try (PreparedStatement sel = c.prepareStatement(
                     "SELECT speaker FROM requests WHERE lecture = ?");
             PreparedStatement selSp = c.prepareStatement(
                     "SELECT role, name, lastname, email, password, notify FROM users WHERE id = ?")) {

            sel.setInt(1, lecture);
            ResultSet set = sel.executeQuery();
            List<User> speakers = new ArrayList<>();
            while (set.next()) {
                int id = set.getInt(1);

                selSp.setInt(1, id);
                ResultSet speakerSet = selSp.executeQuery();
                speakerSet.next();

                int role = speakerSet.getInt(1);
                String name = speakerSet.getString(2);
                String lastname = speakerSet.getString(3);
                String email = speakerSet.getString(4);
                String password = speakerSet.getString(5);
                boolean notify = speakerSet.getBoolean(6);
                User user = new User(id, role, name, lastname, email, password, notify);
                speakers.add(user);
                speakerSet.close();
            }

            set.close();
            return speakers;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Lecture> selectLecturesFromRequests(Connection c, int speaker) {
        try (PreparedStatement sel = c.prepareStatement(
                     "SELECT lecture FROM requests WHERE speaker = ? AND status = 1");
             PreparedStatement selSp = c.prepareStatement(
                     "SELECT * FROM lectures WHERE id = ?")) {

            sel.setInt(1, speaker);
            ResultSet set = sel.executeQuery();
            List<Lecture> lectures = new ArrayList<>();
            while (set.next()) {
                selSp.setInt(1, set.getInt(1));
                ResultSet speakerSet = selSp.executeQuery();

                speakerSet.next();
                int id = speakerSet.getInt("id");
                int status = speakerSet.getInt("status");
                String topic = speakerSet.getString("topic");
                Event event = edao.select(c, "id", speakerSet.getInt("event"), "1", 0, "date, fromtime", "en").get(0);
                Lecture lecture = new Lecture(id, topic, status, event, udao.getByID(c,set.getInt(speaker)));
                lectures.add(lecture);
                speakerSet.close();
            }

            set.close();
            return lectures;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean secureLecture(Connection c, int speaker, int lecture) {
        try (PreparedStatement delR = c.prepareStatement(
                     "UPDATE requests SET status = -1 WHERE lecture = ? AND speaker != ?"); // was "DELETE FROM requests WHERE lecture = ?"
             PreparedStatement upd = c.prepareStatement(
                     "UPDATE lectures SET status = 3, speaker = ? WHERE id = ?")) {

            c.setAutoCommit(false);

            delR.setInt(1, lecture);
            delR.setInt(2, speaker);
            upd.setInt(1, speaker);
            upd.setInt(2, lecture);
            delR.executeUpdate();
            upd.executeUpdate();
            c.commit();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Lecture> historyOfOwnRequests(Connection c, int speaker) {
        try (PreparedStatement own = c.prepareStatement(
                     "SELECT id, topic, status, event FROM lectures WHERE status = -1 AND speaker = ?")){
            List<Lecture> ownRequests = new ArrayList<>();
            own.setInt(1, speaker);
            ResultSet set = own.executeQuery();
            while (set.next()) {
                int id = set.getInt(1);
                String topic = set.getString(2);
                int status = set.getInt(3);
                Event event = edao.select(c, "id", set.getInt(4), "1", 0, "date, fromtime", "en").get(0);
                ownRequests.add(new Lecture(id, topic, status, event, udao.getByID(c,speaker)));
            }
            set.close();
            return ownRequests;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Lecture> historyOfFreeRequests(Connection c, int speaker) {
        try (PreparedStatement ids = c.prepareStatement(
                     "SELECT lecture FROM requests WHERE status = -1 AND speaker = ?");
             PreparedStatement free = c.prepareStatement(
                     "SELECT id, topic, status, event, speaker FROM lectures WHERE id = ?")
        ) {
            List<Lecture> requests = new ArrayList<>();
            ids.setInt(1,speaker);
            ResultSet set = ids.executeQuery();
            while (set.next()){
                free.setInt(1,set.getInt(1));
                ResultSet set1 = free.executeQuery();
                set1.next();
                requests.add(new Lecture(set1.getInt(1),
                        set1.getString(2),
                        set1.getInt(3),
                        edao.select(c, "id", set.getInt(4), "1", 0, "date, fromtime", "en").get(0),
                        udao.getByID(c,set1.getInt(5))
                ));
                set1.close();
            }
            set.close();
            return requests;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }


}
