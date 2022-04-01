<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message key="label.profile" var="title" scope="request"/>
<c:if test="${requestScope.item.equals('lectures')}">
    <div class="col distance" style=" background-color: white">
        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="btn btn-blue active" id="pills-lectures-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-lectures" type="button" role="tab" aria-controls="pills-lectures"
                        aria-selected="true"><fmt:message key="label.button.lectures"/>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="btn btn-blue" id="pills-profile-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile"
                        aria-selected="false"><fmt:message key="label.profile.lectures.offers"/>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="btn btn-blue" id="pills-requests-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-requests" type="button" role="tab" aria-controls="pills-requests"
                        aria-selected="false"><fmt:message key="label.profile.lectures.requests"/>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="btn btn-blue" id="pills-free-tab" data-bs-toggle="pill" data-bs-target="#pills-free"
                        type="button" role="tab" aria-controls="pills-free" aria-selected="false"><fmt:message
                        key="label.profile.lectures.free"/>
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="btn btn-blue" id="pills-history-tab" data-bs-toggle="pill"
                        data-bs-target="#pills-history"
                        type="button" role="tab" aria-controls="pills-history" aria-selected="false"><fmt:message
                        key="label.button.history"/>
                </button>
            </li>
        </ul>
            <%---------------------------SECURED---------------------%>
        <div class="tab-content" id="pills-tabContent">

            <div style="background-color: #fff" class="tab-pane fade show active" id="pills-lectures"
                 role="tabpanel"
                 aria-labelledby="pills-lectures-tab">
                <c:if test="${requestScope.secured.size()>0}">
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.secured}" var="lecture">
                            <tr>
                                <th scope="row">
                                        ${lecture.getId()}
                                </th>
                                <td>
                                        ${lecture.getEvent().getTopic()}
                                </td>
                                <td>
                                        ${lecture.getTopic()}
                                </td>
                                <td>
                                        ${lecture.getEvent().getDate()} ${lecture.getEvent().getFromtime()}-${lecture.getEvent().getTotime()}
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
                <c:if test="${requestScope.secured.size()==0}">
                    <h2><fmt:message key="message.no_lectures"/></h2>
                </c:if>
            </div>
                <%---------------------------OFFERS---------------------%>
            <div style="background-color: #fff" class="tab-pane fade" id="pills-profile" role="tabpanel"
                 aria-labelledby="pills-profile-tab">
                <c:if test="${requestScope.offers.size()>0}">
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                            <th scope="col"><fmt:message key="label.action"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.offers}" var="lecture">
                            <tr>
                                <th scope="row">
                                        ${lecture.getId()}
                                </th>
                                <td>
                                        ${lecture.getEvent().getTopic()}
                                </td>
                                <td>
                                        ${lecture.getTopic()}
                                </td>
                                <td>
                                        ${lecture.getEvent().getDate()} ${lecture.getEvent().getFromtime()}-${lecture.getEvent().getTotime()}
                                </td>
                                <c:if test="${lecture.getEvent().getCondition()}">
                                    <td><a href="${lecture.getEvent().getLocation().getAddress()}"
                                           target="_blank">${lecture.getEvent().getLocation().getShortName()}
                                    </a></td>
                                </c:if>
                                <c:if test="${!lecture.getEvent().getCondition()}">
                                    <td>${lecture.getEvent().getLocation().getShortName()}</td>
                                </c:if>
                                <td>
                                    <a href="Controller?command=accept&id=${lecture.getId()}"><span
                                            class="iconify-inline" data-icon="clarity:success-standard-line"
                                            style="color: #005;" data-width="24"></span></a>
                                    <a href="Controller?command=reject&id=${lecture.getId()}"><span
                                            class="iconify-inline" data-icon="carbon:close-outline"
                                            style="color: #005;" data-width="24"></span></a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${requestScope.offers.size()==0}">
                    <h2><fmt:message key="message.no_offers"/></h2>
                </c:if>
            </div>
                <%---------------------------REQUESTS---------------------%>
            <div style="background-color: #fff" class="tab-pane fade" id="pills-requests" role="tabpanel"
                 aria-labelledby="pills-requests-tab">
                <c:if test="${requestScope.requests.size()>0}">
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.requests}" var="lecture">
                            <tr>
                                <th scope="row">
                                        ${lecture.getId()}
                                </th>
                                <td>
                                        ${lecture.getEvent().getTopic()}
                                </td>
                                <td>
                                        ${lecture.getTopic()}
                                </td>
                                <td>
                                        ${lecture.getEvent().getDate()} ${lecture.getEvent().getFromtime()}-${lecture.getEvent().getTotime()}
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
                <c:if test="${requestScope.requests.size()==0}">
                    <h2><fmt:message key="message.no_request_lectures"/></h2>
                </c:if>
                <div class="distance">
                    <a class="btn btn-info" href="AddRequest"> <fmt:message key="label.add_request"/> </a>
                </div>

            </div>

                <%---------------------------FREE---------------------%>
            <div style="background-color: #fff" class="tab-pane fade" id="pills-free" role="tabpanel"
                 aria-labelledby="pills-free-tab">
                <c:if test="${requestScope.availableFree.size()>0}">
                    <h2><fmt:message key="message.free.no"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                            <th scope="col"><fmt:message key="label.action"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.availableFree}" var="lecture">
                            <tr>
                                <th scope="row">
                                        ${lecture.getId()}
                                </th>
                                <td>
                                        ${lecture.getEvent().getTopic()}
                                </td>
                                <td>
                                        ${lecture.getTopic()}
                                </td>
                                <td>
                                        ${lecture.getEvent().getDate()} ${lecture.getEvent().getFromtime()}-${lecture.getEvent().getTotime()}
                                </td>
                                <c:if test="${lecture.getEvent().getCondition()}">
                                    <td><a href="${lecture.getEvent().getLocation().getAddress()}"
                                           target="_blank">${lecture.getEvent().getLocation().getShortName()}
                                    </a></td>
                                </c:if>
                                <c:if test="${!lecture.getEvent().getCondition()}">
                                    <td>${lecture.getEvent().getLocation().getShortName()}</td>
                                </c:if>
                                <td>
                                    <a href="Controller?command=request&id=${lecture.getId()}"><span
                                            class="iconify-inline" data-icon="clarity:success-standard-line"
                                            style="color: #005;" data-width="24"></span></a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${requestScope.availableFree.size()==0}">
                    <h2><fmt:message key="message.no_available_lectures"/></h2>
                </c:if>

                <c:if test="${requestScope.notAvailableFree.size()>0}">
                    <h2><fmt:message key="message.free.already"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.notAvailableFree}" var="lecture">
                            <tr>
                                <th scope="row">
                                        ${lecture.getId()}
                                </th>
                                <td>
                                        ${lecture.getEvent().getTopic()}
                                </td>
                                <td>
                                        ${lecture.getTopic()}
                                </td>
                                <td>
                                        ${lecture.getEvent().getDate()} ${lecture.getEvent().getFromtime()}-${lecture.getEvent().getTotime()}
                                </td>
                                <c:if test="${lecture.getEvent().getCondition()}">
                                    <td><a href="${lecture.getEvent().getLocation().getAddress()}"
                                           target="_blank">${lecture.getEvent().getLocation().getShortName()}
                                    </a></td>
                                </c:if>
                                <c:if test="${!lecture.getEvent().getCondition()}">
                                    <td>${lecture.getEvent().getLocation().getShortName()}</td>
                                </c:if>
                                <td>
                                    <a href="Controller?command=request&id=${lecture.getId()}"><span
                                            class="iconify-inline" data-icon="clarity:success-standard-line"
                                            style="color: #005;" data-width="24"></span></a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${requestScope.notAvailableFree.size()==0}">
                    <h2><fmt:message key="message.no_request_free_lectures"/></h2>
                </c:if>
            </div>

                <%-----------------HISTORY------------------------------------------------------------%>
            <div style="background-color: #fff" class="tab-pane fade" id="pills-history" role="tabpanel"
                 aria-labelledby="pills-history-tab">
                <c:if test="${requestScope.historyOwn.size()>0}">
                    <h2><fmt:message key="message.history.own.rejected"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.historyOwn}" var="lecture">
                            <tr>
                                <th scope="row">
                                        ${lecture.getId()}
                                </th>
                                <td>
                                        ${lecture.getEvent().getTopic()}
                                </td>
                                <td>
                                        ${lecture.getTopic()}
                                </td>
                                <td>
                                        ${lecture.getEvent().getDate()} ${lecture.getEvent().getFromtime()}-${lecture.getEvent().getTotime()}
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

                <c:if test="${requestScope.historyOwn.size()==0}">
                    <h2><fmt:message key="message.history.own.no"/></h2>
                </c:if>

                <c:if test="${requestScope.historyFree.size()>0}">
                    <h2><fmt:message key="message.history.free.rejected"/></h2>
                    <table class="table table-info table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col"><fmt:message key="label.button.event"/></th>
                            <th scope="col"><fmt:message key="label.lecture"/></th>
                            <th scope="col"><fmt:message key="label.datetime"/></th>
                            <th scope="col"><fmt:message key="label.location"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.historyFree}" var="lecture">
                            <tr>
                                <th scope="row">
                                        ${lecture.getId()}
                                </th>
                                <td>
                                        ${lecture.getEvent().getTopic()}
                                </td>
                                <td>
                                        ${lecture.getTopic()}
                                </td>
                                <td>
                                        ${lecture.getEvent().getDate()} ${lecture.getEvent().getFromtime()}-${lecture.getEvent().getTotime()}
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
                <c:if test="${requestScope.historyFree.size()==0}">
                    <h2><fmt:message key="message.history.free.no"/></h2>
                </c:if>
            </div>
        </div>
    </div>
</c:if>