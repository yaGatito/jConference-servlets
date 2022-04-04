<%@ page import="com.conference.entities.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message key="label.profile" var="title" scope="request"/>
<c:if test="${requestScope.item.equals('users')}">
    <div class="col distance" style=" background-color: white">
        <c:if test="${requestScope.users.size()>0}">
            <table class="table table-info table-striped">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col"><fmt:message key="label.profile.user"/></th>
                    <th scope="col"><fmt:message key="label.profile.role"/></th>
                    <th scope="col"><fmt:message key="label.action"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${requestScope.users}">
                    <tr>
                        <td scope="row">${user.getId()}
                        </td>
                        <td>${user.getName()} ${user.getLastname()}
                        </td>
                        <td>${User.getNameRole(user.getRole())}
                        </td>
                        <td>
                            <a href="Controller?command=upgrade&id=${user.getId()}"><span class="iconify-inline"
                                                                                   data-icon="grommet-icons:upgrade"
                                                                                   style="color: #005;"
                                                                                   data-width="24"></span></a>
                            <a href="Controller?command=downgrade&id=${user.getId()}"><span class="iconify-inline"
                                                                                     data-icon="grommet-icons:upgrade"
                                                                                     style="color: #005;"
                                                                                     data-width="24"
                                                                                     data-rotate="180deg"></span></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${requestScope.users.size()<=0}">
            <h2><fmt:message key="message.no_users"/></h2>
        </c:if>
        <c:if test="${requestScope.amount > 1}">
            <nav aria-label="...">
                <ul class="pagination pagination-sm">
                    <c:forEach begin="1" end="${requestScope.amount}" var="i">
                        <li class="page-item <c:if test="${i==requestScope.offset}">active</c:if>">
                            <a class="page-link" href="Profile?item=users&page=${i}">${i}
                            </a></li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>
</c:if>

