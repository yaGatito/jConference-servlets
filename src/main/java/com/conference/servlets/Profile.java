package com.conference.servlets;

import com.conference.connection.DBCPool;
import com.conference.entities.User;
import com.conference.service.ProfileService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet("/Profile")
public class Profile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession(false).getAttribute("user");
        String lang = (String) request.getSession().getAttribute("lang");
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();

        if (user == null) {
            response.sendRedirect("Error");
        } else {
            String item = request.getParameter("item");
            Map<String, Object> attributes = ProfileService.packByDefault(connection, item, user.getId(), lang);
            attributes.forEach(request::setAttribute);
            switch (user.getRole()) {
                //Moder
                case 1: {
                    String page = request.getParameter("page");
                    List<String> locales = (List<String>) request.getServletContext().getAttribute("locales");
                    attributes = ProfileService.packForModer(connection, page, locales);
                    attributes.forEach(request::setAttribute);
                    break;
                }
                //Speaker
                case 2: {
                    attributes = ProfileService.packForSpeaker(connection, user);
                    attributes.forEach(request::setAttribute);
                    break;
                }
                //Listener
                case 3: {
                    break;
                }
            }
            request.getRequestDispatcher("user-profile.jsp").forward(request, response);
        }

        pool.putBackConnection(connection);
    }
}
