package com.conference.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class LanguageDAO {
    public Map<String,String> select(Connection c){
        Map<String, String> map = new HashMap<>();
        try (PreparedStatement ps = c.prepareStatement(
                "SELECT short_name, full_name FROM languages"
        )) {
            ResultSet set = ps.executeQuery();
            while (set.next()){
                map.put(set.getString(1),set.getString(2));
            }
            set.close();
            return map;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
