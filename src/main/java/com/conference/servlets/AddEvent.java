package com.conference.servlets;

import com.conference.connection.DBCPool;
import com.conference.entities.Event;
import com.conference.entities.Tag;
import com.conference.service.AddEventService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AddEvent", value = "/AddEvent")
public class AddEvent extends HttpServlet {
    public static final Logger logger = LoggerFactory.getLogger(AddEvent.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String locale = (String) request.getSession().getAttribute("lang");
        Map<String, Object> attributes = AddEventService.pack(locale);
        attributes.forEach(request::setAttribute);
        request.getRequestDispatcher("add-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        List<Tag> allTags = AddEventService.allTags();
        List<Tag> tagsOfEvent = new ArrayList<>();
        for (Tag tag : allTags) {
            String tagParameter = request.getParameter("tag" + tag.getId());
            if (tagParameter != null){
                tagsOfEvent.add(tag);
            }
        }
        String topic = request.getParameter("topic");
        String date = request.getParameter("date");
        String fromtime = request.getParameter("fromtime");
        String totime = request.getParameter("totime");
        String location = request.getParameter("location");
        Event event = new Event(topic, tagsOfEvent, fromtime, totime, date, location, 1);
        boolean res = AddEventService.addEvent(connection, event);
        if (res) {
            if (logger.isInfoEnabled()) {
                logger.info("SUCCESSFUL INSERTING LECTURE - TOPIC:{}, DATE:{}, TIME:{}, LOCATION:{}", topic, date, fromtime + "-" + totime, location);
            }
            response.sendRedirect("Profile");
        } else {
            if (logger.isInfoEnabled()) {
                logger.info("FAILURE INSERTING LECTURE - TOPIC:{}, DATE:{}, TIME:{}, LOCATION:{}", topic, date, fromtime + "-" + totime, location);
            }
            response.sendRedirect("Error");
        }
    }
}
