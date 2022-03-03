package com.conference.servlets;

import com.conference.DBCPool;
import com.conference.entity.User;
import com.conference.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "UpdateUser", value = "/UpdateUser")
public class UpdateUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        request.setCharacterEncoding("UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        String name = request.getParameter("name");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String notify = request.getParameter("notify");
        user.setName(name);
        user.setLastname(lastname);
        user.setEmail(email);
        user.setNotify(notify != null);
        new UserDAO().updateUser(connection,user);
        pool.putBackConnection(connection);
        response.sendRedirect("Profile");
    }
}
