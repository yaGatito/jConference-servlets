package com.conference.commands;

import com.conference.connection.DBCPool;
import com.conference.dao.UserDAO;
import com.conference.entities.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

public class DowngradeUserCommand implements Command{
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        User currentUser = (User) request.getSession().getAttribute("user");
        if (currentUser == null || currentUser.getRole() != 1){
            response.sendRedirect("Error");
            return;
        }
        UserDAO dao = new UserDAO();
        String idStr = request.getParameter("id");
        int id;
        try {
            id = Integer.parseInt(idStr);
        }catch (NumberFormatException e){
            e.printStackTrace();
            response.sendRedirect("Error");
            return;
        }
        User user = dao.getByID(connection,id);
        if (user == null){
            response.sendRedirect("Error");
            return;
        }else if (user.getRole()==2){
            dao.setRole(connection,3,id);
        }else if(user.getRole()==1){
            dao.setRole(connection,2,id);
        }
        response.sendRedirect("Profile?item=Users");
        pool.putBackConnection(connection);
    }
}
