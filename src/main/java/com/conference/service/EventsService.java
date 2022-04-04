package com.conference.service;

import com.conference.connection.DBCPool;
import com.conference.dao.EventDAO;
import com.conference.entities.Event;
import com.conference.util.Badges;
import java.sql.Connection;
import java.util.*;

public class EventsService {
    private static final EventDAO edao = new EventDAO();

    public static Map<String, Object> pack(String lang, String sort, String descendingStr, String pastStr, String futureStr, int PAGE_LIMIT){
        Map<String, Object> attributes = new HashMap<>();
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();

        Map<String, Comparator<Event>> comparators = Event.getComparators();
        if (!comparators.containsKey(sort)) {
            sort = "default";
        }
        boolean descending = Boolean.parseBoolean(descendingStr);
        boolean past = Boolean.parseBoolean(pastStr);
        boolean future = Boolean.parseBoolean(futureStr);


        List<Event> events = edao.select(connection, "status", 1, "all", 0, "id", lang);
        pool.putBackConnection(connection);
        events = Event.notEmpty(events);
        events.sort(comparators.get(sort));
        if (!comparators.containsKey(sort)) {
            sort = "default";
        }
        if (descending) {
            events.sort(comparators.get(sort).reversed());
        } else {
            events.sort(comparators.get(sort));
        }
        List<Event>[] lists = Event.filter(events);
        if (past && future) {
        } else if (past) {
            events = lists[0];
        } else if (future) {
            events = lists[1];
        }
        List<List<Event>> pages = new ArrayList<>();
        List<Event> temp = new ArrayList<>();
        for (int i = 0; i < events.size(); i++) {
            if (temp.size() >= PAGE_LIMIT) {
                pages.add(temp);
                temp = new ArrayList<>();
            }
            temp.add(events.get(i));
            if (i == (events.size() - 1)) {
                pages.add(temp);
            }
        }
        Badges badges = new Badges();

        attributes.put("badges", badges);
        attributes.put("pages", pages);
        return attributes;
    }
}
