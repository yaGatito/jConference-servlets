package com.conference.commands;

import com.conference.connection.DBCPool;
import com.conference.dao.ListenersDAO;
import com.conference.entities.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

public class LeaveEventCommand implements Command {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = DBCPool.getInstance();
        Connection connection = pool.getConnection();
        try {
            int event;
            int listener = ((User) request.getSession().getAttribute("user")).getId();
            boolean res;
            event = Integer.parseInt(request.getParameter("event"));
            res = new ListenersDAO().deleteListener(connection,event,listener);
            pool.putBackConnection(connection);
            if (res){
                response.sendRedirect("Profile?item=Your%20participation");
            }else{
                response.sendRedirect("Error");
            }
        }catch (NullPointerException | NumberFormatException exception){
            response.sendRedirect("Error");
        }
    }
}
