package com.conference.filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter(filterName = "CharacterSetFilter", urlPatterns = { "/*" })
public class CharacterSetFilter implements Filter {
    private FilterConfig config = null;
    private static String encoding;
    @Override
    public void init(FilterConfig filterConfig){
        this.config = filterConfig;
        encoding = filterConfig.getInitParameter("encoding");
    }

    @Override
    public void destroy() {
        this.config = null;
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain next) throws IOException, ServletException {
        request.setCharacterEncoding(encoding);
        response.setContentType("charset="+encoding);
        response.setCharacterEncoding(encoding);
        next.doFilter(request, response);
    }
}
