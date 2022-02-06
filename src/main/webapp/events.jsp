<%@ page import="com.conference.dao.EventDAO" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="com.conference.bean.Event" %>
<%@ page import="com.conference.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.SELECT" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<%!
    List<Event> events;
    UserDAO udao = new UserDAO();
    EventDAO edao = new EventDAO();
%>
<%
    events = edao.selectBy(SELECT.STATUS, 2);
%>
<body>
<section class="container-xl col">
    <div class="margin col">
        <!--Events-->

        <h2 class="display-6 margin">Events</h2>

        <div class="dropdown">
            <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton2"
                    data-bs-toggle="dropdown" aria-expanded="false">
                Sort events
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
                <li><a class="dropdown-item" href="#">by date</a></li>
                <li><a class="dropdown-item" href="#">by name of speaker</a></li>
                <li><a class="dropdown-item" href="#">by name of events</a></li>
            </ul>
        </div>
        <%for (Event event : events) {%>
        <div class="card border-info mb-3" style="width: 50rem;">
            <div class="card-header rowsb">

                <%
                    String speaker;
                    try {
                        speaker = udao.getByID(event.getSpeaker()).toString();
                    } catch (NullPointerException e) {
                        speaker = "deleted";
                    }
                %>
                <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="bi:person-circle"
                                                    data-width="1.1em"></span> <%=speaker%></p>

                <%
                    if(event.getCondition()) {
                %> <p style="margin-left: 10px;"> <span class="iconify-inline"
                                                                                     data-icon="pepicons:internet"
                                                                                     data-width="1.1em"></span>
                <a class="link-info"
                   href="<%=event.getLocation().getAddress()%>"><%=event.getLocation().getShortName()%>
                </a></p>

                <%} else {%>
                <p style="margin-left: 10px;"> <span class="iconify-inline" data-icon="akar-icons:location"
                                                    data-width="1.1em"></span><%=event.getLocation().getShortName()%></p>
                <%}%>
            </div>
            <div class="card-body text-secondary">
                <h5 class="card-title"><%=event.getTopic()%>
                </h5>
                <p class="card-text"><%=event.getDescription()%>
                </p>
                <a href="ParticipateController?action=join&event=<%=event.getId()%>" class="link-info">Participate</a>
            </div>
            <div class="card-footer rows">
                <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-time-five"
                                          data-width="1.1em"></span> <%=event.getFromtime() + " - " + event.getTotime()%>
                </p>
                <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-calendar"
                                          data-width="1.1em"></span> <%=event.getDate()%>
                </p>
            </div>
        </div>
        <%}%>

        <nav aria-label="...">
            <ul class="pagination pagination-sm">
                <li class="page-item active" aria-current="page">
                    <span class="page-link">1</span>
                </li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
            </ul>
        </nav>

    </div>
</section>
<jsp:include page="footer.jsp"/>
</body>
</html>