package com.conference.service;

import com.conference.connection.DBCPool;
import com.conference.dao.*;
import com.conference.entities.Event;
import com.conference.entities.Lecture;
import com.conference.entities.Tag;
import com.conference.entities.User;
import com.conference.util.PasswordHash;
import com.conference.util.Validation;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.util.*;

public class ProfileService {
    private static final List<String> buttons = List.of("profile", "participation", "lectures", "users", "ecp");
    private static final double maxItems = 5;
    private static final LectureDAO lecdao = new LectureDAO();
    private static final RequestDAO rdao = new RequestDAO();
    private static final EventDAO edao = new EventDAO();
    private static final ListenersDAO ldao = new ListenersDAO();
    private static final UserDAO udao = new UserDAO();

    /**
     * Authorize user
     * @param login login of user
     * @param password password of user
     * @return null if authorization was failed
     */
    public static User auth(String login, String password){
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        User user = udao.loginUser(connection, login);
        try {
            if (user == null){
                return null;
            }
            PasswordHash.validatePassword(password, user.getPassword());
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            e.printStackTrace();
            return null;
        }
        pool.putBackConnection(connection);
        return user;
    }

    /**
     * Prepare package of resources for speaker
     * @param user Current speaker
     * @return Map of object that are packaged
     */
    public static Map<String, Object> packForSpeaker(Connection connection, User user) {
        List<Lecture> secured = lecdao.selectBySpeaker(connection, 3, user.getId());
        List<Lecture> offers = lecdao.selectBySpeaker(connection, 2, user.getId());
        List<Lecture> requests = lecdao.selectBySpeaker(connection, 1, user.getId());
        List<Lecture> availableFree = lecdao.selectNotRequested(connection, user.getId());
        List<Lecture> notAvailableFree = rdao.selectLecturesFromRequests(connection, user.getId());
        List<Lecture> historyOwn = rdao.historyOfOwnRequests(connection, user.getId());
        List<Lecture> historyFree = rdao.historyOfFreeRequests(connection, user.getId());

        Map<String, Object> request = new HashMap<>();
        request.put("secured", secured);
        request.put("offers", offers);
        request.put("requests", requests);
        request.put("availableFree", availableFree);
        request.put("notAvailableFree", notAvailableFree);
        request.put("historyOwn", historyOwn);
        request.put("historyFree", historyFree);
        return request;
    }


    /**
     * Prepare package of resources for moderator
     * @param page current page of user item
     * @param locales need for preparing goals for translation
     * @return packaged resources
     */
    public static Map<String, Object> packForModer(Connection connection, String page, List<String> locales){
        List<Event> events = edao.select(connection, "status", 1, "all", 0, "date, fromtime", "en");
        List<User> users = users(connection, page);
        double amount = Math.ceil(udao.getCount(connection) / maxItems);
        int offset;
        try {
            offset = Integer.parseInt(page);
            if (offset > amount)
                offset = 1;
        } catch (NumberFormatException | NullPointerException e) {
            offset = 1;
        }
        Map<Lecture, List<User>> lecturesWithApplicants = freeLecturesWithApplicants(connection);
        List<Lecture> requests = lecdao.selectByStatus(connection, 1);
        List<Lecture> rejected = lecdao.selectByStatus(connection, -1);
        List<Lecture> pending = lecdao.selectByStatus(connection, 2);
        int goals = goalsForTranslate(locales);

        Map<String, Object> attributes = new HashMap<>();

        attributes.put("events",events);
        attributes.put("users", users);
        attributes.put("amount", amount);
        attributes.put("offset", offset);
        attributes.put("lecturesWithApplicants",lecturesWithApplicants);
        attributes.put("requests",requests);
        attributes.put("rejected",rejected);
        attributes.put("pending", pending);
        attributes.put("goals", goals);

        return attributes;
    }

    /**
     * Prepare package of resources for any user
     * @param item need for correcting request
     * @param userId need for get events
     * @param lang for example 'en'. Need to choose language
     * @return Map of object that are packaged
     */
    public static Map<String, Object> packByDefault(Connection connection, String item, int userId, String lang){
        Map<String, Object> attributes = new HashMap<>();
        String res = Optional.ofNullable(item).orElse(buttons.get(0));
        boolean flag = false;
        for (String button : buttons) {
            if (res.equals(button)) {
                flag = true;
                break;
            }
        }
        if (!flag) res = "profile";
        attributes.put("item", res);
        attributes.put("participation", ldao.selectEventsOfListeners(connection, userId, lang));
        return attributes;
    }

    private static int goalsForTranslate(List<String> locales){
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        TagDAO tdao = new TagDAO();
        Map<Tag, Map<String, String>> translations = tdao.selectAllTagTranslations(connection);
        Map<Tag, Map<String, String>> shouldBeLocalized = new HashMap<>();

        Map<String, String> map = new LanguageDAO().select(connection);
        Map<String, String> languages = new HashMap<>();
        for (Map.Entry<String, String> entry : map.entrySet()) {
            if (locales.contains(entry.getKey())) {
                languages.put(entry.getKey(), entry.getValue());
            }
        }
        for (Map.Entry<Tag, Map<String, String>> entry : translations.entrySet()) {
            Tag tag = entry.getKey();
            Set<String> tagLocales = entry.getValue().keySet();
            List<String> forLocalization = new ArrayList<>(locales);
            if (!tagLocales.containsAll(locales)) {
                forLocalization.removeAll(tagLocales);
            } else {
                forLocalization = new ArrayList<>();
            }
            if (!forLocalization.isEmpty()) {
                shouldBeLocalized.put(tag, new HashMap<>());
                for (String locale : forLocalization) {
                    shouldBeLocalized.get(tag).put(locale, languages.get(locale));
                }
            }
        }
        pool.putBackConnection(connection);
        int count = 0;
        for (Map.Entry<Tag, Map<String, String>> entry : shouldBeLocalized.entrySet()) {
            for (Map.Entry<String, String> stringEntry : entry.getValue().entrySet()) {
                count++;
            }
        }
        return count;
    }

    private static Map<Lecture, List<User>> freeLecturesWithApplicants(Connection connection) {
        Map<Lecture, List<User>> applicants = new HashMap<>();
        List<Lecture> lectures = lecdao.selectByStatus(connection, 0); //free
        for (Lecture lecture : lectures) {
            applicants.put(lecture, rdao.selectSpeakersFromRequests(connection, lecture.getId()));
        }
        return applicants;
    }

    private static List<User> users(Connection connection, String page){


        double count = udao.getCount(connection);
        double amount = Math.ceil(count / maxItems);
        int offset;
        try {
            offset = Integer.parseInt(page);
            if (offset > amount)
                offset = 1;
        } catch (NumberFormatException | NullPointerException e) {
            offset = 1;
        }

        return udao.selectLimit(connection, (int) maxItems, offset);
    }

}
