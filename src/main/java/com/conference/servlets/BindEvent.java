package com.conference.servlets;

import com.conference.bean.Event;
import com.conference.bean.User;
import com.conference.dao.EventDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "BindEvent", value = "/BindEvent")
public class BindEvent extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Event event = (Event) request.getSession().getAttribute("event");
        User user = (User) request.getSession().getAttribute("user");
        int speaker = user.getId();
        String date = request.getParameter("date");
        String fromtime = request.getParameter("fromtime");
        String totime = request.getParameter("totime");
        String location = request.getParameter("location");
        event.setSpeaker(speaker);
        event.setLocation(location);
        event.setDate(date);
        event.setFromtime(fromtime);
        event.setTotime(totime);
        event.checkStatus();
        boolean res = new EventDAO().updateEvent(event);
        request.getSession().setAttribute("event",null);
        if (res) {
            response.sendRedirect("profile.jsp");
        }else{
            response.sendRedirect("wrong-pass.jsp");
        }

    }
}
