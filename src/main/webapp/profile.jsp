<%@ page import="com.conference.bean.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>

<%
  int role = 0;
  User user = (User) request.getSession().getAttribute("user");
  if(user == null){
    response.sendRedirect("restricted-access.jsp");
  }else{
    role = user.getRoleID();
  }
  request.setAttribute("role",role);
%>

<body>
<c:choose>
  <c:when test="${role==1}">
    <jsp:include page="moder-profile.jsp"/>
  </c:when>
  <c:when test="${role==2}">
    <jsp:include page="speaker-profile.jsp"/>
  </c:when>
  <c:when test="${role==3}">
    <jsp:include page="listener-profile.jsp"/>
  </c:when>
</c:choose>

<jsp:include page="footer.html"/>
</body>
</html>