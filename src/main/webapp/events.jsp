<%@ page import="com.conference.bean.Event" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<body>
<section class="container-xl col">
    <div class="margin col">
        <!--Events-->

        <h2 class="display-6 margin">Events</h2>

        <div class="dropdown">
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
                        <a href="ParticipateController?action=join&event=${event.getId()}" class="link-info"><span class="iconify-inline" data-icon="carbon:user-follow"
                                                                                                                   data-width="1.1em"></span>Participate</a>
                    </p>

                </div>
                <div class="card-body text-secondary">
                    <h5 class="card-title">${event.getTopic()}
                    </h5>
                    <p class="card-text">${event.getDescription()}</p>
                    <caption>Lectures:</caption>
                    <ol>
                        <c:forEach var="lecture" items="${requestScope.lecdao.select(event.getId(),3)}">
                            <li>${lecture.getTopic()} by ${requestScope.udao.getByID(lecture.getSpeaker())}</li>
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
        <nav aria-label="...">
            <ul class="pagination pagination-sm">
                <li class="page-item active" aria-current="page">
                    <span class="page-link">1</span>
                </li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
            </ul>
        </nav>

    </div>
</section>
<jsp:include page="footer.jsp"/>
</body>
</html>