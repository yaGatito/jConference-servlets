<%@ page import="com.conference.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="com.conference.bean.Event" %>
<%@ page import="com.conference.dao.EventDAO" %>
<%@ page import="java.util.Optional" %>
<%@ page import="com.conference.dao.ListenersDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%!
    List<User> users;
    List<Event> events;
    UserDAO udao = new UserDAO();
    EventDAO edao = new EventDAO();
    ListenersDAO ldao = new ListenersDAO();
%>
<%
    User currentUser = (User) request.getSession().getAttribute("user");
    if (currentUser == null) {
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

    final String[] buttons = new String[]{"Profile", "Your participation", "Your events", "Free events", "Users", "Events Control Panel", "Setting"};
    String item = Optional.ofNullable(request.getParameter("item")).orElse(buttons[0]);
    boolean flag = false;
    for (int i = 0; i < buttons.length; i++) {
        if (item.equals(buttons[i])) {
            flag = true;
        }
    }
    if (!flag) item = "profile";


%>
<!-- Admin profile -->

<body>
<div class="d-flex align-items-start container-xl margin" style="width: 80%">
    <div class="nav flex-column nav-pills me-3 coll" id="v-pills-tab" role="tablist" aria-orientation="vertical">
        <%for (String button : buttons) {%>
        <a class="btn btn-blue <%= item.equals(button) ? " active" : ""%>" href="Profile?item=<%=button%>"><%=button%>
        </a>
        <%}%>
    </div>
    <%
        switch (item) {
            case "Profile":
    %>
    <div class="col">
        <div class="reg-sec distance">
            <form action="UpdateUser" method="post" class="container-xl col" style="margin-top: 3rem;width: 30rem;">
                <div class="input-group distance">
                    <span class="input-group-text">First name</span>
                    <input type="text" aria-label="Search" class="form-control" name="name"
                           value="<%=currentUser.getName()%>">
                </div>
                <div class="input-group distance">
                    <span class="input-group-text">Last name</span>
                    <input type="text" aria-label="Search" class="form-control" name="lastname"
                           value="<%=currentUser.getLastname()%>">
                </div>
                <div class="input-group distance">
                    <span class="input-group-text">Email</span>
                    <input type="text" aria-label="First name" class="form-control" name="email"
                           value="<%=currentUser.getEmail()%>">
                </div>
                <div class="form-check form-switch distance">
                    <input class="form-check-input" type="checkbox" name="notify" role="switch" id="flexSwitchCheckDefault" <%if (currentUser.getNotify()) {%> checked <%}%> >
                    <label class="form-check-label" for="flexSwitchCheckDefault">Receive email notifications</label>
                </div>
                <div class="input-group distance">
                    <button type="submit" class="btn btn-info">Save</button>
                </div>
                <div class="input-group distance">
                    <a class="btn btn-info" href="">Change password</a>
                </div>
            </form>
        </div>
        <%
                break;
            case "Your participation":
                events = ldao.selectEventsOfListeners(currentUser.getId());
        %>
        <div class="col distance">
            <div class="rowsa">
                <div class="distance dropdown">
                    <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton3" data-bs-toggle="dropdown" aria-expanded="false">
                        Sort events
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton3">
                        <li><a class="dropdown-item" href="#">by date</a></li>
                        <li><a class="dropdown-item" href="#">by name of speaker</a></li>
                        <li><a class="dropdown-item" href="#">by name of events</a></li>
                    </ul>
                </div>
                <div class="distance">
                    <a class="btn btn-info" href="add-topic.jsp">Add topic</a>
                </div>

                <div class="distance">
                    <a class="btn btn-info" href="add-event.jsp">Add event</a>
                </div>
            </div>
            <table class="table table-info table-striped">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Topic</th>
                    <th scope="col">Date and time</th>
                    <th scope="col">Location</th>
                    <th scope="col">Action</th>
                </tr>
                </thead>
                <tbody>
                <%for (Event event : events) {%>
                <tr>
                    <th scope="row"><%=event.getId()%></th>
                    <td><%=event.getTopic()%></td>
                    <td><%=event.getDate() + " " + event.getFromtime() + "-" + event.getTotime()%></td>
                    <%if (event.getCondition()) {%>
                    <td><a href="<%=event.getLocation().getAddress()%>"
                           target="_blank"><%=event.getLocation().getShortName()%>
                    </a></td>
                    <%}%>
                    <%if (!event.getCondition()) {%>
                    <td><%=event.getLocation().getShortName()%>
                    </td>
                    <%}%>
                    <td>
                        <a href=""><span class="iconify-inline" data-icon="clarity:note-edit-line" style="color: #005;" data-width="24"></span></a>
                        <a href="ParticipateController?action=unjoin&event=<%=event.getId()%>"><span class="iconify-inline" data-icon="feather:x-square" style="color: #005;" data-width="24"></span></a>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
        <%
                break;
            case "Your events":
                events = edao.select("speaker", currentUser.getId(), "all",0,"date, fromtime");
        %>
        <div class="col distance">
            <div class="rowsa">
                <div class="distance dropdown">
                    <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton4" data-bs-toggle="dropdown" aria-expanded="false">
                        Sort events
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton4">
                        <li><a class="dropdown-item" href="#">by date</a></li>
                        <li><a class="dropdown-item" href="#">by name of speaker</a></li>
                        <li><a class="dropdown-item" href="#">by name of events</a></li>
                    </ul>
                </div>
                <div class="distance">
                    <a class="btn btn-info" href="add-topic.jsp">Add topic</a>
                </div>

                <div class="distance">
                    <a class="btn btn-info" href="add-event.jsp">Add event</a>
                </div>
            </div>
            <table class="table table-info table-striped">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Topic</th>
                    <th scope="col">Date and time</th>
                    <th scope="col">Location</th>
                    <th scope="col">Action</th>
                </tr>
                </thead>
                <tbody>
                <%for (Event event : events) {%>
                <tr>
                    <th scope="row"><%=event.getId()%></th>
                    <td><%=event.getTopic()%></td>
                    <td><%=event.getDate() + " " + event.getFromtime() + "-" + event.getTotime()%></td>
                    <%if (event.getCondition()) {%>
                    <td><a href="<%=event.getLocation().getAddress()%>"
                           target="_blank"><%=event.getLocation().getShortName()%>
                    </a></td>
                    <%}%>
                    <%if (!event.getCondition()) {%>
                    <td><%=event.getLocation().getShortName()%>
                    </td>
                    <%}%>
                    <td>
                        <a href=""><span class="iconify-inline" data-icon="clarity:note-edit-line" style="color: #005;" data-width="24"></span></a>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
        <%
                break;
            case "Free events":
                events = edao.select("status", 0, "all", 0, "date, fromtime");
        %>
        <div class="col distance">
            <div class="rowsa">
                <div class="distance dropdown">
                    <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton5" data-bs-toggle="dropdown" aria-expanded="false">
                        Sort events
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton5">
                        <li><a class="dropdown-item" href="#">by date</a></li>
                        <li><a class="dropdown-item" href="#">by name of speaker</a></li>
                        <li><a class="dropdown-item" href="#">by name of events</a></li>
                    </ul>
                </div>
                <div class="distance">
                    <a class="btn btn-info" href="add-topic.jsp">Add topic</a>
                </div>

                <div class="distance">
                    <a class="btn btn-info" href="add-event.jsp">Add event</a>
                </div>
            </div>
            <table class="table table-info table-striped">
                <thead>
                <tr>
                    <th scope="col">
                        <table>
                            <tr><td>Topic</td></tr>
                            <tr><td></td></tr>
                        </table>
                    </th>
                    <th scope="col">Description</th>
                </tr>
                </thead>
                <tbody>
                <%for (Event event : events) {%>
                <tr>
                    <td>
                        <table>
                            <tr><td><%=event.getTopic()%></td></tr>
                            <tr><td><a href="">Take</a></td></tr>
                        </table>
                    </td>
                    <td><%=event.getDescription()%></td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
        <%
                break;
            case "Users":
                users = udao.selectLimit((int) maxItems, offset);
        %>
        <div class="col distance" style=" background-color: white">
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
                    <td><%=User.getNameRole(user.getRole())%>
                    </td>
                    <td>
                        <a href="Controller?upgrade=<%=user.getId()%>"><span class="iconify-inline" data-icon="grommet-icons:upgrade" style="color: #005;" data-width="24"></span></a>
                        <a href="Controller?downgrade=<%=user.getId()%>"><span class="iconify-inline" data-icon="grommet-icons:upgrade" style="color: #005;" data-width="24" data-rotate="180deg"></span></a>
                        <a href="Controller?delete=<%=user.getId()%>"><span class="iconify-inline" data-icon="bi:x-circle" style="color: #005;" data-width="24"></span></a>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
            <%if (amount > 1) {%>
            <nav aria-label="...">
                <ul class="pagination pagination-sm">
                    <%for (int i = 1; i <= amount; i++) {%>
                    <li class="page-item<%= i == offset ? " active" : ""%>"><a class="page-link"
                                                                               href="Profile?item=Users&page=<%=i%>"><%=i%>
                    </a></li>
                    <%}%>
                </ul>
            </nav>
            <%}%>
        </div>
        <%
                break;
            case "Events Control Panel":
                events = edao.select("status", 2, "all", 0, "date, fromtime");
        %>
        <div class="col distance">
            <div class="rowsa">
                <div class="distance dropdown">
                    <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
                        Sort events
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
                        <li><a class="dropdown-item" href="#">by date</a></li>
                        <li><a class="dropdown-item" href="#">by name of speaker</a></li>
                        <li><a class="dropdown-item" href="#">by name of events</a></li>
                    </ul>
                </div>
                <div class="distance">
                    <a class="btn btn-info" href="add-topic.jsp">Add topic</a>
                </div>

                <div class="distance">
                    <a class="btn btn-info" href="add-event.jsp">Add event</a>
                </div>
            </div>
            <table class="table table-info table-striped">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Topic</th>
                    <th scope="col">Date and time</th>
                    <th scope="col">Location</th>
                    <th scope="col">Action</th>
                </tr>
                </thead>
                <tbody>
                <%for (Event event : events) {%>
                <tr>
                    <th scope="row"><%=event.getId()%></th>
                    <td><%=event.getTopic()%></td>
                    <td><%=event.getDate() + " " + event.getFromtime() + "-" + event.getTotime()%></td>
                    <%if (event.getCondition()) {%>
                    <td><a href="<%=event.getLocation().getAddress()%>"
                           target="_blank"><%=event.getLocation().getShortName()%>
                    </a></td>
                    <%}%>
                    <%if (!event.getCondition()) {%>
                    <td><%=event.getLocation().getShortName()%>
                    </td>
                    <%}%>
                    <td>
                        <a href=""><span class="iconify-inline" data-icon="clarity:note-edit-line" style="color: #005;" data-width="24"></span></a>
                        <a href=""><span class="iconify-inline" data-icon="feather:x-square" style="color: #005;" data-width="24"></span></a>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
        <%
                    break;
            }
        %>
    </div>
</div>

</body>