<%@ page import="com.conference.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="com.conference.bean.Event" %>
<%@ page import="com.conference.dao.EventDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  if(request.getSession().getAttribute("user") == null){
    response.sendRedirect("restricted-access.jsp");
  }
%>
<%!List<User> users;%>
<%!List<Event> events;%>
<%!UserDAO udao = new UserDAO();%>
<%!EventDAO edao = new EventDAO();%>
  <!-- Admin profile -->
  <section class="container-xl col">
    <div class="card border-info mb-3" style="width: 50rem;">
      <h2>All users</h2>
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
          users = udao.selectAll();
          for (User user : users) {%>
          <tr>
            <td scope="row"><%=user.getId() %></td>
            <td><%=user.getName() + " " + user.getLastname() %></td>
            <td><%=user.getRole().toString()%></td>
            <td>x v e</td>
          </tr>
        <%}%>
        </tbody>
      </table>
    </div>
  </section>

  <section class="container-xl col">
    <div class="card border-info mb-3" style="width: 50rem;">
      <h2>All events</h2>
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
        <%events = edao.selectByStatus(3);%>
        <%for (Event event : events) {%>
        <tr>
          <th scope="row"><%=event.getId()%></th>
          <td><%=event.getTopic()%></td>
          <td><%=udao.getByID(event.getSpeaker()).toString()%></td>
          <td><%=event.getDate() + " " + event.getFromtime()+"-"+event.getTotime()%></td>
          <%if (event.getCondition()){%>
            <td><a href="<%=event.getLocation().getAddress()%>" target="_blank"><%=event.getLocation().getShortName()%></a></td>
          <%}%>
          <%if (!event.getCondition()){%>
            <td><%=event.getLocation().getShortName()%></td>
          <%}%>
          <td>x v e</td>
        </tr>
        <%}%>
        </tbody>
      </table>
    </div>
    <div class="rowsb">
      <a href="add-event.jsp" class="btn btn-info" style="width: 10rem; margin-right: 10rem">Add new event</a>
    </div>
  </section>