<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message key="label.profile" var="title" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<body>
<div class="d-flex align-items-start container-xl margin" style="width: 80%">
    <div class="nav flex-column nav-pills me-3 coll" id="v-pills-tab" role="tablist" aria-orientation="vertical">
        <a class="btn btn-blue <c:if test="${requestScope.item.equals('profile')}"> active </c:if>"
           href="Profile?item=profile"><fmt:message key="label.button.profile"/>
        </a>
        <a class="btn btn-blue <c:if test="${requestScope.item.equals('participation')}"> active </c:if>"
           href="Profile?item=participation"><fmt:message key="label.button.participation"/>
        </a>
        <c:if test="${sessionScope.user.getRole()==2}">
            <a class="btn btn-blue <c:if test="${requestScope.item.equals('lectures')}"> active </c:if>"
               href="Profile?item=lectures"><fmt:message key="label.button.lectures"/>
            </a>
        </c:if>

        <c:if test="${sessionScope.user.getRole()==1}">
            <a class="btn btn-blue <c:if test="${requestScope.item.equals('users')}"> active </c:if>"
               href="Profile?item=users">
                <fmt:message key="label.button.users"/>
            </a>
            <a class="btn btn-blue <c:if test="${requestScope.item.equals('ecp')}"> active </c:if>"
               href="Profile?item=ecp"><fmt:message key="label.button.ecp"/>
            </a>
        </c:if>
    </div>

    <div class="col">
            <jsp:include page="default-part.jsp"/>
        <c:if test="${sessionScope.user.getRole()==2}">
            <jsp:include page="speaker-part.jsp"/>
        </c:if>
        <c:if test="${sessionScope.user.getRole()==1}">
            <jsp:include page="moder-part.jsp"/>
        </c:if>
    </div>
</div>
</body>
<jsp:include page="footer.jsp"/>
</html>
