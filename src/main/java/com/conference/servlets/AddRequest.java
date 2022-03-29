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

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet(name = "AddRequest", value = "/AddRequest")
public class AddRequest extends HttpServlet {
    public static final Logger logger = LoggerFactory.getLogger(AddRequest.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        String lang = (String) request.getSession().getAttribute("lang");
        List<User> speakers = new UserDAO().selectSpeakers(connection);
        List<Event> events = new EventDAO().select(connection, "status", 1, "all", 0, "date, fromtime", lang);
        pool.putBackConnection(connection);
        request.setAttribute("speakers", speakers);
        request.setAttribute("events", events);
        request.getRequestDispatcher("add-request.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        UserDAO udao = new UserDAO();
        Connection connection = pool.getConnection();
        String topic = "";
        int event = 0;
        int speaker = 0;
        int status = 1;
        try {
            topic = request.getParameter("topic");
            event = Integer.parseInt(request.getParameter("event"));
            speaker = ((User) request.getSession().getAttribute("user")).getId();
        } catch (NumberFormatException e) {
            logger.warn(e.getMessage(), e);
            response.sendRedirect("Error");
        }
        Lecture lecture = new Lecture(topic, status, event, udao.getByID(connection,speaker));

        if (new LectureDAO().insertLecture(connection, lecture)) {
            if (logger.isInfoEnabled()) {
                logger.info("SUCCESSFUL INSERTING REQUEST-LECTURE - TOPIC:{}, STATUS:{}, EVENT:{}, SPEAKER:{}", topic, status, event, speaker);
            }
            response.sendRedirect("Profile");
        } else {
            if (logger.isInfoEnabled()) {
                logger.info("FAILURE INSERTING REQUEST-LECTURE - TOPIC:{}, STATUS:{}, EVENT:{}, SPEAKER:{}", topic, status, event, speaker);
            }
            response.sendRedirect("Error");
        }
        pool.putBackConnection(connection);
    }
}
