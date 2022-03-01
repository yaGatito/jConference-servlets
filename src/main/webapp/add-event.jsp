<%@ page import="com.conference.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message var="title" key="label.add_event" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<%!List<User> speakers;%>
<%speakers = new UserDAO().selectSpeakers();%>
<body>
<section class="container-xl col">
    <!--Add event-->
    <div class="margin col reg-sec addevent">
        <h1 class="display-6"><fmt:message key="label.add_event"/> </h1>
        <form id="event-form" class="col margin" action="${pageContext.request.contextPath}/Service?command=addevent" method="post">
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.button.topic"/> </h4>
                <input name="topic" class="form-control reg" type="text" placeholder="" aria-label="Search" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4> <fmt:message key="label.add_event.tags"/> </h4>
                <textarea name="description" class="form-control reg" rows="4" cols="50" form="event-form"
                          required></textarea>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.date"/> </h4>
                <input name="date" class="form-control reg" type="date" placeholder="" aria-label="Search" min="<%=LocalDate.now().toString()%>" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.from"/> </h4>
                <input name="fromtime" class="form-control reg" type="time" placeholder="" aria-label="Search" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4> <fmt:message key="label.to"/> </h4>
                <input name="totime" class="form-control reg" type="time" placeholder="" aria-label="Search" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.location"/> </h4>
                <input name="location" class="form-control reg" type="text" placeholder="" aria-label="Search" required>
            </div>
            <p></p>
            <button class="btn btn-info" type="submit"> <fmt:message key="label.button.confirm"/> </button>
        </form>
    </div>
</section>

<!--Footer-->
<section class="container-xl rowsb">
    <div id="reg-sec" class="margin col">
        All rights reserved
    </div>
</section>

<jsp:include page="footer.jsp"/>
</body>
</html>