package com.conference.servlets;

import com.conference.connection.DBCPool;
import com.conference.dao.EventDAO;
import com.conference.dao.LectureDAO;
import com.conference.dao.UserDAO;
import com.conference.entity.Event;
import com.conference.entity.Lecture;
import com.conference.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet(name = "AddLecture", value = "/AddLecture")
public class AddLecture extends HttpServlet {
    public static final Logger logger = LoggerFactory.getLogger(AddLecture.class);
    private static final EventDAO edao = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        String locale = (String) request.getSession().getAttribute("lang");
        List<User> speakers = new UserDAO().selectSpeakers(connection);
        List<Event> events = new EventDAO().select(connection, "status", 1, "all", 0, "date, fromtime", locale);
        pool.putBackConnection(connection);
        request.setAttribute("speakers", speakers);
        request.setAttribute("events", events);
        request.getRequestDispatcher("add-lecture.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        UserDAO udao = new UserDAO();
        Connection connection = pool.getConnection();
        String topic = "";
        boolean asOffer = false;
        int event = 0;
        int speaker = 0;
        try {
            topic = request.getParameter("topic");
            event = Integer.parseInt(request.getParameter("event"));
            speaker = Integer.parseInt(request.getParameter("speaker"));
            asOffer = request.getParameter("offer") != null;
        } catch (NumberFormatException e) {
            logger.warn(e.getMessage(), e);
            response.sendRedirect("Error");
        }

        int status = 0;
        boolean isFree = true;
        if (speaker != 0) {
            if (asOffer) {
                status = 2;
            } else {
                status = 3;
            }
            isFree = false;
        }
        Lecture lecture = new Lecture(topic, status,
                edao.select(connection, "id", event, "1", 0, "date, fromtime", "en").get(0),
                udao.getByID(connection, speaker));

        if (isFree && new LectureDAO().insertFreeLecture(connection, lecture) ||
                !isFree && new LectureDAO().insertLecture(connection, lecture)) {
            if (logger.isInfoEnabled()) {
                logger.info("SUCCESSFUL INSERTING LECTURE - TOPIC:{}, STATUS:{}, EVENT:{}, SPEAKER:{}", topic, status, event, speaker);
            }
            response.sendRedirect("Profile");
        } else {
            if (logger.isInfoEnabled()) {
                logger.info("FAILURE INSERTING LECTURE - TOPIC:{}, STATUS:{}, EVENT:{}, SPEAKER:{}", topic, status, event, speaker);
            }
            response.sendRedirect("Error");
        }
        pool.putBackConnection(connection);
    }
}
