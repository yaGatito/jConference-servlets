<%@ page import="com.conference.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<%
  request.getSession(false).setAttribute("user",null);
%>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message var="title" key="label.button.logout" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<body>
  <section class="container-xl col">
    <!--Login-->
    <div class="margin col reg-sec" style="width: 50rem">
      <h2 class="display-10"><fmt:message key="message.logout"/> </h2>
    </div>
  </section>
<jsp:include page="footer.jsp"/>
</body>
</html>