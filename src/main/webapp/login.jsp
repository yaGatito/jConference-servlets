<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="resources"/>
<fmt:message var="title" key="label.button.login" scope="request"/>
<html lang="${sessionScope.lang}">
<jsp:include page="nav.jsp"/>
<body>

  <section class="container-xl col">
    <!--Login-->
    <div class="margin col reg-sec">
      <h1 class="display-6"> <fmt:message key="label.button.login"/> </h1>
        <form class="col margin" action="Profile" method="post">
          <input name="email" class="form-control reg" type="text" placeholder="<fmt:message key="label.registration.email"/> " aria-label="Search" required>
          <input name="password" class="form-control reg" type="password" placeholder="<fmt:message key="label.registration.password"/> " aria-label="Search" required>
          <p></p> <button class="btn btn-info" type="submit"><fmt:message key="label.button.confirm"/></button>
        </form>
    </div>
  </section>
<jsp:include page="footer.jsp"/>
</body>
</html>