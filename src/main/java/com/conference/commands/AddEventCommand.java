package com.conference.commands;

import com.conference.DBCPool;
import com.conference.dao.TagDAO;
import com.conference.entity.Event;
import com.conference.dao.EventDAO;
import com.conference.entity.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class AddEventCommand implements Command {
    public static final Logger logger = LoggerFactory.getLogger(AddEventCommand.class);
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        String topic = request.getParameter("topic");
        TagDAO tdao = new TagDAO();
        List<Tag> allTags = tdao.select(connection);
        List<Tag> tagOfEvent = new ArrayList<>();
        for (Tag tag : allTags) {
            String tagParameter = request.getParameter("tag" + tag.getId());
            if (tagParameter != null){
                tagOfEvent.add(tag);
            }
        }
        String date = request.getParameter("date");
        String fromtime = request.getParameter("fromtime");
        String totime = request.getParameter("totime");
        String location = request.getParameter("location");
        Event event = new Event(topic, tagOfEvent, fromtime, totime, date, location, 1);

        if (new EventDAO().createEvent(connection,event)) {
            if (logger.isInfoEnabled()) {
                logger.info("SUCCESSFUL INSERTING LECTURE - TOPIC:{}, DATE:{}, TIME:{}, LOCATION:{}", topic, date, fromtime + "-" + totime, location);
            }
            response.sendRedirect("Profile");
        } else {
            if (logger.isInfoEnabled()) {
                logger.info("FAILURE INSERTING LECTURE - TOPIC:{}, DATE:{}, TIME:{}, LOCATION:{}", topic, date, fromtime + "-" + totime, location);
            }
            request.setAttribute("message", "Oops. Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }
        pool.putBackConnection(connection);

    }
}
