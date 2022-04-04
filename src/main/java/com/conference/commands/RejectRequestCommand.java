package com.conference.commands;

import com.conference.connection.DBCPool;
import com.conference.dao.LectureDAO;
import com.conference.entities.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

public class RejectRequestCommand implements Command {
    public static final Logger logger = LoggerFactory.getLogger(RejectRequestCommand.class);
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        int id = 0;
        try {
             id = Integer.parseInt(request.getParameter("id"));
        }catch (NumberFormatException e){
            e.printStackTrace();
            request.setAttribute("message", "Oops. Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }
        LectureDAO ldao = new LectureDAO();
        User user = (User) request.getSession().getAttribute("user");
        if (user == null){
            request.setAttribute("message", "Please, log in");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }

        if (ldao.rejectOffer(connection,id)){
            if (logger.isInfoEnabled()) {
                logger.info("OFFER[{}] WAS SUCCESSFUL REJECTED BY USER[{}]",id,user.getId());
            }
            response.sendRedirect("Profile?item=Events");
        }else{
            if (logger.isInfoEnabled()) {
                logger.info("OFFER[{}] WAS FAILURE REJECTED BY USER[{}]",id,user.getId());
            }
            request.setAttribute("message", "You can't reject another lectures");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }
        pool.putBackConnection(connection);

    }
}
