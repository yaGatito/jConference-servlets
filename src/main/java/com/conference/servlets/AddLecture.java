package com.conference.servlets;

import com.conference.bean.Lecture;
import com.conference.dao.LectureDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AddLecture", value = "/AddLecture")
public class AddLecture extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("add-lecture.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String topic = "";
        boolean asOffer = false;
        int event = 0;
        int speaker = 0;
        try {
            topic = request.getParameter("topic");
            event = Integer.parseInt(request.getParameter("event"));
            speaker = Integer.parseInt(request.getParameter("speaker"));
            asOffer = request.getParameter("offer") != null;
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }

        int status = 0;
        boolean isFree = true;
        if (speaker != 0) {
            if (asOffer){
                status = 2;
            }else{
                status = 3;
            }
            isFree = false;
        }
        Lecture lecture = new Lecture(topic, status, event, speaker);
        if (isFree && new LectureDAO().insertFreeLecture(lecture) || !isFree && new LectureDAO().insertLecture(lecture)) {
            response.sendRedirect("Profile");
        }else {
            request.setAttribute("message", "Something goes wrong");
            request.getRequestDispatcher("error-page.jsp").forward(request, response);
        }
    }
}
