package com.conference.filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Locale;

@WebFilter(filterName = "LangInitFilter", urlPatterns = {"/*"})
public class LangInitFilter implements Filter {
    private FilterConfig config = null;

    @Override
    public void init(FilterConfig filterConfig) {
        this.config = filterConfig;
    }

    @Override
    public void destroy() {
        this.config = null;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain next) throws IOException, ServletException {
        Locale locale = request.getLocale();
        HttpServletRequest httpRequest = ((HttpServletRequest) request);
        HttpSession session = httpRequest.getSession(true);
        if (session.isNew()) {
            String l = locale.toString();
            List<String> locales = (List<String>) request.getServletContext().getAttribute("locales");
            if (!locales.contains(l)) {
                //Default locale
                l = "en";
            }
            session.setAttribute("lang", l);
        }
        next.doFilter(request, response);
    }
}
