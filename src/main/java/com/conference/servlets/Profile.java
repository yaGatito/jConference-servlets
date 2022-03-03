package com.conference.servlets;

import com.conference.DBCPool;
import com.conference.entity.User;
import com.conference.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/Profile")
public class Profile extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        HttpSession session = request.getSession();
        session.setAttribute("user",null);
        session.setMaxInactiveInterval(3600*24);
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = new UserDAO().loginUser(connection,email,password);
        pool.putBackConnection(connection);
        if (user != null){
            session.setAttribute("user",user);
            request.getRequestDispatcher("profile.jsp").forward(request,response);
        }else{
            request.setAttribute("message", "Wrong password");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession(false).getAttribute("user");
        if (user == null){
            request.setAttribute("message", "Please log in");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }else{
            request.getRequestDispatcher("profile.jsp").forward(request,response);
        }
    }
}
