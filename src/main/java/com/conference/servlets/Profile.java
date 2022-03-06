package com.conference.servlets;

import com.conference.connection.DBCPool;
import com.conference.dao.LanguageDAO;
import com.conference.dao.TagDAO;
import com.conference.entity.Tag;
import com.conference.entity.User;
import com.conference.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet("/Profile")
public class Profile extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        HttpSession session = request.getSession();
        session.setAttribute("user",null);
        session.setMaxInactiveInterval(3600*24);
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        User user = new UserDAO().loginUser(connection,email,password);
        pool.putBackConnection(connection);
        if (user != null){
            session.setAttribute("user",user);
            request.getRequestDispatcher("profile.jsp").forward(request,response);
        }else{
            request.setAttribute("message", "Wrong password");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession(false).getAttribute("user");
        if (user == null){
            request.setAttribute("message", "Please log in");
            request.getRequestDispatcher("error-page.jsp").forward(request,response);
        }else{
            List<String> locales = (List<String>) request.getServletContext().getAttribute("locales");
            DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
            Connection connection = pool.getConnection();
            TagDAO tdao = new TagDAO();
            Map<Tag, Map<String, String>> translations = tdao.selectAllTagTranslations(connection);
            Map<Tag, Map<String,String>> shouldBeLocalized = new HashMap<>();

            Map<String, String> map = new LanguageDAO().select(connection);
            Map<String, String> languages = new HashMap<>();
            for (Map.Entry<String, String> entry : map.entrySet()) {
                if (locales.contains(entry.getKey())) {
                    languages.put(entry.getKey(), entry.getValue());
                }
            }
            for (Map.Entry<Tag, Map<String, String>> entry : translations.entrySet()) {
                Tag tag = entry.getKey();
                Set<String> tagLocales = entry.getValue().keySet();
                List<String> forLocalization = new ArrayList<>(locales);
                if (!tagLocales.containsAll(locales)){
                    forLocalization.removeAll(tagLocales);
                }else{
                    forLocalization = new ArrayList<>();
                }
                if (!forLocalization.isEmpty()){
                    shouldBeLocalized.put(tag, new HashMap<>());
                    for (String locale : forLocalization) {
                        shouldBeLocalized.get(tag).put(locale,languages.get(locale));
                    }
                }
            }
            pool.putBackConnection(connection);
            int count = 0;
            for (Map.Entry<Tag, Map<String, String>> entry : shouldBeLocalized.entrySet()) {
                for (Map.Entry<String, String> stringEntry : entry.getValue().entrySet()) {
                    count++;
                }
            }
            request.setAttribute("goals", count);
            request.getRequestDispatcher("profile.jsp").forward(request,response);
        }
    }
}
