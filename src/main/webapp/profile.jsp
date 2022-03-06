<%@ page import="com.conference.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.entity.Event" %>
<%@ page import="java.util.Optional" %>
<%@ page import="com.conference.entity.Lecture" %>
<%@ page import="com.conference.dao.*" %>
<%@ page import="com.conference.connection.DBCPool" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message key="label.profile" var="title" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<body>
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
DBCPool pool = (DBCPool) config.getServletContext().getAttribute("pool");
Connection connection = pool.getConnection();
  User currentUser = (User) request.getSession().getAttribute("user");
  if (currentUser == null) {
    response.sendRedirect("restricted-access.jsp");
  }

  double maxItems = 5;

  double count = udao.getCount(connection);
  double amount = Math.ceil(count / maxItems);
  int offset;
  try {
    offset = Integer.parseInt(request.getParameter("page"));
    if (offset > amount)
      offset = 1;
  } catch (NumberFormatException | NullPointerException e) {
    offset = 1;
  }

  final String[] buttons = new String[]{"profile", "participation", "lectures", "users", "ecp", "setting"};
  String item = Optional.ofNullable(request.getParameter("item")).orElse(buttons[0]);
  boolean flag = false;
  for (int i = 0; i < buttons.length; i++) {
    if (item.equals(buttons[i])) {
      flag = true;
    }
  }
  if (!flag) item = "profile";
  String locale = (String)request.getSession().getAttribute("lang");

%>
<!-- Admin profile -->

