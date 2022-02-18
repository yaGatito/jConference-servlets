package com.conference.servlets;

import com.conference.bean.User;
import com.conference.dao.UserDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/Registration")
public class Registration extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(Registration.class);
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = new User(3,name,lastname,email,password);
        if (new UserDAO().insertUser(user)){
            request.getSession().setAttribute("user",user);
            if (logger.isInfoEnabled()) {
                logger.info("SUCCESSFUL REGISTRATION USER: NAME[{}] LASTNAME[{}] EMAIL[{}] ", name, lastname, email);
            }
            response.sendRedirect("Profile");
        }else{
            if(logger.isInfoEnabled()) {
                logger.info("FAILURE REGISTRATION USER: NAME[{}] LASTNAME[{}] EMAIL[{}]",name,lastname,email);
            }
            request.setAttribute("message","Wrong registration");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }


    }
}
