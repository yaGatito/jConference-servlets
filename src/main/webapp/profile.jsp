<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<jsp:include page="onlyForUser.jsp"/>
<body style="height: 100vh">
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

<jsp:include page="footer.jsp"/>
</body>
</html>