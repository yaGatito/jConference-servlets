<%@ page import="com.conference.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.conference.connection.DBCPool" %>
<%@ page import="com.conference.entity.Tag" %>
<%@ page import="com.conference.dao.TagDAO" %>
<%@ page import="com.conference.dao.EventDAO" %>
<%@ page import="com.conference.entity.Event" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message var="title" key="label.update_event" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<%!List<User> speakers;%>
<%
    DBCPool pool = (DBCPool) config.getServletContext().getAttribute("pool");
    Connection connection = pool.getConnection();
    speakers = new UserDAO().selectSpeakers(connection);
    String locale = (String) request.getSession().getAttribute("lang");
    List<Tag> tags = new TagDAO().selectForLocale(connection, locale);
    int eventId;
    try {
         eventId = Integer.parseInt(request.getParameter("id"));
    }catch (NumberFormatException e){
        e.printStackTrace();
        response.sendRedirect("Error");
        return;
    }

    EventDAO edao = new EventDAO();
    Event event = edao.select(connection, "id", eventId, "1", 0, "id", locale).get(0);
    pool.putBackConnection(connection);
%>
<body>
<section class="container-xl col">
    <!--Add event-->
    <div class="margin col reg-sec addevent">
        <h1 class="display-6"><fmt:message key="label.update_event"/> </h1>
        <form id="event-form" class="col margin" action="UpdateEvent?id=<%=eventId%>" method="post">
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.button.topic"/> </h4>
                <input name="topic" class="form-control reg" type="text" value="<%=event.getTopic()%>" aria-label="Search" required>
            </div>
            <div class="coll" style="margin-top: 1rem; line-height: 0; align-self: start;" >
                <h4> <fmt:message key="label.add_event.tags"/> </h4>
                <div class="accordion accordion-flush" id="accordionFlushExample">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="flush-headingOne">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                                #
                            </button>
                        </h2>
                        <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                            <div class="accordion-body">
                                <% for (Tag tag : tags){%>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="tag<%=tag.getId()%>" id="flexCheckDefault<%=tag.getId()%>" <%if (event.getTags().contains(tag)){%> checked <%}%>>
                                    <label class="form-check-label" for="flexCheckDefault<%=tag.getId()%>">
                                        <%=tag.getName()%>
                                    </label>
                                </div>
                                <%}%>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.date"/> </h4>
                <input name="date" class="form-control reg" type="date" value="<%=event.getDate()%>" aria-label="Search" min="<%=LocalDate.now().toString()%>" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.from"/> </h4>
                <input name="fromtime" class="form-control reg" type="time" value="<%=event.getFromtime()%>" aria-label="Search" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4> <fmt:message key="label.to"/> </h4>
                <input name="totime" class="form-control reg" type="time" value="<%=event.getTotime()%>" aria-label="Search" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.location"/> </h4>
                <input name="location" class="form-control reg" type="text" value="<%=event.getLocation().getAddress()%>" aria-label="Search" required>
            </div>
            <p></p>
            <button class="btn btn-info" type="submit"> <fmt:message key="label.button.confirm"/> </button>
        </form>
    </div>
</section>
</body>
<jsp:include page="footer.jsp"/>
</html>