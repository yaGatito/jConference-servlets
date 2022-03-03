<%@ page import="com.conference.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="com.conference.entity.Event" %>
<%@ page import="com.conference.dao.EventDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.conference.DBCPool" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message var="title" key="label.add_lecture" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<%!List<User> speakers;%>
<%!List<Event> events;%>
<%
  DBCPool pool = (DBCPool) config.getServletContext().getAttribute("pool");
  Connection connection = pool.getConnection();
  speakers = new UserDAO().selectSpeakers(connection);
  events = new EventDAO().select(connection,"status",1,"all",0,"date, fromtime");
  pool.putBackConnection(connection);
%>

  <section class="container-xl col">
    <!--Add event-->
    <div class="margin col reg-sec addevent">
      <h1 class="display-6"><fmt:message key="label.add_lecture"/> </h1>
        <form id="event-form" class="col margin" action="${pageContext.request.contextPath}/Service?command=addlecture" method="post">
          <div style="margin-top: 1rem; line-height: 0">
            <h4><fmt:message key="label.button.topic"/> </h4>
            <input name="topic" class="form-control reg" type="text" placeholder="" aria-label="Search" required>
          </div>
          <div style="margin-top: 1rem; line-height: 0">
            <h4><fmt:message key="label.button.event"/> </h4>
            <select name="event" class="form-control reg"  required>
              <%for (Event event : events) {%>
                <option value="<%=event.getId()%>"><%=event.getTopic() + "[" + event.getDate() + "]"%></option>
              <%}%>
            </select>
          </div>
          <div style="margin-top: 1rem; line-height: 0">
            <h4><fmt:message key="label.profile.speaker"/> </h4>
            <select name="speaker" class="form-control reg"  required>
              <option value="0"> <fmt:message key="label.add_lecture.free"/> </option>
              <%for (User speaker : speakers) {%>
              <option value="<%=speaker.getId()%>"><%=speaker.getName() + " " + speaker.getLastname()%></option>
              <%}%>
            </select>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="checkbox" name="offer" id="flexCheckDefault">
            <label class="form-check-label" for="flexCheckDefault">
              <fmt:message key="label.add_lecture.offer"/>
            </label>
          </div>
          <p></p> <button class="btn btn-info" type="submit"> <fmt:message key="label.button.confirm"/> </button>
        </form>
    </div>
  </section>
<%@ include file="footer.jsp"%>
</html>