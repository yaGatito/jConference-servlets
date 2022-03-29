package com.conference.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Error", value = "/Error")
public class Error extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("message","Oops. Something goes wrong");
        request.getRequestDispatcher("error-page.jsp").forward(request, response);
    }
}
