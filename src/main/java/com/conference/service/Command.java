package com.conference.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;

public abstract class Command {
    public abstract void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
