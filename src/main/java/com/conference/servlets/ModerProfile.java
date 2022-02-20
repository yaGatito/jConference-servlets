package com.conference.servlets;

import com.conference.entity.Event;
import com.conference.entity.User;
import com.conference.dao.EventDAO;
import com.conference.dao.ListenersDAO;
import com.conference.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "ModerProfile", value = "/ModerProfile")
public class ModerProfile extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<User> users;
        List<Event> events;
        UserDAO udao = new UserDAO();
        EventDAO edao = new EventDAO();
        ListenersDAO ldao = new ListenersDAO();
        User currentUser = (User) request.getSession().getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect("restricted-access.jsp");
        }

        double maxItems = 5;
        double count = udao.getCount();
        double amount = Math.ceil(count / maxItems);
        int offset;
        try {
            offset = Integer.parseInt(request.getParameter("page"));
            if (offset > amount)
                offset = 1;
        } catch (NumberFormatException | NullPointerException e) {
            offset = 1;
        }

        final String[] buttons = new String[]{"Profile", "Your participation", "Your events", "Free events", "Users", "Events Control Panel", "Setting"};
        String item = Optional.ofNullable(request.getParameter("item")).orElse(buttons[0]);
        boolean flag = false;
        for (String button : buttons) {
            if (item.equals(button)) {
                flag = true;
                break;
            }
        }
        if (!flag) item = "profile";

        request.setAttribute("buttons",buttons);
        request.setAttribute("item",item);


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
