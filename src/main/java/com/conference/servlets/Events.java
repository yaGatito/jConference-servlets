package com.conference.servlets;

import com.conference.entities.User;
import com.conference.service.EventsService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "Events", value = "/Events")
public class Events extends HttpServlet {
    private static final int PAGE_LIMIT = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sort = request.getParameter("sort");
        String descending = request.getParameter("descending");
        String past = request.getParameter("past");
        String future = request.getParameter("future");
        String lang = (String) request.getSession().getAttribute("lang");

        Map<String, Object> attributes = EventsService.pack((User) request.getSession().getAttribute("user"),lang,sort,descending,past,future,PAGE_LIMIT);
        attributes.forEach(request::setAttribute);

        request.getRequestDispatcher("events.jsp").forward(request, response);
    }
}
