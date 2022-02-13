package com.conference.dao;

import com.conference.bean.Lecture;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class LectureDAO extends DAO{
    private static final String INSERT_LECTURE = "INSERT INTO lectures (id, topic, status, event, speaker) VALUES (DEFAULT,?,?,?,?)";
    public boolean insertLecture(Lecture lecture){
        try (Connection c = getConnection(); PreparedStatement ps = c.prepareStatement(INSERT_LECTURE)) {
            ps.setString(1,lecture.getTopic());
            ps.setInt(2,lecture.getStatus());
            ps.setInt(3,lecture.getEvent());
            ps.setInt(4,lecture.getSpeaker());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
