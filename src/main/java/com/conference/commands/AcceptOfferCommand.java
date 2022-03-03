package com.conference.commands;

import com.conference.DBCPool;
import com.conference.dao.LectureDAO;
import com.conference.entity.Lecture;
import com.conference.entity.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

public class AcceptOfferCommand implements Command {
    public static final Logger logger = LoggerFactory.getLogger(AcceptOfferCommand.class);
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
        List<Lecture> lectures = ldao.selectBySpeaker(connection,2, user.getId());
        boolean flag = false;
        for (Lecture lecture : lectures) {
            if (lecture.getId()==id){
                flag = true;
                break;
            }
        }
        if (flag){
            ldao.acceptOffer(connection,id);
            if (logger.isInfoEnabled()) {
                logger.info("OFFER[{}] WAS SUCCESSFUL ACCEPTED BY USER[{}]",id,user.getId());
            }
            response.sendRedirect("Profile?item=Lectures");
        }else{
            if (logger.isInfoEnabled()) {
                logger.info("OFFER[{}] WAS FAILURE ACCEPTED BY USER[{}]",id,user.getId());
            }
            request.setAttribute("message", "You can't accept another lectures");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }
        pool.putBackConnection(connection);

    }
}
