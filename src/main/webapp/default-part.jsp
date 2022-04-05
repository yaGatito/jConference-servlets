<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message key="label.profile" var="title" scope="request"/>
<c:if test="${requestScope.item.equals('profile')}">
    <div class="reg-sec distance">
        <form action="UpdateUser" method="post" class="container-xl col" style="margin-top: 3rem;width: 30rem;">
            <div class="input-group distance">
                <span class="input-group-text"><fmt:message key="label.registration.firstname"/></span>
                <input type="text" aria-label="Search" class="form-control" name="name"
                       value="${sessionScope.user.getName()}">
            </div>
            <div class="input-group distance">
                <span class="input-group-text"><fmt:message key="label.registration.lastname"/></span>
                <input type="text" aria-label="Search" class="form-control" name="lastname"
                       value="${sessionScope.user.getLastname()}">
            </div>
            <div class="input-group distance">
                <span class="input-group-text"><fmt:message key="label.registration.email"/></span>
                <input type="email" aria-label="First name" class="form-control" name="email"
                       value="${sessionScope.user.getEmail()}">
            </div>
            <div class="form-check form-switch distance">
                <input class="form-check-input" type="checkbox" name="notify" role="switch"
                       id="flexSwitchCheckDefault" <c:if test="${sessionScope.user.getNotify()}"> checked </c:if>>
                <label class="form-check-label" for="flexSwitchCheckDefault"><fmt:message
                        key="label.profile.email"/></label>
            </div>
            <div class="input-group distance">
                <button type="submit" class="btn btn-info"><fmt:message key="label.profile.save"/></button>
            </div>
        </form>
    </div>
</c:if>
<c:if test="${requestScope.item.equals('participation')}">
    <div style="background-color: #fff" class="col distance">
        <c:if test="${requestScope.participation.size()>0}">
            <table class="table table-info table-striped">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col"><fmt:message key="label.button.event"/></th>
                    <th scope="col"><fmt:message key="label.datetime"/></th>
                    <th scope="col"><fmt:message key="label.location"/></th>
                    <th scope="col"><fmt:message key="label.action"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="event" items="${requestScope.participation}">
                    <tr>
                        <th scope="row">${event.getId()}
                        </th>
                        <td>${event.getTopic()}
                        </td>
                        <td>${event.getDate()} ${event.getFromtime()}-${event.getTotime()}</td>
                        <c:if test="${event.getCondition()}">
                            <td>
                                <a href="${event.getLocation().getAddress()}"
                                   target="_blank">${event.getLocation().getShortName()}
                                </a>
                            </td>
                        </c:if>
                        <c:if test="${!event.getCondition()}">
                            <td>${event.getLocation().getShortName()}
                            </td>
                        </c:if>
                        <td>
                            <a href="Controller?command=leave&event=${event.getId()}"><span
                                    class="iconify-inline" data-icon="feather:x-square" style="color: #005;"
                                    data-width="24"></span></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${requestScope.participation.size()<=0}">
            <h2><fmt:message key="message.no_participation"/></h2>
        </c:if>
    </div>
</c:if>