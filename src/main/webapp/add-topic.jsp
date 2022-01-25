<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<body>
  <section class="container-xl col">
    <!--Add event-->
    <div id="addevent" class="margin col reg-sec">
      <h1 class="display-6">Add topic</h1>
        <form id="event-form" class="col margin" action="registrartion" method="post">
          <h4>Topic</h4>
          <input name="topic" class="form-control reg" type="text" placeholder="" aria-label="Search" required>
          <h4>Description</h4>
          <textarea class="form-control reg" rows="4" cols="50" name="description" form="event-form"></textarea>
          <p></p> <button class="btn btn-info" type="submit">Confirm</button>
        </form>
    </div>
  </section>
<jsp:include page="footer.html"/>
</body>
</html>