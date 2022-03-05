<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message var="title" key="label.update_tag" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<body>
<section class="container-xl col">
    <!--Update tag-->
    <div class="margin col reg-sec addevent">
        <c:set var="goals" value="${requestScope.goals.entrySet()}"/>
        <c:if test="${requestScope.goals.entrySet().isEmpty()}">
            <h2>There aren't any tags that need update</h2>
        </c:if>
        <c:if test="${!requestScope.goals.entrySet().isEmpty()}">
            <h2 class="display-6"><fmt:message key="label.update_tag"/></h2>
            <form id="event-form" class="col margin" action="UpdateTag" method="post">
                <c:forEach items="${requestScope.goals.entrySet()}" var="goal">
                    <h2>${goal.getKey().getName()}</h2>
                    <c:forEach items="${goal.getValue().entrySet()}" var="locale">
                        <div class="input-group">
                            <span class="input-group-text"> ${locale.getValue()} </span>
                            <input type="text" name="${locale.getKey()}Tag${goal.getKey().getId()}" aria-label="Search"
                                   class="form-control">
                        </div>
                    </c:forEach>
                </c:forEach>
                <br/>
                <button class="btn btn-info" type="submit"><fmt:message key="label.button.confirm"/></button>
            </form>
        </c:if>
    </div>
</section>

<jsp:include page="footer.jsp"/>
</body>
</html>