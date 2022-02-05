package com.conference.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Error", value = "/Error")
public class Error extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = request.getParameter("message");
        if (message!=null) {
            message = String.join(" ", message.split("_"));
        }else{
            message = "404";
        }
        request.setAttribute("message",message);
        request.getRequestDispatcher("error-page.jsp").forward(request,response);
    }
}
