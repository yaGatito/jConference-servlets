<%@ page import="com.conference.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="com.conference.bean.Event" %>
<%@ page import="com.conference.dao.EventDAO" %>
<%@ page import="com.conference.dao.SELECT" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%!List<User> users;%>
<%!List<Event> events;%>
<%!UserDAO udao = new UserDAO();%>
<%!EventDAO edao = new EventDAO();%>
<%
    if (request.getSession().getAttribute("user") == null) {
        response.sendRedirect("restricted-access.jsp");
    }
    int maxItems = 5;
    int offset;
    if (request.getParameter("page") == null) {
        offset = 1;
    }else{
        offset = Integer.parseInt(request.getParameter("page"));
    }
    users = udao.selectLimit(maxItems, offset);
    events = edao.selectBy(SELECT.STATUS, 3);
%>
<!-- Admin profile -->


<div class="d-flex align-items-start container-xl" style="width: 80%">
    <div class="nav flex-column nav-pills me-3 coll" id="v-pills-tab" role="tablist" aria-orientation="vertical">
        <button class="btn btn-blue active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home"
                type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">Profile
        </button>
        <button class="btn btn-blue" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile"
                type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">Users
        </button>
        <button class="btn btn-blue" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages"
                type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">Events
        </button>
        <button class="btn btn-blue" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings"
                type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">Settings
        </button>
    </div>
    <div class="tab-content" id="v-pills-tabContent">
        <div class="tab-pane fade show active col" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">

        </div>
        <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
            <div class="col" style="width: 50rem; background-color: white">
                <table class="table table-info table-striped">
                    <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">User</th>
                        <th scope="col">Role</th>
                        <th scope="col">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (User user : users) {%>
                    <tr>
                        <td scope="row"><%=user.getId() %>
                        </td>
                        <td><%=user.getName() + " " + user.getLastname() %>
                        </td>
                        <td><%=user.getRole().toString()%>
                        </td>
                        <td>x v e</td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
                <nav aria-label="...">
                    <ul class="pagination pagination-sm">
                        <li class="page-item active" aria-current="page"><span class="page-link">1</span></li>
                        <li class="page-item"><a class="page-link" href="?page=2">2</a></li>
                        <li class="page-item"><a class="page-link" href="?page=3">3</a></li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="tab-pane fade col" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
            <table class="table table-info table-striped">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Topic</th>
                    <th scope="col">Speaker</th>
                    <th scope="col">Date and time</th>
                    <th scope="col">Location</th>
                    <th scope="col">Action</th>
                </tr>
                </thead>
                <tbody>
                <%for (Event event : events) {%>
                <tr>
                    <th scope="row"><%=event.getId()%>
                    </th>
                    <td><%=event.getTopic()%>
                    </td>
                    <td><%=udao.getByID(event.getSpeaker()).toString()%>
                    </td>
                    <td><%=event.getDate() + " " + event.getFromtime() + "-" + event.getTotime()%>
                    </td>
                    <%if (event.getCondition()) {%>
                    <td><a href="<%=event.getLocation().getAddress()%>"
                           target="_blank"><%=event.getLocation().getShortName()%>
                    </a></td>
                    <%}%>
                    <%if (!event.getCondition()) {%>
                    <td><%=event.getLocation().getShortName()%>
                    </td>
                    <%}%>
                    <td>x v e</td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
        <div class="tab-pane fade col" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">

        </div>
    </div>
</div>