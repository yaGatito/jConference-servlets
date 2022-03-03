package com.conference.commands;

import com.conference.DBCPool;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

public class SwitchLocaleCommand implements Command{
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lang = request.getParameter("lang");
        if (lang != null && ((List<String>) request.getServletContext().getAttribute("locales")).contains(lang)) {
            request.getSession().setAttribute("lang", lang);
        }
        response.sendRedirect("Homepage");
    }
}
