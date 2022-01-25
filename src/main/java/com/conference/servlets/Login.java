package com.conference.servlets;

import com.conference.bean.User;
import com.conference.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/Login")
public class Login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = new UserDAO().loginUser(email,password);
        if (user != null){
            request.getSession().setAttribute("user",user);
            request.getRequestDispatcher("profile.jsp").forward(request,response);
        }else{
            request.getRequestDispatcher("wrong-pass.jsp").forward(request,response);
        }
    }
}
