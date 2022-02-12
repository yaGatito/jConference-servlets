package com.conference.servlets;

import com.conference.bean.Event;
import com.conference.dao.EventDAO;
import com.conference.dao.UserDAO;
import com.conference.util.SELECT;

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
        List<Event> events = new ArrayList<>();
        UserDAO udao = new UserDAO();
        EventDAO edao = new EventDAO();
        try {
            events = edao.select("status", 2,"all",0,"id");
        } catch (IllegalAccessException e) {
            e.printStackTrace();
            request.getRequestDispatcher("Error?message=Wrong_request");
        }
        request.setAttribute("events", events);
        request.setAttribute("udao", udao);
        request.getRequestDispatcher("events.jsp").forward(request,response);
    }
}
