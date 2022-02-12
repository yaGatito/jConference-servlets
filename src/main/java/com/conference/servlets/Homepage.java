package com.conference.servlets;

import com.conference.bean.Event;
import com.conference.dao.EventDAO;
import com.conference.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Homepage", value = "/Homepage")
public class Homepage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Event> events = null;
        UserDAO udao = new UserDAO();
        EventDAO edao = new EventDAO();
        try {
            events = edao.select("status", 2,"5", 0, "date, fromtime");
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        request.setAttribute("udao",udao);
        request.setAttribute("events",events);
        request.getRequestDispatcher("homepage.jsp").forward(request,response);
    }
}
