package com.conference.servlets;

import com.conference.commands.AddEventCommand;
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

@WebServlet(name = "UpdateEvent", value = "/UpdateEvent")
public class UpdateEvent extends HttpServlet {
    public static final Logger logger = LoggerFactory.getLogger(UpdateEvent.class);
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("update-event.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        TagDAO tdao = new TagDAO();
        List<Tag> allTags = tdao.select(connection);
        List<Tag> tagOfEvent = new ArrayList<>();
        for (Tag tag : allTags) {
            String tagParameter = request.getParameter("tag" + tag.getId());
            if (tagParameter != null){
                tagOfEvent.add(tag);
            }
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String topic = request.getParameter("topic");
        String date = request.getParameter("date");
        String fromtime = request.getParameter("fromtime");
        String totime = request.getParameter("totime");
        String location = request.getParameter("location");
        Event event = new Event(id, topic, tagOfEvent, fromtime, totime, date, location, 1);

        System.out.println(event);
        if (new EventDAO().updateEvent(connection,event)) {
            if (logger.isInfoEnabled()) {
                logger.info("SUCCESSFUL UPDATING LECTURE - TOPIC:{}, DATE:{}, TIME:{}, LOCATION:{}", topic, date, fromtime + "-" + totime, location);
            }
            response.sendRedirect("Profile");
        } else {
            if (logger.isInfoEnabled()) {
                logger.info("FAILURE UPDATING LECTURE - TOPIC:{}, DATE:{}, TIME:{}, LOCATION:{}", topic, date, fromtime + "-" + totime, location);
            }
            request.setAttribute("message", "Oops. Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }
        pool.putBackConnection(connection);
    }
}
