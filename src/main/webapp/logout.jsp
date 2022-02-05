<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<%request.getSession().setAttribute("user",null);%>
<jsp:include page="header.jsp"/>
<body>
  <section class="container-xl col">
    <!--Login-->
    <div class="margin col reg-sec" style="width: 50rem">
      <h2 class="display-10">Successful logged out</h2>
    </div>
  </section>
<jsp:include page="footer.jsp"/>
</body>
</html>