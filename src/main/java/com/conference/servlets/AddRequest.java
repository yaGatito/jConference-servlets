package com.conference.servlets;

import com.conference.entity.User;
import com.conference.service.AddRequestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "AddRequest", value = "/AddRequest")
public class AddRequest extends HttpServlet {
    public static final Logger logger = LoggerFactory.getLogger(AddRequest.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lang = (String) request.getSession().getAttribute("lang");
        Map<String, Object> attributes = AddRequestService.pack(lang);
        attributes.forEach(request::setAttribute);
        request.getRequestDispatcher("add-request.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String topic = request.getParameter("topic");
        String event = request.getParameter("event");
        User speaker = (User) request.getSession().getAttribute("user");
        boolean res = AddRequestService.addRequest(topic, event, speaker);
        if (res) {
            if (logger.isInfoEnabled()) {
                logger.info("SUCCESSFUL INSERTING REQUEST-LECTURE - TOPIC:{}, EVENT:{}, SPEAKER:{}", topic, event, speaker);
            }
            response.sendRedirect("Profile");
        } else {
            if (logger.isInfoEnabled()) {
                logger.info("FAILURE INSERTING REQUEST-LECTURE - TOPIC:{}, EVENT:{}, SPEAKER:{}", topic, event, speaker);
            }
            response.sendRedirect("Error");
        }
    }
}
