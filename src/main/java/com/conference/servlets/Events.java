package com.conference.servlets;

import com.conference.bean.Event;
import com.conference.dao.EventDAO;
import com.conference.dao.LectureDAO;
import com.conference.dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "Events", value = "/Events")
public class Events extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO udao = new UserDAO();
        LectureDAO lecdao = new LectureDAO();
        EventDAO edao = new EventDAO();
        List<Event> events = edao.select("status", 1,"all",0,"id");
        request.setAttribute("udao", udao);
        request.setAttribute("lecdao", lecdao);
        request.setAttribute("events", events);
        request.getRequestDispatcher("events.jsp").forward(request,response);
    }
}
