package com.conference.listeners;

import javax.servlet.*;
import org.apache.log4j.xml.DOMConfigurator;

public class Log4jInit implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        String webAppPath = event.getServletContext().getRealPath("/");
        String log4jFilePath = webAppPath + "WEB-INF/log4j.xml";
        DOMConfigurator.configure(log4jFilePath);
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {}

}