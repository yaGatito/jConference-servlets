package com.conference.service;

import com.conference.connection.DBCPool;
import com.conference.dao.EventDAO;
import com.conference.dao.UserDAO;
import com.conference.entities.Event;
import com.conference.entities.User;
import com.conference.util.Badges;
import com.conference.util.PasswordHash;
import com.conference.util.Validation;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HomepageService {
    private static final UserDAO udao = new UserDAO();
    private static final EventDAO edao = new EventDAO();

    /**
     * Registers a new user
     * @param user which will be registered
     * @return result of operation
     */
    public static boolean createUser(User user){
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        if (!Validation.validate(Validation.PatternString.EMAIL, user.getEmail())
                || !Validation.validate(Validation.PatternString.NAME, user.getName())
                || !Validation.validate(Validation.PatternString.PASSWORD, user.getPassword())
                || !Validation.validate(Validation.PatternString.NAME, user.getLastname())){
            return false;
        }
        try {
            user.setPassword(PasswordHash.createHash(user.getPassword()));
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            e.printStackTrace();
            return false;
        }
        pool.putBackConnection(connection);
        return udao.insertUser(connection, user);
    }

    /**
     * Prepare package of resources which will be displayed
     * @param lang for example 'en'. Need to choose language
     * @return Map of object that are packaged
     */
    public static Map<String, Object> pack(String lang){
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        List<Event> events = edao.select(connection,"status", 1,"5", 0, "date, fromtime", lang);
        events = Event.filter(events)[1];
        Badges badges = new Badges();
        Map<String, Object> attributes = new HashMap<>();
        attributes.put("badges", badges);
        attributes.put("events", events);
        pool.putBackConnection(connection);
        return attributes;
    }
}
