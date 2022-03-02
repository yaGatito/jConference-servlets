<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message key="label.title.main" var="title" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<body>
<!--Registration-->
<section class="container-xl col">
    <c:if test="${sessionScope.user == null}">
        <div class="margin col reg-sec">
            <h1 class="display-6"> <fmt:message key="message.welcome"/> </h1>
            <h4 style="width: 30rem;"><fmt:message key="message.welcome.cap"/> - <a href="login.jsp" class="link-info"> <fmt:message key="label.button.login"/> </a></h4>
            <form class="col margin" action="Homepage" method="post">
                <input name="name" class="form-control reg" type="text" placeholder="<fmt:message key="label.registration.firstname"/>" aria-label="Search" required>
                <input name="lastname" class="form-control reg" type="text" placeholder="<fmt:message key="label.registration.lastname"/>" aria-label="Search"
                       required>
                <input name="email" class="form-control reg" type="Email" placeholder="<fmt:message key="label.registration.email"/>" aria-label="Search"
                       required>
                <input name="password" class="form-control reg" type="password" placeholder="<fmt:message key="label.registration.password"/>"
                       aria-label="Search" required>
                <input class="form-control reg" type="password" placeholder="<fmt:message key="label.registration.password.again"/>" aria-label="Search"
                       required>
                <p></p>
                <button class="btn btn-info" type="submit"><fmt:message key="label.button.signup"/> </button>
            </form>
        </div>
    </c:if>

    <div class="margin col">
        <h2 class="display-6 margin"><fmt:message key="label.button.events"/></h2>
        <c:forEach var="event" items="${requestScope.events}">
            <div class="card border-info mb-3" style="width: 40rem;">
                <div class="card-header rowsb">
                    <c:if test="${event.getCondition()}">
                        <p style="margin-left: 10px;"> <span class="iconify-inline"
                                                             data-icon="pepicons:internet"
                                                             data-width="1.1em"></span>
                            <a class="link-info"
                               href="${event.getLocation().getAddress()}">${event.getLocation().getShortName()}
                            </a>
                        </p>
                    </c:if>

                    <c:if test="${!event.getCondition()}">
                        <p style="margin-left: 10px;"> <span class="iconify-inline" data-icon="akar-icons:location"
                                                             data-width="1.1em"></span>${event.getLocation().getShortName()}
                        </p>
                    </c:if>
                    <p style="margin-left: 10px;">
                        <a href="ParticipateController?action=join&event=${event.getId()}" class="link-info"> <fmt:message key="label.button.participate"/> <span class="iconify-inline" data-icon="carbon:user-follow"
                                                                                                                               data-width="1.1em"></span></a>
                    </p>

                </div>
                <div class="card-body text-secondary">
                    <h5 class="card-title">${event.getTopic()}
                    </h5>
                    <p class="card-text">${event.getDescription()}</p>
                    <caption><fmt:message key="label.button.lectures"/>: </caption>
                    <ol>
                        <c:forEach var="lecture" items="${requestScope.lecdao.select(event.getId(),3)}">
                            <li>${lecture.getTopic()} <fmt:message key="label.events.by"/> ${requestScope.udao.getByID(lecture.getSpeaker())}</li>
                        </c:forEach>
                    </ol>
                </div>
                <div class="card-footer rows">
                    <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-time-five"
                                              data-width="1.1em"></span> ${event.getFromtime()} - ${event.getTotime()}
                    </p>
                    <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-calendar"
                                              data-width="1.1em"></span> ${event.getDate()}
                    </p>
                </div>
            </div>
        </c:forEach>
    </div>
</section>
</body>
<jsp:include page="footer.jsp"/>
</html>
