<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.jsp"/>
<body>
  <section class="container-xl col">
    <!--Add event-->
    <div id="addevent" class="margin col reg-sec">
      <h1 class="display-6">Offer</h1>
        <form id="event-form" class="col margin" action="registrartion" method="post">
          <p class="form-control reg">Math</p>
            <p class="form-control reg">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
        <h4>Date</h4>
          <input name="date" class="form-control reg" type="date" placeholder="" aria-label="Search" min="11/10/2021" required>
          <h4>Time</h4>
          <input name="time" class="form-control reg" type="time" placeholder="" aria-label="Search" required>
          <h4>Address</h4>
          <input name="location" class="form-control reg" type="text" placeholder="" aria-label="Search" required>
          <div class="rad-div">
            <div class="form-check">
              <input value="online" class="form-check-input" type="radio" name="condition" id="flexRadioDefault1" checked>
              <label class="form-check-label" for="flexRadioDefault1">
                Online meeting
              </label>
            </div>
            <div class="form-check">
              <input value="offline" class="form-check-input" type="radio" name="condition" id="flexRadioDefault2">
              <label class="form-check-label" for="flexRadioDefault2">
                Offline meeting
              </label>
            </div>
          </div>
          <p></p> <button class="btn btn-info" type="submit">Confirm</button>
        </form>
    </div>
  </section>
<jsp:include page="footer.html"/>
</body>
</html>