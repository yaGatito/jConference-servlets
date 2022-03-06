package com.conference.servlets;

import com.conference.connection.DBCPool;
import com.conference.entity.User;
import com.conference.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        User currentUser = (User) request.getSession().getAttribute("user");
        if (currentUser == null || currentUser.getRole() != 1){
            request.setAttribute("message","You have not any permission for it");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
        UserDAO dao = new UserDAO();
        String upgrade = request.getParameter("upgrade");
        String downgrade = request.getParameter("downgrade");
        if (upgrade!=null){
            int id = Integer.parseInt(upgrade);
            User user = dao.getByID(connection,id);
            if (user == null){
                request.setAttribute("message","Wrong user");
                request.getRequestDispatcher("error-page.jsp").forward(request, response);
            }else if (user.getRole()==3){
                dao.setRole(connection,2,id);
            }else if(user.getRole()==2){
                dao.setRole(connection,1,id);
            }
        }else if(downgrade!=null){
            int id = Integer.parseInt(downgrade);
            User user = dao.getByID(connection,id);
            if (user == null){
                request.setAttribute("message","Wrong user");
                request.getRequestDispatcher("error-page.jsp").forward(request, response);
            }else if (user.getRole()==2){
                dao.setRole(connection,3,id);
            }else if(user.getRole()==1){
                dao.setRole(connection,2,id);
            }
        }
//        response.sendRedirect("Profile?item=Users");
    }
}
