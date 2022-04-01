<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message var="title" key="label.update_event" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<body>
<section class="container-xl col">
    <!--Add event-->
    <div class="margin col reg-sec addevent">
        <h1 class="display-6"><fmt:message key="label.update_event"/> </h1>
        <form id="event-form" class="col margin" action="UpdateEvent?id=${requestScope.event.getId()}" method="post">
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.button.topic"/> </h4>
                <input name="topic" class="form-control reg" type="text" value="${requestScope.event.getTopic()}" aria-label="Search" required>
            </div>
            <div class="coll" style="margin-top: 1rem; line-height: 0; align-self: start;" >
                <h4> <fmt:message key="label.add_event.tags"/> </h4>
                <div class="accordion accordion-flush" id="accordionFlushExample">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="flush-headingOne">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                                #
                            </button>
                        </h2>
                        <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                            <div class="accordion-body">
                                <c:forEach items="${requestScope.tags}" var="tag">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="tag${tag.getId()}" id="flexCheckDefault${tag.getId()}" <c:if test="${requestScope.event.getTags().contains(tag)}"> checked </c:if>>
                                        <label class="form-check-label" for="flexCheckDefault${tag.getId()}">
                                            ${tag.getName()}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.date"/> </h4>
                <input name="date" class="form-control reg" type="date" value="${requestScope.event.getDate()}" aria-label="Search" min="${LocalDate.now().toString()}" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.from"/> </h4>
                <input name="fromtime" class="form-control reg" type="time" value="${requestScope.event.getFromtime()}" aria-label="Search" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4> <fmt:message key="label.to"/> </h4>
                <input name="totime" class="form-control reg" type="time" value="${requestScope.event.getTotime()}" aria-label="Search" required>
            </div>
            <div style="margin-top: 1rem; line-height: 0">
                <h4><fmt:message key="label.location"/> </h4>
                <input name="location" class="form-control reg" type="text" value="${requestScope.event.getLocation().getAddress()}" aria-label="Search" required>
            </div>
            <p></p>
            <button class="btn btn-info" type="submit"> <fmt:message key="label.button.confirm"/> </button>
        </form>
    </div>
</section>
</body>
<jsp:include page="footer.jsp"/>
</html>