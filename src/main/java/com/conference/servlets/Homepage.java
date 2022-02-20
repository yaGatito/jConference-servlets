package com.conference.servlets;

import com.conference.entity.Event;
import com.conference.dao.EventDAO;
import com.conference.dao.LectureDAO;
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
        UserDAO udao = new UserDAO();
        EventDAO edao = new EventDAO();
        List<Event> events = edao.select("status", 1,"5", 0, "date, fromtime");
        request.setAttribute("udao",udao);
        request.setAttribute("events",events);
        LectureDAO lecdao = new LectureDAO();
        request.setAttribute("lecdao", lecdao);
        request.getRequestDispatcher("homepage.jsp").forward(request,response);
    }
}