<c:if test="${requestScope.item.equals('ecp')}">
    <div class="col distance">
        <ul class="nav nav-pills mb-3" id="pills-tab1" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="btn btn-blue active" id="pills-events-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-events" type="button" role="tab" aria-controls="pills-home"
                        aria-selected="true">
                    <fmt:message key="label.button.events"/>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="btn btn-blue" id="pills-free-lectures-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-free-lectures" type="button" role="tab" aria-controls="pills-profile"
                        aria-selected="false">
                    <fmt:message key="label.profile.ecp.free"/>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="btn btn-blue" id="pills-requested-lectures-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-requested-lectures" type="button" role="tab"
                        aria-controls="pills-contact" aria-selected="false">
                    <fmt:message key="label.profile.ecp.requests"/>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="btn btn-blue" id="pills-history-ecp-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-history-ecp" type="button" role="tab"
                        aria-controls="pills-contact" aria-selected="false">
                    <fmt:message key="label.button.history"/>
                </button>
            </li>
        </ul>


        <div class="tab-content" id="pills-tabContent1">
            <!------------------------Events-------------------------------->
            <div style="background-color: #fff" class="tab-pane fade show active" id="pills-events" role="tabpanel"
                 aria-labelledby="pills-events-tab">
                <c:if test="${requestScope.events.size()>0}">
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.profile.lectures"/></th>
                            <th scope="col"><fmt:message key="label.listeners"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                            <th scope="col"><fmt:message key="label.action"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.events}" var="event">

                            <tr>
                                <th scope="row">${event.getId()}
                                </th>
                                <td>${event.getTopic()}
                                </td>
                                <td>${event.getLectures().size()}
                                </td>
                                <td>${event.getListeners()}
                                </td>
                                <td>${event.getDate()} <br> ${event.getFromtime()} ${event.getTotime()}
                                </td>
                                <c:if test="${event.getCondition()}">
                                    <td><a href="${event.getLocation().getAddress()}"
                                           target="_blank">${event.getLocation().getShortName()}
                                    </a></td>
                                </c:if>
                                <c:if test="${!event.getCondition()}">
                                    <td>${event.getLocation().getShortName()}
                                    </td>
                                </c:if>
                                <td>
                                    <a href="UpdateEvent?id=${event.getId()}"><span class="iconify-inline"
                                                                                    data-icon="clarity:note-edit-line"
                                                                                    style="color: #005;"
                                                                                    data-width="24"></span></a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${requestScope.events.size()<=0}">
                    <h2><fmt:message key="message.no_event"/></h2>
                </c:if>
                <div class="rowsa">
                    <div class="distance">
                        <a class="btn btn-info" href="AddTag"> <fmt:message key="label.add_tag"/> </a>
                    </div>
                    <div class="distance">
                        <a class="btn btn-info" href="UpdateTag"> <fmt:message key="label.update_tag"/>
                            <span class="badge bg-danger">${requestScope.goals}</span>
                        </a>
                    </div>
                    <div class="distance">
                        <a class="btn btn-info" href="AddLecture"> <fmt:message key="label.add_lecture"/> </a>
                    </div>
                    <div class="distance">
                        <a class="btn btn-info" href="AddEvent"><fmt:message key="label.add_event"/> </a>
                    </div>
                </div>
            </div>

            <!------------------------Free lectures-------------------------------->
            <div style="background-color: #fff" class="tab-pane fade" id="pills-free-lectures" role="tabpanel"
                 aria-labelledby="pills-free-lectures-tab">
                <c:if test="${requestScope.lecturesWithApplicants.entrySet().size() > 0}">

                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.profile.lectures"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                            <th scope="col"><fmt:message key="label.profile.speaker"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="entry" items="${requestScope.lecturesWithApplicants.entrySet()}">
                            <tr>
                                <th scope="row">${entry.getKey().getEvent()}
                                </th>
                                <td>${entry.getKey().getEvent().getTopic()}
                                </td>
                                <td>${entry.getKey().getTopic()}
                                </td>
                                <td>${entry.getKey().getEvent().getDate()}
                                    <br> ${entry.getKey().getEvent().getFromtime()}-${entry.getKey().getEvent().getTotime()}
                                </td>
                                <c:if test="${entry.getKey().getEvent().getCondition()}">
                                    <td><a href="${entry.getKey().getEvent().getLocation().getAddress()}"
                                           target="_blank">${entry.getKey().getEvent().getLocation().getShortName()}
                                    </a></td>
                                </c:if>
                                <c:if test="${!entry.getKey().getEvent().getCondition()}">
                                    <td>${entry.getKey().getEvent().getLocation().getShortName()}
                                    </td>
                                </c:if>
                                <td>
                                    <div class="dropdown">
                                        <button class="btn btn-info dropdown-toggle" type="button"
                                                id="dropdownMenuButton3"
                                                data-bs-toggle="dropdown" aria-expanded="false">
                                            <fmt:message key="label.button.select"/>
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton3">
                                            <c:forEach items="${entry.getValue()}" var="speaker">

                                                <li><a class="dropdown-item"
                                                       href="Controller?command=assign&lecture=${entry.getKey().getId()}&speaker=${speaker.getId()}">${speaker.toString()}
                                                </a></li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${requestScope.lecturesWithApplicants.entrySet().size() == 0}">
                    <h2><fmt:message key="message.no_free_lectures"/></h2>
                </c:if>
            </div>
            <!------------------------Requests-------------------------------->
            <div style="background-color: #fff" class="tab-pane fade" id="pills-requested-lectures" role="tabpanel"
                 aria-labelledby="pills-requested-lectures-tab">
                <c:if test="${requestScope.requests.size()>0}">
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.profile.speaker"/></th>
                            <th scope="col"><fmt:message key="label.profile.lectures"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                            <th scope="col"><fmt:message key="label.action"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="lecture" items="${requestScope.requests}">
                            <tr>
                                <th scope="row">${lecture.getEvent()}
                                </th>
                                <td>${lecture.getEvent().getTopic()}
                                </td>
                                <td>${lecture.getSpeaker().toString()}
                                </td>
                                <td>${lecture.getTopic()}
                                </td>
                                <td>${lecture.getEvent().getDate()} ${lecture.getEvent().getFromtime()}-${lecture.getEvent().getTotime()}
                                </td>
                                <c:if test="${requestScope.lecture.getEvent().getCondition()}">

                                    <td><a href="${lecture.getEvent().getLocation().getAddress()}"
                                           target="_blank">${lecture.getEvent().getLocation().getShortName()}
                                    </a></td>
                                </c:if>
                                <c:if test="${!requestScope.lecture.getEvent().getCondition()}">
                                    <td>${lecture.getEvent().getLocation().getShortName()}
                                    </td>
                                </c:if>
                                <td>
                                    <div class="rowsb">
                                        <a href="Controller?command=acceptRequest&id=${lecture.getId()}"><span
                                                class="iconify-inline" data-icon="clarity:success-standard-line"
                                                style="color: #005;" data-width="24"></span></a>
                                        <a href="Controller?command=rejectRequest&id=${lecture.getId()}"><span
                                                class="iconify-inline" data-icon="carbon:close-outline"
                                                style="color: #005;" data-width="24"></span></a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <c:if test="${requestScope.requests.size()==0}">
                    <h2><fmt:message key="message.no_request"/></h2>
                </c:if>
            </div>
                <%-------------------History ------------------------------%>
            <div style="background-color: #fff" class="tab-pane fade" id="pills-history-ecp" role="tabpanel"
                 aria-labelledby="pills-history-ecp-tab">
                <c:if test="${requestScope.rejected.size() > 0}">
                    <h2><fmt:message key="message.ecp.history.rejected"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.profile.speaker"/></th>
                            <th scope="col"><fmt:message key="label.profile.lectures"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.rejected}" var="lecture">

                            <tr>
                                <th scope="row">${lecture.getEvent()}
                                </th>
                                <td>${lecture.getEvent().getTopic()}
                                </td>
                                <td>${lecture.getSpeaker().toString()}
                                </td>
                                <td>${lecture.getTopic()}
                                </td>
                                <td>${lecture.getEvent().getDate()} ${lecture.getEvent().getFromtime()}-${lecture.getEvent().getTotime()}
                                </td>
                                <c:if test="${lecture.getEvent().getCondition()}">
                                    <td><a href="${lecture.getEvent().getLocation().getAddress()}"
                                           target="_blank">${lecture.getEvent().getLocation().getShortName()}
                                    </a></td>
                                </c:if>
                                <c:if test="${!lecture.getEvent().getCondition()}">
                                    <td>${lecture.getEvent().getLocation().getShortName()}</td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${requestScope.rejected.size() == 0}">
                    <h2><fmt:message key="message.ecp.history.rejected.no"/></h2>
                </c:if>

                <c:if test="${requestScope.pending.size()>0}">

                    <h2><fmt:message key="message.ecp.history.pending"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.profile.speaker"/></th>
                            <th scope="col"><fmt:message key="label.profile.lectures"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="lecture" items="${requestScope.pending}">
                            <tr>
                                <th scope="row">${lecture.getEvent()}
                                </th>
                                <td>${lecture.getEvent().getTopic()}
                                </td>
                                <td>${lecture.getSpeaker().toString()}
                                </td>
                                <td>${lecture.getTopic()}
                                </td>
                                <td>${lecture.getEvent().getDate()} ${lecture.getEvent().getFromtime()}-${lecture.getEvent().getTotime()}
                                </td>
                                <c:if test="${lecture.getEvent().getCondition()}">

                                    <td><a href="${lecture.getEvent().getLocation().getAddress()}"
                                           target="_blank">${lecture.getEvent().getLocation().getShortName()}
                                    </a></td>
                                </c:if>
                                <c:if test="${!lecture.getEvent().getCondition()}">
                                    <td>${lecture.getEvent().getLocation().getShortName()}
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <c:if test="${requestScope.pending.size()==0}">
                    <h2><fmt:message key="message.ecp.history.pending.no"/></h2>
                </c:if>
            </div>
        </div>
    </div>
</c:if>