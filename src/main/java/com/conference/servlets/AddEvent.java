package com.conference.servlets;

import com.conference.connection.DBCPool;
import com.conference.dao.EventDAO;
import com.conference.dao.TagDAO;
import com.conference.entity.Event;
import com.conference.entity.Tag;
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

@WebServlet(name = "AddEvent", value = "/AddEvent")
public class AddEvent extends HttpServlet {
    public static final Logger logger = LoggerFactory.getLogger(AddEvent.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        String locale = (String) request.getSession().getAttribute("lang");
        List<Tag> tags = new TagDAO().selectForLocale(connection, locale);
        pool.putBackConnection(connection);
        request.setAttribute("tags",tags);
        request.getRequestDispatcher("add-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        String topic = request.getParameter("topic");
        TagDAO tdao = new TagDAO();
        List<Tag> allTags = tdao.select(connection);
        List<Tag> tagsOfEvent = new ArrayList<>();
        for (Tag tag : allTags) {
            String tagParameter = request.getParameter("tag" + tag.getId());
            if (tagParameter != null){
                tagsOfEvent.add(tag);
            }
        }
        String date = request.getParameter("date");
        String fromtime = request.getParameter("fromtime");
        String totime = request.getParameter("totime");
        String location = request.getParameter("location");
        Event event = new Event(topic, tagsOfEvent, fromtime, totime, date, location, 1);

        if (new EventDAO().createEvent(connection,event)) {
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
        pool.putBackConnection(connection);
    }
}
