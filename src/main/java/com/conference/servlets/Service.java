package com.conference.servlets;

import com.conference.service.AddEventCommand;
import com.conference.service.AddLectureCommand;
import com.conference.service.Command;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

@WebServlet(name = "Service", value = "/Service")
public class Service extends HttpServlet {

    private HashMap<String, Command> commands;

    @Override
    public void init() throws ServletException {
        commands = new HashMap<>();
        commands.put("addevent", new AddEventCommand());
        commands.put("addlecture",new AddLectureCommand());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String command = req.getParameter("command");
        if (commands.containsKey(command)) {
            commands.get(command).execute(req, resp);
        }else{
            req.setAttribute("message","Wrong action");
            req.getRequestDispatcher("error-page.jsp").forward(req,resp);
        }
    }
}
