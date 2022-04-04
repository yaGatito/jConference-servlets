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

public class AddRequestService {
    public static final UserDAO udao = new UserDAO();
    public static final EventDAO edao = new EventDAO();
    public static final LectureDAO ldao = new LectureDAO();

    public static Map<String, Object> pack(String lang) {
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        List<User> speakers = new UserDAO().selectSpeakers(connection);
        List<Event> events = new EventDAO().select(connection, "status", 1, "all", 0, "date, fromtime", lang);

        Map<String, Object> attributes = new HashMap<>();
        attributes.put("speakers", speakers);
        attributes.put("events", events);
        pool.putBackConnection(connection);
        return attributes;
    }

    public static boolean addRequest(String topic, String event, User speaker){
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        int eventId = 0;
        int status = 1;
        try {
            eventId = Integer.parseInt(event);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
        Event eventEntity = edao.select(connection, "id", eventId, "1", 0, "date, fromtime", "en").get(0);
        User speakerEntity = udao.getByID(connection, speaker.getId());
        Lecture lecture = new Lecture(topic, status, eventEntity, speakerEntity);
        boolean res = ldao.insertLecture(connection, lecture);

        pool.putBackConnection(connection);
        return res;
    }
}
