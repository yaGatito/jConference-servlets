package com.conference.servlets;

import com.conference.connection.DBCPool;
import com.conference.dao.LanguageDAO;
import com.conference.dao.TagDAO;
import com.conference.entity.Tag;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet(name = "UpdateTag", value = "/UpdateTag")
public class UpdateTag extends HttpServlet {
    private static final Map<Tag, Map<String, String>> shouldBeLocalized = new HashMap<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> locales = (List<String>) request.getServletContext().getAttribute("locales");
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        TagDAO tdao = new TagDAO();
        Map<Tag, Map<String, String>> translations = tdao.selectAllTagTranslations(connection);
//        Map<Tag, Map<String,String>> shouldBeLocalized = new HashMap<>();

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
            if (!tagLocales.containsAll(locales)) {
                forLocalization.removeAll(tagLocales);
            } else {
                forLocalization = new ArrayList<>();
            }
            if (!forLocalization.isEmpty()) {
                shouldBeLocalized.put(tag, new HashMap<>());
                for (String locale : forLocalization) {
                    shouldBeLocalized.get(tag).put(locale, languages.get(locale));
                }
            }
        }
        pool.putBackConnection(connection);
        request.setAttribute("goals", shouldBeLocalized.entrySet());
        request.getRequestDispatcher("update-tag.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TagDAO tdao = new TagDAO();
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        for (Map.Entry<Tag, Map<String, String>> entry : shouldBeLocalized.entrySet()) {
            Tag tag = entry.getKey();
            for (Map.Entry<String, String> localeEntry : entry.getValue().entrySet()) {
                String locale = localeEntry.getKey();
                String update = request.getParameter(locale + "Tag" + tag.getId());
                if(!tdao.addLocalization(connection, tag.getId(), localeEntry.getKey(), update)){
                    response.sendRedirect("Error");
                    return;
                }
            }
        }
        response.sendRedirect("Profile");
    }

//    public static void main(String[] args) {
//        List<String> locales = new ArrayList<>(List.of("en", "ua", "ru"));
//        Map<String, String> translations = Map.of("en", "Programming", "ua", "Програмування");
//        if (!translations.keySet().containsAll(locales)) {
//            locales.removeAll(translations.keySet());
//            System.out.println(locales);
//        }
//    }
}
