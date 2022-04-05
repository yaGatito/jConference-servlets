package com.conference.servlets;

import com.conference.entities.User;
import com.conference.service.ProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/Login")
public class Login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("user", null);
        session.setMaxInactiveInterval(3600 * 24);
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = ProfileService.auth(email, password);
        if (user != null) {
            session.setAttribute("user", user);
            response.sendRedirect("Profile");
        } else {
            response.sendRedirect("Error");
        }

    }
}
