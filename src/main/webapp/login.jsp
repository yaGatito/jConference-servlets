<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<body>

  <section class="container-xl col">
    <!--Login-->
    <div class="margin col reg-sec">
      <h1 class="display-6">Log in</h1>
        <form class="col margin" action="Profile" method="post">
          <input name="email" class="form-control reg" type="text" placeholder="Email" aria-label="Search" required>
          <input name="password" class="form-control reg" type="password" placeholder="Password" aria-label="Search" required>
          <p></p> <button class="btn btn-info" type="submit">Confirm</button>
        </form>
    </div>
  </section>
<jsp:include page="footer.jsp"/>
</body>
</html>