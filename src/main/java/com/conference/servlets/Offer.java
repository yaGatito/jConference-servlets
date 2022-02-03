package com.conference.servlets;

import com.conference.bean.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Offer", value = "/Offer")
public class Offer extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int event_id = Integer.parseInt(request.getParameter("event-id"));
        request.setAttribute("event-id",event_id);
        request.getRequestDispatcher("offer.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