<body>
<div class="d-flex align-items-start container-xl margin" style="width: 80%">
    <div class="nav flex-column nav-pills me-3 coll" id="v-pills-tab" role="tablist" aria-orientation="vertical">
        <a class="btn btn-blue <%= item.equals("profile") ? " active " : ""%>"
           href="Profile?item=profile>"><fmt:message key="label.button.profile"/>
        </a>
        <a class="btn btn-blue <%= item.equals("participation") ? " active " : ""%>"
           href="Profile?item=participation"><fmt:message key="label.button.participation"/>
        </a>
        <a class="btn btn-blue <%= item.equals("lectures") ? " active " : ""%>"
           href="Profile?item=lectures"><fmt:message key="label.button.lectures"/>
        </a>
        <a class="btn btn-blue <%= item.equals("users") ? " active " : ""%>"
           href="Profile?item=users">
            <fmt:message key="label.button.users"/>
            <a class="btn btn-blue <%= item.equals("ecp") ? " active " : ""%>"
               href="Profile?item=ecp"><fmt:message key="label.button.ecp"/>
            </a>
            <a class="btn btn-blue <%= item.equals("settings") ? " active " : ""%>"
               href="Profile?item=setting"><fmt:message key="label.button.setting"/>
            </a>
    </div>
    <%
        switch (item) {
            case "profile":
    %>
    <div class="col">
        <div class="reg-sec distance">
            <form action="UpdateUser" method="post" class="container-xl col" style="margin-top: 3rem;width: 30rem;">
                <div class="input-group distance">
                    <span class="input-group-text"><fmt:message key="label.registration.firstname"/></span>
                    <input type="text" aria-label="Search" class="form-control" name="name"
                           value="<%=currentUser.getName()%>">
                </div>
                <div class="input-group distance">
                    <span class="input-group-text"><fmt:message key="label.registration.lastname"/></span>
                    <input type="text" aria-label="Search" class="form-control" name="lastname"
                           value="<%=currentUser.getLastname()%>">
                </div>
                <div class="input-group distance">
                    <span class="input-group-text"><fmt:message key="label.registration.email"/></span>
                    <input type="text" aria-label="First name" class="form-control" name="email"
                           value="<%=currentUser.getEmail()%>">
                </div>
                <div class="form-check form-switch distance">
                    <input class="form-check-input" type="checkbox" name="notify" role="switch"
                           id="flexSwitchCheckDefault" <%if (currentUser.getNotify()) {%> checked <%}%> >
                    <label class="form-check-label" for="flexSwitchCheckDefault"><fmt:message
                            key="label.profile.email"/></label>
                </div>
                <div class="input-group distance">
                    <button type="submit" class="btn btn-info"><fmt:message key="label.profile.save"/></button>
                </div>
                <div class="input-group distance">
                    <a class="btn btn-info" href=""><fmt:message key="label.profile.changepass"/></a>
                </div>
            </form>
        </div>
        <%
                break;
            case "participation":
                events = ldao.selectEventsOfListeners(connection, currentUser.getId(), locale);
        %>

        <div style="background-color: #fff" class="col distance">
            <%if (events.size() > 0) {%>
            <table class="table table-info table-striped">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col"><fmt:message key="label.button.event"/></th>
                    <th scope="col"><fmt:message key="label.datetime"/></th>
                    <th scope="col"><fmt:message key="label.location"/></th>
                    <th scope="col"><fmt:message key="label.action"/></th>
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
            <h2><fmt:message key="message.no_participation"/></h2>
            <%}%>
        </div>

        <%
                break;
            case "lectures":
        %>
        <div class="col distance" style=" background-color: white">
            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue active" id="pills-lectures-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-lectures" type="button" role="tab" aria-controls="pills-lectures"
                            aria-selected="true"><fmt:message key="label.button.lectures"/>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-profile-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile"
                            aria-selected="false"><fmt:message key="label.profile.lectures.offers"/>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-requests-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-requests" type="button" role="tab" aria-controls="pills-requests"
                            aria-selected="false"><fmt:message key="label.profile.lectures.requests"/>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-free-tab" data-bs-toggle="pill" data-bs-target="#pills-free"
                            type="button" role="tab" aria-controls="pills-free" aria-selected="false"><fmt:message
                            key="label.profile.lectures.free"/>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-history-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-history"
                            type="button" role="tab" aria-controls="pills-history" aria-selected="false"><fmt:message
                            key="label.button.history"/>
                    </button>
                </li>
            </ul>
            <%---------------------------SECURED---------------------%>
            <div class="tab-content" id="pills-tabContent">

                <div style="background-color: #fff" class="tab-pane fade show active" id="pills-lectures"
                     role="tabpanel"
                     aria-labelledby="pills-lectures-tab">
                    <%
                        lectures = lecdao.selectBySpeaker(connection, 3, currentUser.getId());
                    %>

                    <%if (lectures.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getId()%>
                            </th>
                            <% Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
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
                    <h2><fmt:message key="message.no_lectures"/></h2>
                    <%}%>
                </div>
                <%---------------------------OFFERS---------------------%>
                <div style="background-color: #fff" class="tab-pane fade" id="pills-profile" role="tabpanel"
                     aria-labelledby="pills-profile-tab">
                    <%
                        lectures = lecdao.selectBySpeaker(connection, 2, currentUser.getId());
                    %>
                    <%if (lectures.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                            <th scope="col"><fmt:message key="label.action"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getId()%>
                            </th>
                            <%

                                Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
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
                    <h2><fmt:message key="message.no_offers"/></h2>
                    <%}%>
                </div>
                <%---------------------------REQUESTS---------------------%>
                <div style="background-color: #fff" class="tab-pane fade" id="pills-requests" role="tabpanel"
                     aria-labelledby="pills-requests-tab">
                    <%lectures = lecdao.selectBySpeaker(connection, 1, currentUser.getId());%>
                    <%if (lectures.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
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
                    <h2><fmt:message key="message.no_request_lectures"/></h2>
                    <%}%>
                    <div class="distance">
                        <a class="btn btn-info" href="AddRequest"> <fmt:message key="label.add_request"/> </a>
                    </div>

                </div>

                <%---------------------------FREE---------------------%>
                <div style="background-color: #fff" class="tab-pane fade" id="pills-free" role="tabpanel"
                     aria-labelledby="pills-free-tab">
                    <%lectures = lecdao.selectNotRequested(connection, currentUser.getId());%>
                    <%if (lectures.size() > 0) {%>
                    <h2><fmt:message key="message.free.no"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                            <th scope="col"><fmt:message key="label.action"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
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
                    <h2><fmt:message key="message.no_available_lectures"/></h2>
                    <%}%>

                    <%lectures = rdao.selectLecturesFromRequests(connection, currentUser.getId());%>
                    <%if (lectures.size() > 0) {%>
                    <h2><fmt:message key="message.free.already"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
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
                    <h2><fmt:message key="message.no_request_free_lectures"/></h2>
                    <%}%>
                </div>

                <%-----------------HISTORY------------------------------------------------------------%>
                <div style="background-color: #fff" class="tab-pane fade" id="pills-history" role="tabpanel"
                     aria-labelledby="pills-history-tab">
                    <%lectures = rdao.historyOfOwnRequests(connection, currentUser.getId());%>
                    <%if (lectures.size() > 0) {%>
                    <h2><fmt:message key="message.history.own.rejected"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
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
                    <h2><fmt:message key="message.history.own.no"/></h2>
                    <%}%>

                    <%lectures = rdao.historyOfFreeRequests(connection, currentUser.getId());%>
                    <%if (lectures.size() > 0) {%>
                    <h2><fmt:message key="message.history.free.rejected"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
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
                    <h2><fmt:message key="message.history.free.no"/></h2>
                    <%}%>
                </div>
            </div>
        </div>
        <%
                break;
            case "users":
                users = udao.selectLimit(connection, (int) maxItems, offset);
        %>
        <div class="col distance" style=" background-color: white">
            <%if (users.size() > 0) {%>
            <table class="table table-info table-striped">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col"><fmt:message key="label.profile.user"/></th>
                    <th scope="col"><fmt:message key="label.profile.role"/></th>
                    <th scope="col"><fmt:message key="label.action"/></th>
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
            <h2><fmt:message key="message.no_users"/></h2>
            <%}%>
            <%if (amount > 1) {%>
            <nav aria-label="...">
                <ul class="pagination pagination-sm">
                    <%for (int i = 1; i <= amount; i++) {%>
                    <li class="page-item<%= i == offset ? " active" : ""%>"><a class="page-link"
                                                                               href="Profile?item=users&page=<%=i%>"><%=i%>
                    </a></li>
                    <%}%>
                </ul>
            </nav>
            <%}%>
        </div>
        <%
                break;
            case "ecp":
                events = edao.select(connection, "status", 1, "all", 0, "date, fromtime", locale);
        %>
        <div class="col distance">
            <ul class="nav nav-pills mb-3" id="pills-tab1" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue active" id="pills-events-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-events" type="button" role="tab" aria-controls="pills-home"
                            aria-selected="true">
                        <fmt:message key="label.button.events"/>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-free-lectures-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-free-lectures" type="button" role="tab" aria-controls="pills-profile"
                            aria-selected="false">
                        <fmt:message key="label.profile.ecp.free"/>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-requested-lectures-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-requested-lectures" type="button" role="tab"
                            aria-controls="pills-contact" aria-selected="false">
                        <fmt:message key="label.profile.ecp.requests"/>
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="btn btn-blue" id="pills-history-ecp-tab" data-bs-toggle="pill"
                            data-bs-target="#pills-history-ecp" type="button" role="tab"
                            aria-controls="pills-contact" aria-selected="false">
                        <fmt:message key="label.button.history"/>
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
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.profile.lectures"/></th>
                            <th scope="col"><fmt:message key="label.listeners"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                            <th scope="col"><fmt:message key="label.action"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Event event : events) {%>
                        <tr>
                            <th scope="row"><%=event.getId()%>
                            </th>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=lecdao.selectCount(connection, event.getId(), 3)%>
                            </td>
                            <td><%=ldao.selectCountOfListeners(connection, event.getId())%>
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
                                <a href="UpdateEvent?id=<%=event.getId()%>"><span class="iconify-inline" data-icon="clarity:note-edit-line"
                                                 style="color: #005;"
                                                 data-width="24"></span></a>
                            </td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2><fmt:message key="message.no_event"/></h2>
                    <%}%>
                    <div class="rowsa">
                        <%--                        <div class="distance dropdown">--%>
                        <%--                            <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton2"--%>
                        <%--                                    data-bs-toggle="dropdown" aria-expanded="false">--%>
                        <%--                                Sort events--%>
                        <%--                            </button>--%>
                        <%--                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">--%>
                        <%--                                <li><a class="dropdown-item" href="#">by date</a></li>--%>
                        <%--                                <li><a class="dropdown-item" href="#">by name of speaker</a></li>--%>
                        <%--                                <li><a class="dropdown-item" href="#">by name of events</a></li>--%>
                        <%--                            </ul>--%>
                        <%--                        </div>--%>
                        <div class="distance">
                            <a class="btn btn-info" href="AddTag"> <fmt:message key="label.add_tag"/> </a>
                        </div>
                        <div class="distance">
                            <a class="btn btn-info" href="UpdateTag"> <fmt:message key="label.update_tag"/>
                                <span class="badge bg-danger">${requestScope.goals}</span>
                            </a>
                        </div>
                        <div class="distance">
                            <a class="btn btn-info" href="AddLecture"> <fmt:message key="label.add_lecture"/> </a>
                        </div>
                        <div class="distance">
                            <a class="btn btn-info" href="AddEvent"><fmt:message key="label.add_event"/> </a>
                        </div>
                    </div>
                </div>

                <!------------------------Free lectures-------------------------------->
                <div style="background-color: #fff" class="tab-pane fade" id="pills-free-lectures" role="tabpanel"
                     aria-labelledby="pills-free-lectures-tab">
                    <%lectures = lecdao.selectByStatus(connection, 0);%>
                    <%if (lectures.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.profile.lectures"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                            <th scope="col"><fmt:message key="label.profile.speaker"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
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
                            <%speakers = rdao.selectSpeakersFromRequests(connection, lecture.getId());%>
                            <td>
                                <div class="dropdown">
                                    <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton3"
                                            data-bs-toggle="dropdown" aria-expanded="false">
                                        <fmt:message key="label.button.select"/>
                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton3">
                                        <%for (User speaker : speakers) {%>
                                        <li><a class="dropdown-item"
                                               href="OfferController?command=assign&lecture=<%=lecture.getId()%>&speaker=<%=speaker.getId()%>"><%=speaker.toString()%>
                                        </a></li>
                                        <%}%>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2><fmt:message key="message.no_free_lectures"/></h2>
                    <%}%>
                </div>
                <!------------------------Requests-------------------------------->
                <div style="background-color: #fff" class="tab-pane fade" id="pills-requested-lectures" role="tabpanel"
                     aria-labelledby="pills-requested-lectures-tab">
                    <%lectures = lecdao.selectByStatus(connection, 1);%>
                    <%if (lectures.size() > 0) {%>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.profile.speaker"/></th>
                            <th scope="col"><fmt:message key="label.profile.lectures"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                            <th scope="col"><fmt:message key="label.action"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=udao.getByID(connection, lecture.getSpeaker()).toString()%>
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
                                <div class="rowsb">
                                    <a href="OfferController?command=acceptRequest&id=<%=lecture.getId()%>"><span
                                            class="iconify-inline" data-icon="clarity:success-standard-line"
                                            style="color: #005;" data-width="24"></span></a>
                                    <a href="OfferController?command=rejectRequest&id=<%=lecture.getId()%>"><span
                                            class="iconify-inline" data-icon="carbon:close-outline"
                                            style="color: #005;" data-width="24"></span></a>
                                </div>
                            </td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                    <%} else {%>
                    <h2><fmt:message key="message.no_request"/></h2>
                    <%}%>
                </div>
                <%-------------------History ------------------------------%>
                <div style="background-color: #fff" class="tab-pane fade" id="pills-history-ecp" role="tabpanel"
                     aria-labelledby="pills-history-ecp-tab">
                    <%lectures = lecdao.selectByStatus(connection, -1);%>
                    <%if (lectures.size() > 0) {%>
                    <h2><fmt:message key="message.ecp.history.rejected"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.profile.speaker"/></th>
                            <th scope="col"><fmt:message key="label.profile.lectures"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=udao.getByID(connection, lecture.getSpeaker()).toString()%>
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
                    <h2><fmt:message key="message.ecp.history.rejected.no"/></h2>
                    <%}%>

                    <%lectures = lecdao.selectByStatus(connection, 2);%>
                    <%if (lectures.size() > 0) {%>
                    <h2><fmt:message key="message.ecp.history.pending"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.profile.speaker"/></th>
                            <th scope="col"><fmt:message key="label.profile.lectures"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for (Lecture lecture : lectures) {%>
                        <tr>
                            <th scope="row"><%=lecture.getEvent()%>
                            </th>
                            <% Event event = edao.select(connection, "id", lecture.getEvent(), "1", 0, "date, fromtime", locale).get(0); %>
                            <td><%=event.getTopic()%>
                            </td>
                            <td><%=udao.getByID(connection, lecture.getSpeaker()).toString()%>
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
                    <h2><fmt:message key="message.ecp.history.pending.no"/></h2>
                    <%}%>
                </div>
            </div>
        </div>
        <%
                    pool.putBackConnection(connection);
                    break;
            }

        %>
    </div>
</div>
</body>
<jsp:include page="footer.jsp"/>
</html>