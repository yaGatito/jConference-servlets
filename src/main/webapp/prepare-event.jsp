<%@ page import="com.conference.bean.Event" %>
<%@ page import="com.conference.dao.EventDAO" %>
<%@ page import="com.conference.util.SELECT" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<%
  int event_id = Integer.parseInt(request.getParameter("event"));
  Event event = new EventDAO().select("id",event_id,"all",0,"date, fromtime").get(0);
  boolean prepared = event.getStatus() > 1;
  request.getSession().setAttribute("event",event);
%>
<body>
  <section class="container-xl col">
    <div id="addevent" class="margin col reg-sec">
      <h1 class="display-6">Offer</h1>
        <form id="event-form" class="col margin" action="${pageContext.request.contextPath}/EventController?action=update&event=<%=event_id%>" method="post">
          <div style="margin-top: 1rem; line-height: 0">
            <h4>Topic</h4>
            <p class="form-control reg"><%=event.getTopic()%></p>
          </div>
          <div style="margin-top: 1rem; line-height: 0">
            <h4>Description</h4>
            <p class="form-control reg"><%=event.getDescription()%></p>
          </div>
          <div style="margin-top: 1rem; line-height: 0">
            <h4>Date</h4>
            <input name="date" class="form-control reg" type="date" placeholder="" aria-label="Search" required <%if(prepared){%> value="<%=event.getDate()%>" <%}%> >
          </div>
          <div style="margin-top: 1rem; line-height: 0">
            <h4>From</h4>
            <input name="fromtime" class="form-control reg" type="time" placeholder="" aria-label="Search" required <%if(prepared){%> value="<%=event.getFromtime()%>" <%}%>>
          </div>
          <div style="margin-top: 1rem; line-height: 0">
            <h4>To</h4>
            <input name="totime" class="form-control reg" type="time" placeholder="" aria-label="Search" required <%if(prepared){%> value="<%=event.getTotime()%>" <%}%>>
          </div>
          <div style="margin-top: 1rem; line-height: 0">
            <h4>Address</h4>
            <input name="location" class="form-control reg" type="text" placeholder="" aria-label="Search" required <%if(prepared){%> value="<%=event.getLocation().getAddress()%>" <%}%>>
          </div>
          <p></p> <button class="btn btn-info" type="submit">Confirm</button>
        </form>
    </div>
  </section>
<jsp:include page="footer.jsp"/>
</body>
</html>