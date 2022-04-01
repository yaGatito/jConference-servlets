<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<%@ include file="head.jsp"%>
<nav class="container-xl navbar sticky-top rowsa">
    <div>
        <a class="btn btn-grey" href="Homepage">jConference</a>
        <a class="btn btn-info" href="">FAQ</a>
        <a class="btn btn-info" href="Events"><fmt:message key="label.button.events"/> </a>
    </div>
    <div>
        <form class="d-flex">
            <input class="form-control me-2" type="search" placeholder="<fmt:message key="label.header.search"/>" aria-label="Search" style="width: 30rem;">
            <button class="btn btn-outline-info" type="submit"><fmt:message key="label.header.search"/></button>
        </form>
    </div>
    <div>
        <c:if test="${sessionScope.user==null}">
            <a class="btn btn-info" href="Homepage"><fmt:message key="label.button.signup"/></a>
            <a class="btn btn-info" href="login.jsp"><fmt:message key="label.button.login"/></a>
        </c:if>
        <c:if test="${sessionScope.user!=null}">
            <a class="btn btn-info" href="Profile"><fmt:message key="label.profile"/></a>
            <a class="btn btn-info" href="Controller?command=logout"><fmt:message key="label.button.logout"/></a>
        </c:if>
        <div class="btn dropdown">
            <button class="btn btn-blue dropdown-toggle" type="button" id="dropdownMenuButton2"
                    data-bs-toggle="dropdown" aria-expanded="false">
                    ${sessionScope.lang}

            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
                <c:forEach items="${applicationScope.locales}" var="locale">
                    <li><a class="dropdown-item" href="Controller?command=setlang&lang=${locale}">${locale}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</nav>