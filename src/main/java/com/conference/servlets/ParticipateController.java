package com.conference.servlets;

import com.conference.DBCPool;
import com.conference.entity.User;
import com.conference.dao.ListenersDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "ParticipateController", value = "/ParticipateController")
public class ParticipateController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        try {
            String action = request.getParameter("action");
            int event;
            int listener = ((User) request.getSession().getAttribute("user")).getId();
            boolean res;
            switch (action){
                case "join":
                    event = Integer.parseInt(request.getParameter("event"));
                    res = new ListenersDAO().createListener(connection,event,listener);
                    if (res){
                        response.sendRedirect("Events");
                    }else{
                        request.setAttribute("message","You already participate on event");
                        request.getRequestDispatcher("error-page.jsp").forward(request, response);
                    }
                    break;
                case "unjoin":
                    event = Integer.parseInt(request.getParameter("event"));
                    res = new ListenersDAO().deleteListener(connection,event,listener);
                    pool.putBackConnection(connection);
                    if (res){
                        response.sendRedirect("Profile?item=Your%20participation");
                    }else{
                        request.setAttribute("message","You already undo following for this event");
                        request.getRequestDispatcher("error-page.jsp").forward(request, response);
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
