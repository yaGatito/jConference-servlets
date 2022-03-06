package com.conference.commands;

import com.conference.connection.DBCPool;
import com.conference.dao.LectureDAO;
import com.conference.entity.Lecture;
import com.conference.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

public class AddRequestCommand implements Command {
    public static final Logger logger = LoggerFactory.getLogger(AddRequestCommand.class);
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
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
            logger.warn(e.getMessage(),e);
            request.setAttribute("message", "Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
        Lecture lecture = new Lecture(topic, status, event, speaker);

        if (new LectureDAO().insertLecture(connection,lecture)) {
            if(logger.isInfoEnabled()) {
                logger.info("SUCCESSFUL INSERTING REQUEST-LECTURE - TOPIC:{}, STATUS:{}, EVENT:{}, SPEAKER:{}",topic,status,event,speaker);
            }
            response.sendRedirect("Profile");
        } else {
            if(logger.isInfoEnabled()) {
                logger.info("FAILURE INSERTING REQUEST-LECTURE - TOPIC:{}, STATUS:{}, EVENT:{}, SPEAKER:{}",topic,status,event,speaker);
            }
            request.setAttribute("message", "Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
        pool.putBackConnection(connection);
    }
}
