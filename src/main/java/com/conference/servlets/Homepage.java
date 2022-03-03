package com.conference.servlets;

import com.conference.DBCPool;
import com.conference.entity.Event;
import com.conference.dao.EventDAO;
import com.conference.dao.LectureDAO;
import com.conference.dao.UserDAO;
import com.conference.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet(name = "Homepage", value = "/Homepage")
public class Homepage extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(Homepage.class);
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        UserDAO udao = new UserDAO();
        EventDAO edao = new EventDAO();
        request.setAttribute("udao",udao);
        //Display only 5 future nearest events

        List<Event> events = edao.select(connection,"status", 1,"5", 0, "date, fromtime");


        events = Event.filter(events)[1];
        LectureDAO lecdao = new LectureDAO();

        request.setAttribute("events",events);
        request.setAttribute("lecdao", lecdao);

        request.getRequestDispatcher("homepage.jsp").forward(request,response);
        pool.putBackConnection(connection);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        String name = request.getParameter("name");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = new User(3,name,lastname,email,password);

        if (new UserDAO().insertUser(connection, user)){

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
        pool.putBackConnection(connection);
    }
}
