package com.conference.commands;

import com.conference.dao.RequestDAO;
import com.conference.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MakeRequestCommand implements Command {
    public static final Logger logger = LoggerFactory.getLogger(MakeRequestCommand.class);

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Oops. Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
        RequestDAO rdao = new RequestDAO();
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            request.setAttribute("message", "Please, log in");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
        if (rdao.createRequest(user.getId(),id)) {
            if (logger.isInfoEnabled()) {
                logger.info("REQUEST FOR FREE LECTURE[{}] WAS SUCCESSFUL CREATED BY USER[{}]", id, user.getId());
            }
            response.sendRedirect("Profile?item=Lectures");
        }else {
            if (logger.isInfoEnabled()) {
                logger.info("REQUEST FOR FREE LECTURE[{}] WAS NOT CREATED BY USER[{}]", id, user.getId());
            }
            request.setAttribute("message", "You can't accept this");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }

    }
}
