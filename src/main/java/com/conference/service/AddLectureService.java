package com.conference.service;

import com.conference.connection.DBCPool;
import com.conference.dao.EventDAO;
import com.conference.dao.LectureDAO;
import com.conference.dao.UserDAO;
import com.conference.entities.Event;
import com.conference.entities.Lecture;
import com.conference.entities.User;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AddLectureService {
    public static final UserDAO udao = new UserDAO();
    public static final EventDAO edao = new EventDAO();
    public static final LectureDAO ldao = new LectureDAO();

    public static Map<String, Object> pack(String locale) {
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        List<User> speakers = udao.selectSpeakers(connection);
        List<Event> events = edao.select(connection, "status", 1, "all", 0, "date, fromtime", locale);

        Map<String, Object> attributes = new HashMap<>();
        attributes.put("speakers", speakers);
        attributes.put("events", events);
        pool.putBackConnection(connection);
        return attributes;
    }

    public static boolean addLecture(String topic, String event, String speaker, String asOffer) {
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        boolean asOfferBoolean = false;
        int speakerInt;
        int eventInt;
        try {
            eventInt = Integer.parseInt(event);
            speakerInt = Integer.parseInt(speaker);
            asOfferBoolean = asOffer != null;
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }

        int status = 0;
        boolean isFree = true;
        if (speakerInt != 0) {
            if (asOfferBoolean) {
                status = 2;
            } else {
                status = 3;
            }
            isFree = false;
        }
        Event eventEntity = edao.select(connection, "id", eventInt, "1", 0, "date, fromtime", "en").get(0);
        User speakerEntity = udao.getByID(connection, speakerInt);
        Lecture lecture = new Lecture(topic, status, eventEntity, speakerEntity);
        boolean res =
                isFree && ldao.insertFreeLecture(connection, lecture)
                ||
                !isFree && ldao.insertLecture(connection, lecture);
        pool.putBackConnection(connection);
        return res;
    }
}
