package com.conference.servlets;

import com.conference.bean.Event;
import com.conference.bean.User;
import com.conference.dao.EventDAO;
import com.conference.util.SELECT;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "EventController", value = "/EventController")
public class EventController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User)request.getSession().getAttribute("user");
        if (user != null){
            EventDAO edao = new EventDAO();
            String action = request.getParameter("action");
            Event e = null;
            int event = Integer.parseInt(request.getParameter("event"));
            e = edao.select("id", event, "all", 0, "id").get(0);
            switch (action){
                case "update":
                    e.setDate(request.getParameter("date"));
                    e.setFromtime(request.getParameter("fromtime"));
                    e.setTotime(request.getParameter("totime"));
                    e.setLocation(request.getParameter("location"));
//                    e.checkStatus();
                    edao.updateEvent(e);
                    response.sendRedirect("Profile?item=Your%20events");
                    break;
                case "bind":
//                    e.setSpeaker(user.getId());
//                    e.checkStatus();
                    edao.updateEvent(e);
                    response.sendRedirect("Profile?item=Your%20events");
                    break;
                default:
                    response.sendRedirect("Error?message=Wrong_address");
                    break;
            }
        }else{
            response.sendRedirect("Error?message=Login_please");
        }
    }
}
