package com.conference.service;

import com.conference.dao.DBCPoolTest;
import com.conference.dao.Tables;
import com.conference.dao.TestDAO;
import com.conference.entities.Event;
import com.conference.entities.Tag;
import junit.framework.TestCase;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class AddEventServiceTest extends TestCase {
    private static final DBCPoolTest pool = DBCPoolTest.getInstance();
    private static final Connection connection = pool.getConnection();

    @Before
    public void clear(){
        TestDAO.deleteAllFrom(Tables.events, connection);
    }

    @Test
    public void testAddInvalidEvents() {
        List<Tag> tags = List.of(new Tag(8,"Java"), new Tag(9,"Programming"));
        List<Event> events = new ArrayList<>();
        for (int i = 0; i < 22; i++){
            Event event = new Event("Java 2022 con"+i, tags, "10:00", "15:00", "2022-05-01","Fasdasd"+i,1);
            events.add(event);
        }

        events.get(0).setDate("22-02-2022");
        events.get(1).setDate("asda");
        events.get(2).setDate("%%a!");
        events.get(3).setDate("%%a!");
        events.get(4).setDate("");
        events.get(5).setDate(null);
        events.get(6).setTotime("12:0!");
        events.get(7).setTotime("as:12");
        events.get(8).setTotime("");
        events.get(9).setTotime(null);
        events.get(10).setFromtime("12:0!");
        events.get(11).setFromtime("as:12");
        events.get(12).setFromtime("");
        events.get(13).setFromtime(null);
        events.get(14).setTopic("as:1");
        events.get(15).setTopic("ASdadsas$$324!sadsadjkhvggggggggggggggggggggggggggxfcrxxxxxxxxxxxxxxxxxc7 fittttttttttttttt              gvvvvvvhkkkk vj ");
        events.get(16).setTopic("A");
        events.get(17).setTopic("");
        events.get(18).setTopic(null);
        events.get(19).setLocation("a");
        events.get(20).setLocation("");
        events.get(21).setLocation(null);

        for (Event event : events) {
            Assert.assertFalse(AddEventService.addEvent(connection, event));
        }
    }
}