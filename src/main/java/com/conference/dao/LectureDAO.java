package com.conference.dao;

import com.conference.bean.Lecture;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LectureDAO extends DAO {
    public boolean insertLecture(Lecture lecture) {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "INSERT INTO lectures (id, topic, status, event, speaker) VALUES (DEFAULT,?,?,?,?)")) {
            ps.setString(1, lecture.getTopic());
            ps.setInt(2, lecture.getStatus());
            ps.setInt(3, lecture.getEvent());
            ps.setInt(4, lecture.getSpeaker());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean insertFreeLecture(Lecture lecture) {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "INSERT INTO lectures (id, topic, status, event) VALUES (DEFAULT,?,?,?)")) {
            ps.setString(1, lecture.getTopic());
            ps.setInt(2, lecture.getStatus());
            ps.setInt(3, lecture.getEvent());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public List<Lecture> select(int event, int status) {
        List<Lecture> lectures = new ArrayList<>();
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "SELECT * FROM lectures WHERE (status = ?) AND (event = ?) ORDER BY id")
        ) {
            ps.setInt(1, status);
            ps.setInt(2, event);
            ResultSet set = ps.executeQuery();
            while (set.next()) {
                lectures.add(new Lecture(
                        set.getInt("id"),
                        set.getString("topic"),
                        set.getInt("status"),
                        set.getInt("event"),
                        set.getInt("speaker")
                ));
            }
            set.close();
            return lectures;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Lecture> selectByStatus(int status) {
        List<Lecture> lectures = new ArrayList<>();
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "SELECT * FROM lectures WHERE status = ? ORDER BY id")
        ) {
            ps.setInt(1, status);
            ResultSet set = ps.executeQuery();
            while (set.next()) {
                lectures.add(new Lecture(
                        set.getInt("id"),
                        set.getString("topic"),
                        set.getInt("status"),
                        set.getInt("event"),
                        set.getInt("speaker")
                ));
            }
            set.close();
            return lectures;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Lecture> selectBySpeaker(int status, int speaker) {
        List<Lecture> lectures = new ArrayList<>();
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "SELECT * FROM lectures WHERE (status = ?) AND (speaker = ?) ORDER BY id")
        ) {
            ps.setInt(1, status);
            ps.setInt(2, speaker);
            ResultSet set = ps.executeQuery();
            while (set.next()) {
                lectures.add(new Lecture(
                        set.getInt("id"),
                        set.getString("topic"),
                        set.getInt("status"),
                        set.getInt("event"),
                        set.getInt("speaker")
                ));
            }
            set.close();
            return lectures;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public int selectCount(int event, int status) {
        int count = 0;
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(
                     "SELECT count(*) FROM lectures WHERE (event = ?) AND (status = ?) ")
        ) {
            ps.setInt(1, event);
            ps.setInt(2, status);
            ResultSet set = ps.executeQuery();
            set.next();
            count = set.getInt(1);
            set.close();
            return count;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public static void main(String[] args) {
        List lectures = new LectureDAO().selectBySpeaker(3, 28);
        System.out.println(lectures);
    }
}
