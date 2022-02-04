<%@ page import="com.conference.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="com.conference.bean.Event" %>
<%@ page import="com.conference.dao.EventDAO" %>
<%@ page import="com.conference.dao.SELECT" %>
<%@ page import="java.util.Optional" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%!List<User> users;%>
<%!List<Event> events;%>
<%!UserDAO udao = new UserDAO();%>
<%!EventDAO edao = new EventDAO();%>
<%
    if (request.getSession().getAttribute("user") == null) {
        response.sendRedirect("restricted-access.jsp");
    }

    double maxItems = 5;
    double count = udao.getCount();
    double amount = Math.ceil(count / maxItems);
    int offset;
    try {
        offset = Integer.parseInt(request.getParameter("page"));
        if (offset > amount)
            offset = 1;
    } catch (NumberFormatException | NullPointerException e) {
        offset = 1;
    }

    String[] buttons = new String[]{"profile", "users", "events", "setting"};
    String item = Optional.ofNullable(request.getParameter("item")).orElse("profile");
    boolean flag = false;
    for (int i = 0; i < buttons.length; i++) {
        if (item.equals(buttons[i])) {
            flag = true;
        }
    }
    if (!flag) item = "profile";

    users = udao.selectLimit((int) maxItems, offset);
    events = edao.selectBy(SELECT.STATUS, 3);
%>
<!-- Admin profile -->


<div class="d-flex align-items-start container-xl" style="width: 80%">
    <div class="nav flex-column nav-pills me-3 coll" id="v-pills-tab" role="tablist" aria-orientation="vertical">
        <%for (String button : buttons) {%>
        <a class="btn btn-blue <%= item.equals(button) ? " active" : ""%>" href="Profile?item=<%=button%>"><%=button%>
        </a>
        <%}%>
    </div>
    <%if (item.equals("users")) { %>
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
            <%for (User user : users) {%>
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
                <%for (int i = 1; i <= amount; i++) {%>
                <li class="page-item<%= i == offset ? " active" : ""%>"><a class="page-link" href="Profile?item=users&page=<%=i%>"><%=i%>
                </a></li>
                <%}%>
            </ul>
        </nav>
    </div>

    <%} else if (item.equals("events")) {%>
    <div>
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
    <%}%>
</div>