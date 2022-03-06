package com.conference.commands;

import com.conference.connection.DBCPool;
import com.conference.entity.Lecture;
import com.conference.dao.LectureDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.Connection;

public class AddLectureCommand implements Command {
    public static final Logger logger = LoggerFactory.getLogger(AddLectureCommand.class);
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
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
            logger.warn(e.getMessage(),e);
            request.setAttribute("message", "Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
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
        Lecture lecture = new Lecture(topic, status, event, speaker);

        if (isFree && new LectureDAO().insertFreeLecture(connection,lecture) ||
                !isFree && new LectureDAO().insertLecture(connection,lecture)) {
            if(logger.isInfoEnabled()) {
                logger.info("SUCCESSFUL INSERTING LECTURE - TOPIC:{}, STATUS:{}, EVENT:{}, SPEAKER:{}",topic,status,event,speaker);
            }
            response.sendRedirect("Profile");
        } else {
            if(logger.isInfoEnabled()) {
                logger.info("FAILURE INSERTING LECTURE - TOPIC:{}, STATUS:{}, EVENT:{}, SPEAKER:{}",topic,status,event,speaker);
            }
            request.setAttribute("message", "Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
        pool.putBackConnection(connection);
    }
}
