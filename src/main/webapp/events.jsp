<%@ page import="java.sql.Connection" %>
<%@ page import="com.conference.DBCPool" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message var="title" key="label.button.events" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<body>
<section class="container-xl col">
    <%
        DBCPool pool = (DBCPool) request.getServletContext().getAttribute("pool");
        Connection connection = pool.getConnection();
        request.setAttribute("connection",connection);
    %>
    <div class="margin col">
        <!--Events-->

        <h2 class="display-6 margin"><fmt:message key="label.button.events"/></h2>

        <div class="dropdown">
            <form action="Events" method="get">
                <select name="sort" class="form-select" aria-label="Default select example">
                    <option
                            <c:if test="${param.sort.equals('default')}">selected</c:if> value="default"><fmt:message key="label.events.sort.def"/>
                    </option>
                    <option
                            <c:if test="${param.sort.equals('date')}">selected</c:if> value="date"><fmt:message key="label.events.sort.date"/>
                    </option>
                    <option
                            <c:if test="${param.sort.equals('listeners')}">selected</c:if> value="listeners"><fmt:message key="label.events.sort.listeners"/>
                    </option>
                    <option
                            <c:if test="${param.sort.equals('lectures')}">selected</c:if> value="lectures"><fmt:message key="label.events.sort.lectures"/>
                    </option>
                </select>
                <div class="form-check">
                    <input name="descending" class="form-check-input" type="checkbox" value="true" id="flexCheckChecked"
                           <c:if test="${param.descending.equals('true')}">checked</c:if>>
                    <label class="form-check-label" for="flexCheckChecked">
                        <fmt:message key="label.events.sort.desc"/>
                    </label>
                </div>
                <div class="form-check">
                    <input name="future" class="form-check-input" type="checkbox" value="true" id="flexCheckChecked1"
                           <c:if test="${param.future.equals('true')}">checked</c:if>>
                    <label class="form-check-label" for="flexCheckChecked1">
                        <fmt:message key="label.events.sort.future"/>
                    </label>
                </div>
                <div class="form-check">
                    <input name="past" class="form-check-input" type="checkbox" value="true" id="flexCheckChecked2"
                           <c:if test="${param.past.equals('true')}">checked</c:if>>
                    <label class="form-check-label" for="flexCheckChecked2">
                        <fmt:message key="label.events.sort.past"/>
                    </label>
                </div>
                <button class="btn btn-info" type="submit">
                    <fmt:message key="label.events.sort"/>
                </button>
            </form>
        </div>

        <div class="col distance" style=" background-color: white">
            <c:if test="${requestScope.pages.size()>1}">
                <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                    <c:forEach items="${requestScope.pages}" var="page">
                        <li class="nav-item" role="presentation">
                            <button class="btn btn-blue <c:if test="${(requestScope.pages.indexOf(page)+1)==1}">active</c:if>"
                                    id="pills-${requestScope.pages.indexOf(page)+1}-tab" data-bs-toggle="pill"
                                    data-bs-target="#pills-${requestScope.pages.indexOf(page)+1}" type="button"
                                    role="tab" aria-controls="pills-${requestScope.pages.indexOf(page)+1}"
                                    aria-selected="true"> ${requestScope.pages.indexOf(page)+1}
                            </button>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>

            <div class="tab-content" id="pills-tabContent">
                <c:forEach items="${requestScope.pages}" var="page">
                    <div style="background-color: #fff"
                         class="tab-pane fade show <c:if test="${(requestScope.pages.indexOf(page)+1)==1}">active</c:if>"
                         id="pills-${requestScope.pages.indexOf(page)+1}"
                         role="tabpanel"
                         aria-labelledby="pills-${requestScope.pages.indexOf(page)+1}-tab">
                        <c:forEach var="event" items="${page}">
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
                                        <p style="margin-left: 10px;"> <span class="iconify-inline"
                                                                             data-icon="akar-icons:location"
                                                                             data-width="1.1em"></span>${event.getLocation().getShortName()}
                                        </p>
                                    </c:if>
                                    <p style="margin-left: 10px;">
                                        <a href="ParticipateController?action=join&event=${event.getId()}"
                                           class="link-info">Participate
                                            <span class="iconify-inline" data-icon="carbon:user-follow"
                                                  data-width="1.1em"></span></a>
                                    </p>

                                </div>
                                <div class="card-body text-secondary">
                                    <h5 class="card-title">${event.getTopic()}
                                    </h5>
                                    <p class="card-text">${event.getTags()}</p>
                                    <p>Lectures:</p>
                                    <ol>
                                        <c:forEach var="lecture" items="${requestScope.lecdao.select(connection,event.getId(),3)}">
                                            <li>${lecture.getTopic()}
                                                by ${requestScope.udao.getByID(connection,lecture.getSpeaker())}</li>
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
                    </div>
                </c:forEach>
            </div>

            <c:if test="${requestScope.pages.size()>1}">
                <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                    <c:forEach items="${requestScope.pages}" var="page">
                        <li class="nav-item" role="presentation">
                            <button class="btn btn-blue <c:if test="${(requestScope.pages.indexOf(page)+1)==1}">active</c:if>"
                                    id="pills-${requestScope.pages.indexOf(page)+1}-tab" data-bs-toggle="pill"
                                    data-bs-target="#pills-${requestScope.pages.indexOf(page)+1}" type="button"
                                    role="tab" aria-controls="pills-${requestScope.pages.indexOf(page)+1}"
                                    aria-selected="true"> ${requestScope.pages.indexOf(page)+1}
                            </button>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
    </div>
    <%
        pool.putBackConnection(connection);
    %>
</section>
</body>
<jsp:include page="footer.jsp"/>
</html>