package com.conference.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TestDAO {
    public static boolean deleteAllFrom(Tables tables, Connection connection){
        try(PreparedStatement ps = connection.prepareStatement(
                "DELETE FROM " + tables)) {
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
