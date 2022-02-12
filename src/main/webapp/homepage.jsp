<%@ page import="com.conference.bean.Event" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>

<body>
<!--Registration-->
<section class="container-xl col">
    <c:if test="${sessionScope.user == null}">
        <div class="margin col reg-sec">
            <h1 class="display-6">Welcome! Have not registered yet?</h1>
            <h4 style="width: 30rem;">If you already have one - <a href="login.jsp" class="link-info">login</a></h4>
            <form class="col margin" action="${pageContext.request.contextPath}/Registration" method="post">
                <input name="name" class="form-control reg" type="text" placeholder="Name" aria-label="Search" required>
                <input name="lastname" class="form-control reg" type="text" placeholder="Lastname" aria-label="Search"
                       required>
                <input name="email" class="form-control reg" type="Email" placeholder="Email" aria-label="Search"
                       required>
                <input name="password" class="form-control reg" type="password" placeholder="Password"
                       aria-label="Search" required>
                <input class="form-control reg" type="password" placeholder="Enter password again" aria-label="Search"
                       required>
                <p></p>
                <button class="btn btn-info" type="submit">Sign up</button>
            </form>
        </div>
    </c:if>
    <div class="margin col">
        <!--Events-->

        <h2 class="display-6 margin">Next events</h2>
        <c:forEach var="event" items="${requestScope.events}">
        <div class="card border-info mb-3" style="width: 50rem;">
            <div class="card-header rowsb">
                <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="bi:person-circle"
                                                    data-width="1.1em"></span> <c:out value="${requestScope.udao.getByID(event.getSpeaker())}"/>
                </p>

                <c:if test="${event.getCondition()}">
                    <p style="margin-left: 10px;"> <span class="iconify-inline"
                                                         data-icon="pepicons:internet"
                                                         data-width="1.1em"></span>
                        <a class="link-info"
                           href="${event.getLocation().getAddress()}"><c:out value="${event.getLocation().getShortName()}"/>
                        </a></p>
                </c:if>

                <c:if test="${!event.getCondition()}">
                    <p style="margin-left: 10px;"> <span class="iconify-inline" data-icon="akar-icons:location"
                                                         data-width="1.1em"></span><c:out value="${event.getLocation().getShortName()}"/>
                    </p>
                </c:if>
            </div>
            <div class="card-body text-secondary">
                <h5 class="card-title"><c:out value="${event.getTopic()}"/>
                </h5>
                <p class="card-text"><c:out value="${event.getDescription()}"/></p>
                <a href="ParticipateController?action=join&event=${event.getId()}" class="link-info">Participate</a>
            </div>
            <div class="card-footer rows">
                <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-time-five"
                                          data-width="1.1em"></span> <c:out value="${event.getFromtime()} - ${event.getTotime()}"/>
                </p>
                <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-calendar"
                                          data-width="1.1em"></span> <c:out value="${event.getDate()}"/>
                </p>
            </div>
        </div>
        </c:forEach>
        <div>
            <a class="btn btn-info" href="Events">More</a>
        </div>
</section>
</body>
<jsp:include page="footer.jsp"/>
</html>