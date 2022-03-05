package com.conference.servlets;

import com.conference.DBCPool;
import com.conference.entity.Event;
import com.conference.dao.EventDAO;
import com.conference.dao.LectureDAO;
import com.conference.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet(name = "Events", value = "/Events")
public class Events extends HttpServlet {
    private static final int PAGE_LIMIT = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();

        Map<String, Comparator<Event>> comparators = Event.getComparators();
        String sort = request.getParameter("sort");
        if (!comparators.containsKey(sort)) {
            sort = "default";
        }
        boolean descending = Boolean.parseBoolean(request.getParameter("descending"));
        boolean past = Boolean.parseBoolean(request.getParameter("past"));
        boolean future = Boolean.parseBoolean(request.getParameter("future"));

        UserDAO udao = new UserDAO();
        LectureDAO lecdao = new LectureDAO();
        EventDAO edao = new EventDAO();
        String lang = (String) request.getSession().getAttribute("lang");
        List<Event> events = edao.select(connection,"status", 1, "all", 0, "id",lang);
        pool.putBackConnection(connection);
        events.sort(comparators.get(sort));
        if (!comparators.containsKey(sort)) {
            sort = "default";
        }
        if (descending) {
            events.sort(comparators.get(sort).reversed());
        } else {
            events.sort(comparators.get(sort));
        }
        List<Event>[] lists = Event.filter(events);
        if (past && future) {
        } else if (past) {
            events = lists[0];
        } else if (future) {
            events = lists[1];
        }
        List<List<Event>> pages = new ArrayList<>();
        List<Event> temp = new ArrayList<>();
        for (int i = 0; i < events.size(); i++) {
            if (temp.size() >= PAGE_LIMIT) {
                pages.add(temp);
                temp = new ArrayList<>();
            }
            temp.add(events.get(i));
            if (i == (events.size() - 1)) {
                pages.add(temp);
            }
        }
        request.setAttribute("udao", udao);
        request.setAttribute("lecdao", lecdao);
        request.setAttribute("pages", pages);
        request.getRequestDispatcher("events.jsp").forward(request, response);
    }
}
