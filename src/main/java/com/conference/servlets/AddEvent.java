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
        String date = request.getParameter("date");
        String fromtime = request.getParameter("fromtime");
        String totime = request.getParameter("totime");
        String location = request.getParameter("location");
        Event event = new Event(topic,description,fromtime,totime,date,location,1);
        if(new EventDAO().createEvent(event)) {
            response.sendRedirect("profile.jsp");
        }else {
            response.sendRedirect("Error?message=Wrong_input");
        }
    }
}
