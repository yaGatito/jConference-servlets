package com.conference.servlets;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Main", value = "/Main")
public class Main extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    static class Cycle implements Runnable {
        boolean switcher = true;
        @Override
        public void run() {
            System.out.println("----------------------------------------------------------------------------------");
        }
    }
}
