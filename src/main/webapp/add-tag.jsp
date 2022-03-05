<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message var="title" key="label.add_tag" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<body>
<section class="container-xl col">
    <!--Add tag-->
    <div class="margin col reg-sec addevent">
        <h1 class="display-6"><fmt:message key="label.add_tag"/> </h1>
        <form id="event-form" class="col margin" action="AddTag" method="post">
            <c:forEach items="${requestScope.languages.entrySet()}" var="language">
                <h2>${language.getValue()}</h2> <input name="${language.getKey()}" class="form-control reg" type="text" placeholder="" aria-label="Search" required>
            </c:forEach>
            <br/>
            <button class="btn btn-info" type="submit"> <fmt:message key="label.button.confirm"/> </button>
        </form>
    </div>
</section>


<jsp:include page="footer.jsp"/>
</body>
</html>