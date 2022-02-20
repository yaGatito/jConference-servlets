package com.conference.dao;

import com.conference.entity.Lecture;
import com.conference.entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RequestDAO extends DAO {

    public boolean createRequest(int speaker, int lecture) {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(
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

    public List<User> selectSpeakersFromRequests(int lecture){
        try(Connection c = getConnection();
            PreparedStatement sel = c.prepareStatement(
                    "SELECT speaker FROM requests WHERE lecture = ?");
            PreparedStatement selSp = c.prepareStatement(
                    "SELECT * FROM users WHERE id = ?")){

            sel.setInt(1,lecture);
            ResultSet set = sel.executeQuery();
            List<User> speakers = new ArrayList<>();
            while (set.next()){
                selSp.setInt(1,set.getInt(1));
                ResultSet speakerSet = selSp.executeQuery();

                speakerSet.next();
                int id = speakerSet.getInt("id");
                int role = speakerSet.getInt("role");
                String name = speakerSet.getString("name");
                String lastname = speakerSet.getString("lastname");
                String email = speakerSet.getString("email");
                String password = speakerSet.getString("password");
                User user = new User(id,role,name,lastname,email,password);
                speakers.add(user);
                speakerSet.close();
            }

            set.close();
            return speakers;
        }catch (SQLException e){
            e.printStackTrace();
            return null;
        }
    }

    public List<Lecture> selectLecturesFromRequests(int speaker){
        try(Connection c = getConnection();
            PreparedStatement sel = c.prepareStatement(
                    "SELECT lecture FROM requests WHERE speaker = ?");
            PreparedStatement selSp = c.prepareStatement(
                    "SELECT * FROM lectures WHERE id = ?")){

            sel.setInt(1,speaker);
            ResultSet set = sel.executeQuery();
            List<Lecture> lectures = new ArrayList<>();
            while (set.next()){
                selSp.setInt(1,set.getInt(1));
                ResultSet speakerSet = selSp.executeQuery();

                speakerSet.next();
                int id = speakerSet.getInt("id");
                int status = speakerSet.getInt("status");
                String topic = speakerSet.getString("topic");
                int event = speakerSet.getInt("event");
                Lecture lecture = new Lecture(id,topic,status,event,speaker);
                lectures.add(lecture);
                speakerSet.close();
            }

            set.close();
            return lectures;
        }catch (SQLException e){
            e.printStackTrace();
            return null;
        }
    }

    public boolean secureLecture(int speaker, int lecture) {
        try (Connection c = getConnection();
             PreparedStatement delR = c.prepareStatement(
                     "DELETE FROM requests WHERE lecture = ?");
             PreparedStatement upd = c.prepareStatement(
                     "UPDATE lectures SET status = 3, speaker = ? WHERE id = ?")) {

            c.setAutoCommit(false);

            delR.setInt(1, lecture);
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
}
