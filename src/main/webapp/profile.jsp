<%@ page import="com.conference.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.entity.Event" %>
<%@ page import="java.util.Optional" %>
<%@ page import="com.conference.entity.Lecture" %>
<%@ page import="com.conference.dao.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<body style="height: 100vh">
    <%!
  List<User> users;
  List<Event> events;
  List<Lecture> lectures;
  List<User> speakers;
  RequestDAO rdao = new RequestDAO();
  UserDAO udao = new UserDAO();
  EventDAO edao = new EventDAO();
  LectureDAO lecdao = new LectureDAO();
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

  final String[] buttons = new String[]{"Profile", "Participation", "Lectures", "Users", "Events Control Panel", "Setting"};
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
        <div  style="background-color: #fff"  class="reg-sec distance">
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
                    <input class="form-check-input" type="checkbox" name="notify" role="switch"
                           id="flexSwitchCheckDefault" <%if (currentUser.getNotify()) {%> checked <%}%> >
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
            case "Participation":
                events = ldao.selectEventsOfListeners(currentUser.getId());
        %>

        <div  style="background-color: #fff"  class="col distance">
            <%if (events.size() > 0) {%>
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
                    <th scope="row"><%=event.getId()%>
                    </th>
                    <td><%=event.getTopic()%>
                    </td>
                    <td><%=event.getDate() + " " + event.getFromtime() + "-" + event.getTotime()%>
                    </td>
                    <%if (event.getCondition()) {%>
                    <td>
                        <a href="<%=event.getLocation().getAddress()%>"
                           target="_blank"><%=event.getLocation().getShortName()%>
                        </a>
                    </td>
                    <%}%>
                    <%if (!event.getCondition()) {%>
                    <td><%=event.getLocation().getShortName()%>
                    </td>
                    <%}%>
                    <td>
                        <a href="ParticipateController?action=unjoin&event=<%=event.getId()%>"><span
                                class="iconify-inline" data-icon="feather:x-square" style="color: #005;"
                                data-width="24"></span></a>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
            <%} else {%>
            <h2>You don't have any participation now</h2>
            <%}%>
        </div>

        <%
                break;
            case "Lectures":
        %>
        <div class="col distance" style=" background-color: white">
            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue active" id="pills-lectures-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-lectures" type="button" role="tab" aria-controls="pills-lectures"
                            aria-selected="true">Lectures
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-profile-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile"
                            aria-selected="false">Offers
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-requests-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-requests" type="button" role="tab" aria-controls="pills-requests"
                            aria-selected="false">Requests
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-free-tab" data-bs-toggle="pill" data-bs-target="#pills-free"
                            type="button" role="tab" aria-controls="pills-free" aria-selected="false">Free
                    </button>
                </li>
            </ul>
            <%---------------------------SECURED---------------------%>
            <div class="tab-content" id="pills-tabContent">

                <div  style="background-color: #fff"  class="tab-pane fade show active" id="pills-lectures" role="tabpanel"
                     aria-labelledby="pills-lectures-tab">
                    <%lectures = lecdao.selectBySpeaker(3, currentUser.getId());%>
                    <%if (lectures.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Event</th>
                            <th scope="col">Lecture</th>
                            <th scope="col">Date and time</th>
                            <th scope="col">Location</th>
                            <th scope="col">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getId()%>
                            </th>
                            <% Event event = edao.select("id", lecture.getEvent(), "1", 0, "date, fromtime").get(0); %>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=lecture.getTopic()%>
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
                            <td>
                                <%--                                <a href=""><span class="iconify-inline" data-icon="clarity:note-edit-line"--%>
                                <%--                                                 style="color: #005;" data-width="24"></span></a>--%>
                            </td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2>You don't have any lectures </h2>
                    <%}%>
                </div>
                <%---------------------------OFFERS---------------------%>
                <div  style="background-color: #fff"  class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                    <%lectures = lecdao.selectBySpeaker(2, currentUser.getId());%>
                    <%if (lectures.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Event</th>
                            <th scope="col">Lecture</th>
                            <th scope="col">Date and time</th>
                            <th scope="col">Location</th>
                            <th scope="col">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getId()%>
                            </th>
                            <% Event event = edao.select("id", lecture.getEvent(), "1", 0, "date, fromtime").get(0); %>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=lecture.getTopic()%>
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
                            <td>
                                <a href="OfferController?command=accept&id=<%=lecture.getId()%>"><span
                                        class="iconify-inline" data-icon="clarity:success-standard-line"
                                        style="color: #005;" data-width="24"></span></a>
                                <a href="OfferController?command=reject&id=<%=lecture.getId()%>"><span
                                        class="iconify-inline" data-icon="carbon:close-outline"
                                        style="color: #005;" data-width="24"></span></a>
                            </td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2>You don't have any offers </h2>
                    <%}%>
                </div>
                <%---------------------------REQUESTS---------------------%>
                <div style="background-color: #fff" class="tab-pane fade" id="pills-requests" role="tabpanel"
                     aria-labelledby="pills-requests-tab">
                    <%lectures = lecdao.selectBySpeaker(1, currentUser.getId());%>
                    <%if (lectures.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Event</th>
                            <th scope="col">Lecture</th>
                            <th scope="col">Date and time</th>
                            <th scope="col">Location</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select("id", lecture.getEvent(), "1", 0, "date, fromtime").get(0); %>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=lecture.getTopic()%>
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
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2>You didn't make request to give a lecture </h2>
                    <%}%>
                    <div class="distance">
                        <a class="btn btn-info" href="AddRequest">Make request</a>
                    </div>

                </div>

                <%---------------------------FREE---------------------%>
                <div style="background-color: #fff" class="tab-pane fade" id="pills-free" role="tabpanel"
                     aria-labelledby="pills-free-tab">
                    <%lectures = lecdao.selectNotRequested(currentUser.getId());%>
                    <%if (lectures.size() > 0) {%>
                    <h2>Not requested</h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Event</th>
                            <th scope="col">Lecture</th>
                            <th scope="col">Date and time</th>
                            <th scope="col">Location</th>
                            <th scope="col">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select("id", lecture.getEvent(), "1", 0, "date, fromtime").get(0); %>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=lecture.getTopic()%>
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
                            <td>
                                <a href="OfferController?command=request&id=<%=lecture.getId()%>"><span
                                        class="iconify-inline" data-icon="clarity:success-standard-line"
                                        style="color: #005;" data-width="24"></span></a>
                            </td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2>There aren't any free lectures </h2>
                    <%}%>

                    <%lectures = rdao.selectLecturesFromRequests(currentUser.getId());%>
                    <%if (lectures.size() > 0) {%>
                    <h2>Already requested</h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Event</th>
                            <th scope="col">Lecture</th>
                            <th scope="col">Date and time</th>
                            <th scope="col">Location</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select("id", lecture.getEvent(), "1", 0, "date, fromtime").get(0); %>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=lecture.getTopic()%>
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
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2>You didn't make request on free lectures</h2>
                    <%}%>
                </div>
            </div>
        </div>
        <%
                break;
            case "Users":
                users = udao.selectLimit((int) maxItems, offset);
        %>
        <div class="col distance" style=" background-color: white">
            <%if (users.size() > 0) {%>
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
                        <a href="UserController?upgrade=<%=user.getId()%>"><span class="iconify-inline"
                                                                                 data-icon="grommet-icons:upgrade"
                                                                                 style="color: #005;"
                                                                                 data-width="24"></span></a>
                        <a href="UserController?downgrade=<%=user.getId()%>"><span class="iconify-inline"
                                                                                   data-icon="grommet-icons:upgrade"
                                                                                   style="color: #005;" data-width="24"
                                                                                   data-rotate="180deg"></span></a>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
            <%} else {%>
            <h2>There aren't any users </h2>
            <%}%>
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
                events = edao.select("status", 1, "all", 0, "date, fromtime");
        %>
        <div class="col distance">
            <ul class="nav nav-pills mb-3" id="pills-tab1" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue active" id="pills-events-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-events" type="button" role="tab" aria-controls="pills-home"
                            aria-selected="true">
                        Events
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-free-lectures-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-free-lectures" type="button" role="tab" aria-controls="pills-profile"
                            aria-selected="false">
                        Free lectures
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-requested-lectures-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-requested-lectures" type="button" role="tab"
                            aria-controls="pills-contact" aria-selected="false">
                        Requests
                    </button>
                </li>
            </ul>


            <div class="tab-content" id="pills-tabContent1">
                <!------------------------Events-------------------------------->
                <div style="background-color: #fff" class="tab-pane fade show active" id="pills-events" role="tabpanel"
                     aria-labelledby="pills-events-tab">
                    <%if (events.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Topic</th>
                            <th scope="col">Lectures</th>
                            <th scope="col">Listeners</th>
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
                            <td><%=lecdao.selectCount(event.getId(), 3)%>
                            </td>
                            <td><%=ldao.selectCountOfListeners(event.getId())%>
                            </td>
                            <td><%=event.getDate() %> <br> <%=event.getFromtime() + "-" + event.getTotime()%>
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
                            <td>
                                <a href=""><span class="iconify-inline" data-icon="clarity:note-edit-line"
                                                 style="color: #005;"
                                                 data-width="24"></span></a>
                            </td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2>There aren't any events </h2>
                    <%}%>
                    <div class="rowsa">
                        <div class="distance dropdown">
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
                        <div class="distance">
                            <a class="btn btn-info" href="AddLecture">Add lecture</a>
                        </div>
                        <div class="distance">
                            <a class="btn btn-info" href="AddEvent">Add event</a>
                        </div>
                    </div>
                </div>

                <!------------------------Free lectures-------------------------------->

                <div style="background-color: #fff" class="tab-pane fade" id="pills-free-lectures" role="tabpanel"
                     aria-labelledby="pills-free-lectures-tab">
                    <%lectures = lecdao.selectByStatus(0);%>
                    <%if (lectures.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Event</th>
                            <th scope="col">Lecture</th>
                            <th scope="col">Date and time</th>
                            <th scope="col">Location</th>
                            <th scope="col">Speaker</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select("id", lecture.getEvent(), "1", 0, "date, fromtime").get(0); %>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=lecture.getTopic()%>
                            </td>
                            <td><%=event.getDate() %> <br> <%=event.getFromtime() + "-" + event.getTotime()%>
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
                            <%speakers = rdao.selectSpeakersFromRequests(lecture.getId());%>
                            <td>
                                <form class="rowsb" action="">
                                    <select name="speaker" class="form-control" required>
                                        <option>Select speaker</option>
                                        <%for (User speaker : speakers) {%>
                                        <option value="<%=speaker.getId()%>"><%=speaker.getName() + " " + speaker.getLastname()%>
                                        </option>
                                        <%}%>
                                    </select>
                                    <button class="btn btn-blue active" type="submit"><span
                                            class="iconify-inline" data-icon="clarity:success-standard-line"
                                            style="color: #005;" data-width="24"></span></button>
                                </form>
                            </td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2>There aren't any free lectures </h2>
                    <%}%>
                </div>
                <!------------------------Requests-------------------------------->
                <div style="background-color: #fff" class="tab-pane fade" id="pills-requested-lectures" role="tabpanel"
                     aria-labelledby="pills-requested-lectures-tab">
                    <%lectures = lecdao.selectByStatus(1);%>
                    <%if (lectures.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Event</th>
                            <th scope="col">Speaker</th>
                            <th scope="col">Lecture</th>
                            <th scope="col">Date and time</th>
                            <th scope="col">Location</th>
                            <th scope="col">Action</th>

                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select("id", lecture.getEvent(), "1", 0, "date, fromtime").get(0); %>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=udao.getByID(lecture.getSpeaker()).toString()%>
                            </td>
                            <td><%=lecture.getTopic()%>
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
                            <td class="rowsb">
                                <a href="OfferController?command=acceptRequest&id=<%=lecture.getId()%>"><span
                                        class="iconify-inline" data-icon="clarity:success-standard-line"
                                        style="color: #005;" data-width="24"></span></a>
                                <a href="OfferController?command=rejectRequest&id=<%=lecture.getId()%>"><span
                                        class="iconify-inline" data-icon="carbon:close-outline"
                                        style="color: #005;" data-width="24"></span></a>
                            </td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2>There aren't any requests to give a lecture</h2>
                    <%}%>
                </div>
            </div>
        </div>
        <%
                    break;
            }
        %>
    </div>
</div>
</body>
<jsp:include page="footer.jsp"/>
</html>