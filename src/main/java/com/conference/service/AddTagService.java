package com.conference.service;

import com.conference.connection.DBCPool;
import com.conference.dao.LanguageDAO;
import com.conference.dao.TagDAO;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AddTagService {
    public static final LanguageDAO langdao = new LanguageDAO();
    public static final TagDAO tdao = new TagDAO();

    public static Map<String, Object> pack(List<String> locales) {
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        Map<String, String> map = langdao.select(connection);
        Map<String, String> languages = new HashMap<>();
        for (Map.Entry<String, String> entry : map.entrySet()) {
            if (locales.contains(entry.getKey())) {
                languages.put(entry.getKey(), entry.getValue());
            }
        }
        Map<String, Object> attributes = new HashMap<>();
        attributes.put("languages", languages);
        pool.putBackConnection(connection);
        return attributes;
    }

    public static boolean addTag(Connection connection, Map<String, String> tags){
        return tdao.createTag(connection, tags);
    }
}
