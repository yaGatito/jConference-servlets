<%@ page import="com.conference.bean.User" %>
<%
    int role = 0;
    User user = (User) request.getSession().getAttribute("user");
    if(user == null){
        response.sendRedirect("restricted-access.jsp");
    }else{
        role = user.getRole();
    }
    request.setAttribute("role",role);
%>
