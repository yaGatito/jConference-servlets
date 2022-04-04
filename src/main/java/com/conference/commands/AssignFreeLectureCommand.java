package com.conference.commands;

import com.conference.connection.DBCPool;
import com.conference.dao.RequestDAO;
import com.conference.entities.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

public class AssignFreeLectureCommand implements Command {
    public static final Logger logger = LoggerFactory.getLogger(AssignFreeLectureCommand.class);
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        int lecture = 0;
        int speaker = 0;
        try {
             lecture = Integer.parseInt(request.getParameter("lecture"));
             speaker = Integer.parseInt(request.getParameter("speaker"));
        }catch (NumberFormatException e){
            e.printStackTrace();
            request.setAttribute("message", "Oops. Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }
        RequestDAO rdao = new RequestDAO();
        User user = (User) request.getSession().getAttribute("user");
        if (user == null){
            request.setAttribute("message", "Please, log in");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }
        if (rdao.secureLecture(connection,speaker,lecture)){
            if (logger.isInfoEnabled()) {
                logger.info("FREE LECTURE[{}] WAS SUCCESSFUL ASSIGNED TO USER[{}]",lecture,speaker);
            }
            response.sendRedirect("Profile?item=Lectures");
        }else{
            if (logger.isInfoEnabled()) {
                logger.info("FREE LECTURE[{}] WAS FAILURE ASSIGNED TO USER[{}]",lecture,speaker);
            }
            request.setAttribute("message", "You can't assign another lectures");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }
        pool.putBackConnection(connection);
    }
}
