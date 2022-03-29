package com.conference.servlets;

import com.conference.commands.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;

@WebServlet(name = "OfferController", value = "/OfferController")
public class OfferController extends HttpServlet {
    private HashMap<String, Command> commands;

    @Override
    public void init() {
        commands = new HashMap<>();
        commands.put("accept", new AcceptOfferCommand());
        commands.put("reject", new RejectOfferCommand());
        commands.put("request", new MakeRequestCommand());
        commands.put("acceptRequest", new AcceptRequestCommand());
        commands.put("rejectRequest", new RejectRequestCommand());
        commands.put("assign", new AssignFreeLectureCommand());
        commands.put("setlang", new SwitchLocaleCommand());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String command = req.getParameter("command");
        if (commands.containsKey(command)) {
            commands.get(command).execute(req, resp);
        }else{
            req.setAttribute("message","Wrong action");
            req.getRequestDispatcher("error-page.jsp").forward(req,resp);
        }
    }
}
