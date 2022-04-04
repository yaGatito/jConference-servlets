package com.conference.servlets;

import com.conference.entities.User;
import com.conference.service.HomepageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "Homepage", value = "/Homepage")
public class Homepage extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(Homepage.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lang = (String) request.getSession().getAttribute("lang");
        Map<String, Object> attributes = HomepageService.pack(lang);
        attributes.forEach(request::setAttribute);
        request.getRequestDispatcher("homepage.jsp").forward(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = new User(3,name,lastname,email,password, true);
        boolean res = HomepageService.createUser(user);
        if (res){
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
