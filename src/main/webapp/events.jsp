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
            <form action="Events" method="get">
                <select name="sort" class="form-select" aria-label="Default select example">
                    <option <c:if test="${param.sort.equals('default')}">selected</c:if> value="default">Sort by default</option>
                    <option <c:if test="${param.sort.equals('date')}">selected</c:if> value="date">Date</option>
                    <option <c:if test="${param.sort.equals('listeners')}">selected</c:if> value="listeners">Listeners</option>
                    <option <c:if test="${param.sort.equals('lectures')}">selected</c:if> value="lectures">Lectures</option>
                </select>
                <div class="form-check">
                    <input name="ascending" class="form-check-input" type="checkbox" value="true" id="flexCheckChecked"
                           <c:if test="${param.ascending.equals('true')}">checked</c:if>>
                    <label class="form-check-label" for="flexCheckChecked" >
                        Ascending order
                    </label>
                </div>
                <div class="form-check">
                    <input name="future" class="form-check-input" type="checkbox" value="true" id="flexCheckChecked1"
                           <c:if test="${param.future.equals('true')}">checked</c:if>>
                    <label class="form-check-label" for="flexCheckChecked1">
                        Future events
                    </label>
                </div>
                <div class="form-check">
                    <input name="past" class="form-check-input" type="checkbox" value="true" id="flexCheckChecked2"
                           <c:if test="${param.past.equals('true')}">checked</c:if>>
                    <label class="form-check-label" for="flexCheckChecked2">
                        Past events
                    </label>
                </div>
                <button class="btn btn-info" type="submit">
                    Sort
                </button>
            </form>
        </div>
        <c:forEach var="event" items="${requestScope.events}">
<%--            <c:if test="${event.getLectures().size()>0}">--%>
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
                            <a href="ParticipateController?action=join&event=${event.getId()}" class="link-info">Participate
                                <span class="iconify-inline" data-icon="carbon:user-follow"
                                      data-width="1.1em"></span></a>
                        </p>

                    </div>
                    <div class="card-body text-secondary">
                        <h5 class="card-title">${event.getTopic()}
                        </h5>
                        <p class="card-text">${event.getDescription()}</p>
                        <p>Lectures:</p>
                        <ol>
                            <c:forEach var="lecture" items="${requestScope.lecdao.select(event.getId(),3)}">
                                <li>${lecture.getTopic()} by ${requestScope.udao.getByID(lecture.getSpeaker())}</li>
                            </c:forEach>
                        </ol>
                    </div>
                    <div class="card-footer rows">
                        <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-time-five"
                                                  data-width="1.1em"></span> ${event.getFromtime()}
                            - ${event.getTotime()}
                        </p>
                        <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-calendar"
                                                  data-width="1.1em"></span> ${event.getDate()}
                        </p>
                    </div>
                </div>
<%--            </c:if>--%>
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