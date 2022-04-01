package com.conference.service;

import com.conference.connection.DBCPool;
import com.conference.dao.EventDAO;
import com.conference.dao.TagDAO;
import com.conference.entity.Event;
import com.conference.entity.Tag;
import com.conference.entity.User;
import com.conference.util.MailSender;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class UpdateEventService {
    private static final EventDAO edao = new EventDAO();

    public static Map<String, Object> pack(String locale, String id){
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        List<Tag> tags = new TagDAO().selectForLocale(connection, locale);
        int eventId;
        try {
            eventId = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return null;
        }
        Event event = edao.select(connection, "id", eventId, "1", 0, "id", locale).get(0);

        Map<String, Object> attributes = new HashMap<>();
        attributes.put("event", event);
        attributes.put("tags", tags);
        pool.putBackConnection(connection);
        return attributes;
    }

    public static Map<String, String> updateEvent(Connection connection, Event event){
        Map<String, String> changes = edao.updateEvent(connection, event);
        Set<User> recipients = edao.selectRecipients(connection, event.getId());
        MailSender.getInstance().sendChangesMessages(changes, recipients, event);
        return changes;
    }
}
