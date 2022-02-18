<%@ page import="com.conference.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="com.conference.bean.Event" %>
<%@ page import="com.conference.dao.EventDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<%!List<User> speakers;%>
<%!List<Event> events;%>
<%speakers = new UserDAO().selectSpeakers();%>
<%events = new EventDAO().select("status",1,"all",0,"date, fromtime");%>

  <section class="container-xl col">
    <!--Add event-->
    <div class="margin col reg-sec addevent">
      <h1 class="display-6">Create topic</h1>
        <form id="event-form" class="col margin" action="${pageContext.request.contextPath}/Service?command=addlecture" method="post">
          <div style="margin-top: 1rem; line-height: 0">
            <h4>Topic</h4>
            <input name="topic" class="form-control reg" type="text" placeholder="" aria-label="Search" required>
          </div>
          <div style="margin-top: 1rem; line-height: 0">
            <h4>Event</h4>
            <select name="event" class="form-control reg"  required>
              <%for (Event event : events) {%>
                <option value="<%=event.getId()%>"><%=event.getTopic() + "[" + event.getDate() + "]"%></option>
              <%}%>
            </select>
          </div>
          <div style="margin-top: 1rem; line-height: 0">
            <h4>Speaker</h4>
            <select name="speaker" class="form-control reg"  required>
              <option value="0">Free to choose</option>
              <%for (User speaker : speakers) {%>
              <option value="<%=speaker.getId()%>"><%=speaker.getName() + " " + speaker.getLastname()%></option>
              <%}%>
            </select>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="checkbox" name="offer" id="flexCheckDefault">
            <label class="form-check-label" for="flexCheckDefault">
              As offer
            </label>
          </div>
          <p></p> <button class="btn btn-info" type="submit">Confirm</button>
        </form>
    </div>
  </section>

  <!--Footer-->
  <section class="container-xl rowsb">
    <div id="reg-sec" class="margin col">
      All rights reserved 
    </div>
  </section>


    <script src="https://code.iconify.design/2/2.1.1/iconify.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>