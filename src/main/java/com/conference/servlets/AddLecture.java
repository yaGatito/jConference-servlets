package com.conference.servlets;

import com.conference.service.AddLectureService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "AddLecture", value = "/AddLecture")
public class AddLecture extends HttpServlet {
    public static final Logger logger = LoggerFactory.getLogger(AddLecture.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String locale = (String) request.getSession().getAttribute("lang");
        Map<String, Object> attributes = AddLectureService.pack(locale);
        attributes.forEach(request::setAttribute);
        request.getRequestDispatcher("add-lecture.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String topic = request.getParameter("topic");
        String event = request.getParameter("event");
        String speaker = request.getParameter("speaker");
        String asOffer = request.getParameter("offer");
        boolean res = AddLectureService.addLecture(topic, event, speaker, asOffer);
        if (res) {
            if (logger.isInfoEnabled()) {
                logger.info("SUCCESSFUL INSERTING LECTURE - TOPIC:{}, EVENT:{}, SPEAKER:{}", topic, event, speaker);
            }
            response.sendRedirect("Profile");
        } else {
            if (logger.isInfoEnabled()) {
                logger.info("FAILURE INSERTING LECTURE - TOPIC:{}, EVENT:{}, SPEAKER:{}", topic, event, speaker);
            }
            response.sendRedirect("Error");
        }
    }
}
