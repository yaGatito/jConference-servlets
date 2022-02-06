package com.conference.servlets;

import com.conference.bean.User;
import com.conference.dao.ListenersDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ParticipateController", value = "/ParticipateController")
public class ParticipateController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            int event;
            int listener = ((User) request.getSession().getAttribute("user")).getId();
            boolean res;
            switch (action){
                case "join":
                    event = Integer.parseInt(request.getParameter("event"));
                    res = new ListenersDAO().createListener(event,listener);
                    if (res){
                        response.sendRedirect("events.jsp");
                    }else{
                        request.getRequestDispatcher("Error?message=You_already_taking_part_in_this_event").forward(request, response);
                    }
                    break;
                case "unjoin":
                    event = Integer.parseInt(request.getParameter("event"));
                    res = new ListenersDAO().deleteListener(event,listener);
                    if (res){
                        response.sendRedirect("Profile?item=Your%20participation");
                    }else{
                        request.getRequestDispatcher("Error?message=You_already_undo_following_for_this_event").forward(request, response);
                    }
                    break;
                default:
                    throw new NumberFormatException("DEFAULT SECTION");
            }

        }catch (NullPointerException | NumberFormatException exception){
            request.getRequestDispatcher("Error?message=Something_goes_wrong").forward(request, response);
        }

    }
}
