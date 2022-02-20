package com.conference.servlets;

import com.conference.commands.AddEventCommand;
import com.conference.commands.AddLectureCommand;
import com.conference.commands.Command;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.HashMap;

@WebServlet(name = "LectureController", value = "/LectureController")
public class LectureController extends HttpServlet {
    private HashMap<String, Command> commands;

    @Override
    public void init() {
        commands = new HashMap<>();
        commands.put("addevent", new AddEventCommand());
        commands.put("addlecture", new AddLectureCommand());
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
