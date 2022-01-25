package com.conference.servlets;

import com.conference.bean.Event;
import com.conference.dao.EventDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/AddEvent")
public class AddEvent extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String topic = request.getParameter("topic");
        String description = request.getParameter("description");
        int speaker = Integer.parseInt(request.getParameter("speaker"));
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String location = request.getParameter("location");
        String condition = request.getParameter("condition");
        boolean isOnline = condition.equals("online");
        Event event = new Event(topic,description,speaker,time,date,isOnline,location);
        new EventDAO().createEvent(event);
        response.sendRedirect("profile.jsp");
    }
}
