package com.conference.service;

import com.conference.connection.DBCPool;
import com.conference.dao.EventDAO;
import com.conference.dao.TagDAO;
import com.conference.entities.Event;
import com.conference.entities.Tag;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AddEventService {
    private static final TagDAO tdao = new TagDAO();
    private static final EventDAO edao = new EventDAO();

    public static Map<String, Object> pack(String locale){
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        Map<String, Object> attributes = new HashMap<>();
        List<Tag> tags = tdao.selectForLocale(connection, locale);
        attributes.put("tags", tags);
        pool.putBackConnection(connection);
        return attributes;
    }

    public static List<Tag> allTags(){
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        List<Tag> allTags = tdao.select(connection);
        return allTags;
    }

    public static boolean addEvent(Event event){
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        boolean res = edao.createEvent(connection,event);
        pool.putBackConnection(connection);
        return res;
    }
}
