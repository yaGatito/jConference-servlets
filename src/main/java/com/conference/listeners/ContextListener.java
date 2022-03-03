package com.conference.listeners;

import javax.servlet.*;

import com.conference.DBCPool;
import org.apache.log4j.Logger;
import org.apache.log4j.xml.DOMConfigurator;
import java.util.ArrayList;
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
        log.info("INITIALIZED LOG4J SYSTEM");
        initI18N(event);
        log.info("INITIALIZED I18N SYSTEM");
        initDBCPool(event);
        log.info("INITIALIZED DBCPool SYSTEM");
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
    /**
     * Initializing i18n
     * @param event
     */
    private void initI18N(ServletContextEvent event) {
        String localesValue = event.getServletContext().getInitParameter("locales");
        if (localesValue != null && !localesValue.isEmpty()) {
            List<String> locales = new ArrayList<>();
            StringTokenizer st = new StringTokenizer(localesValue);
            while (st.hasMoreTokens()) {
                String localeName = st.nextToken();
                locales.add(localeName);
            }
            event.getServletContext().setAttribute("locales", locales);
        }
    }

    /**
     * Initializing Connection Pool
     * @param event
     */
    private void initDBCPool(ServletContextEvent event){
        event.getServletContext().setAttribute("pool", DBCPool.getInstance());
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {}

}