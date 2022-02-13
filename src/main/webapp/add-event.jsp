<%@ page import="com.conference.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<%!List<User> speakers;%>
<%speakers = new UserDAO().selectSpeakers();%>
<body>
<section class="container-xl col">
    <!--Add event-->
    <div class="margin col reg-sec addevent">
        <h1 class="display-6">Create event</h1>
        <form id="event-form" class="col margin" action="${pageContext.request.contextPath}/AddEvent" method="post">
            <div style="margin-top: 1rem; line-height: 0">
                <h4>Topic</h4>
                <input name="topic" class="form-control reg" type="text" placeholder="" aria-label="Search" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4>Description</h4>
                <textarea name="description" class="form-control reg" rows="4" cols="50" form="event-form"
                          required></textarea>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4>Speaker</h4>
                <select name="speaker" class="form-control reg" required>
                    <%for (User speaker : speakers) {%>
                    <option value="<%=speaker.getId()%>"><%=speaker.getName() + " " + speaker.getLastname()%>
                    </option>
                    <%}%>
                </select>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4>Date</h4>
                <input name="date" class="form-control reg" type="date" placeholder="" aria-label="Search" min="<%=LocalDate.now().toString()%>" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4>From</h4>
                <input name="fromtime" class="form-control reg" type="time" placeholder="" aria-label="Search" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4>To</h4>
                <input name="totime" class="form-control reg" type="time" placeholder="" aria-label="Search" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4>Address</h4>
                <input name="location" class="form-control reg" type="text" placeholder="" aria-label="Search" required>
            </div>
            <p></p>
            <button class="btn btn-info" type="submit">Confirm</button>
        </form>
    </div>
</section>

<!--Footer-->
<section class="container-xl rowsb">
    <div id="reg-sec" class="margin col">
        All rights reserved
    </div>
</section>

<jsp:include page="footer.jsp"/>
</body>
</html>