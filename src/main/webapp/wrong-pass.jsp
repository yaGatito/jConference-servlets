<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<body>
  <section class="container-xl col">
    <!--Login-->
    <div class="margin col reg-sec" style="width: 50rem">
      <h2 class="display-10">You entered wrong password or email.</h2><h4>Please <a href="login.jsp">log in</a> for establishing access or
      <a href="homepage.jsp">sign up</a> if you have not account yet.</h4>
    </div>
  </section>
<jsp:include page="footer.html"/>
</body>
</html>