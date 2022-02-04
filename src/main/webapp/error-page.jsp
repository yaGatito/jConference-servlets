<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<body>
  <section class="container-xl col">
    <!--Login-->
    <div class="margin col reg-sec" style="width: 50rem">
      <h2 class="display-10">Error.</h2>
      <h4><%=request.getParameter("message")%></h4>
    </div>
  </section>
<jsp:include page="footer.html"/>
</body>
</html>