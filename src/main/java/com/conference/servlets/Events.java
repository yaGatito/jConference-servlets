package com.conference.servlets;

import com.conference.entity.Event;
import com.conference.dao.EventDAO;
import com.conference.dao.LectureDAO;
import com.conference.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.time.temporal.TemporalField;
import java.time.temporal.TemporalQueries;
import java.util.*;

@WebServlet(name = "Events", value = "/Events")
public class Events extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Comparator<Event>> comparators = Event.getComparators();
        String sort = request.getParameter("sort");
        if (!comparators.containsKey(sort)) {
            sort = "default";
        }
        boolean ascending = Boolean.parseBoolean(request.getParameter("ascending"));
        boolean past = Boolean.parseBoolean(request.getParameter("past"));
        boolean future = Boolean.parseBoolean(request.getParameter("future"));


        UserDAO udao = new UserDAO();
        LectureDAO lecdao = new LectureDAO();
        EventDAO edao = new EventDAO();
        List<Event> events = edao.select("status", 1, "all", 0, "id");
        events.sort(comparators.get(sort));
        if (!comparators.containsKey(sort)) {
            sort = "default";
        }
        if (ascending){
            events.sort(comparators.get(sort).reversed());
        }else{
            events.sort(comparators.get(sort));
        }
        List<Event>[] lists = Event.filter(events);
        if (past && future){

        }else if (past){
            events = lists[0];
        }else if (future){
            events = lists[1];
        }

        request.setAttribute("udao", udao);
        request.setAttribute("lecdao", lecdao);
        request.setAttribute("events", events);
        request.getRequestDispatcher("events.jsp").forward(request, response);
    }
}
