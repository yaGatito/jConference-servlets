package com.conference.listeners;

import javax.servlet.*;

import org.apache.log4j.Logger;
import org.apache.log4j.xml.DOMConfigurator;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.StringTokenizer;

/**
 * Context listener
 * @author N. Lazovskyi
 */
public class ContextListener implements ServletContextListener {
    private static final Logger log = Logger.getLogger(ContextListener.class);
    @Override
    public void contextInitialized(ServletContextEvent event) {
        log4jInit(event);
        initI18N(event);
    }

    /**
     * Initializing Log4J
     * @param context
     */
    private void log4jInit(ServletContextEvent context) {
        String webAppPath = context.getServletContext().getRealPath("/");
        String log4jFilePath = webAppPath + "WEB-INF/log4j.xml";
        DOMConfigurator.configure(log4jFilePath);
    }
    private void initI18N(ServletContextEvent event) {
        String localesValue = event.getServletContext().getInitParameter("locales");
        if (localesValue == null || localesValue.isEmpty()) {
        } else {
            List<String> locales = new ArrayList<>();
            StringTokenizer st = new StringTokenizer(localesValue);
            while (st.hasMoreTokens()) {
                String localeName = st.nextToken();
                locales.add(localeName);
            }
            event.getServletContext().setAttribute("locales", locales);
        }
    }



    @Override
    public void contextDestroyed(ServletContextEvent event) {}

}