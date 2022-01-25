<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.html"/>
<body>

  <section class="container-xl col">
    <!--Login-->
    <div class="margin col reg-sec">
      <h1 class="display-6">Log in</h1>
        <form class="col margin" action="registrartion" method="post">
          <input class="form-control reg" type="Email" placeholder="Email" aria-label="Search" required>
          <input class="form-control reg" type="password" placeholder="Password" aria-label="Search" required>
          <p></p> <button class="btn btn-info" type="submit">Confirm</button>
        </form>
    </div>
  </section>
<jsp:include page="footer.html"/>
</body>
</html>