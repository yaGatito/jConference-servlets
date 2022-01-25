<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.html"/>
<body>
  <!--Registration-->
  <section class="container-xl col">
    <div class="margin col reg-sec">
      <h1 class="display-6">Welcome! Have not registered yet?</h1>
      <h4 style="width: 30rem;">If you already have one - <a href="" class="link-info">login</a></h4>
        <form class="col margin" action="${pageContext.request.contextPath}/Registration" method="post">
          <input name="name" class="form-control reg" type="text" placeholder="Name" aria-label="Search" required>
          <input name="lastname" class="form-control reg" type="text" placeholder="Lastname" aria-label="Search" required>
          <input name="email" class="form-control reg" type="Email" placeholder="Email" aria-label="Search" required>
          <input name="password" class="form-control reg" type="password" placeholder="Password" aria-label="Search" required>
          <input class="form-control reg" type="password" placeholder="Enter password again" aria-label="Search" required>
          <div class="rad-div">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="role" value="3" id="flexRadioDefault1" checked>
              <label class="form-check-label" for="flexRadioDefault1">
                User
              </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" name="role" value="2" id="flexRadioDefault2">
              <label class="form-check-label" for="flexRadioDefault2">
                Speaker
              </label>
            </div>
          </div>
          <p></p> <button class="btn btn-info" type="submit">Sign up</button>
        </form>
    </div>
    <div class="margin col">
      <!--Events of reg-->

      <h2 class="display-6 margin">Next events</h2>
      
      <div class="card border-info mb-3" style="width: 35rem;">
        <div class="card-header rowsb">
            <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="bi:person-circle" data-width="1.1em"></span> Ilya Lazovskyi</p>
            <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="pepicons:internet" data-width="1.1em"></span> <a class="link-info" href="vk.com">skype.com/asda</a></p>
        </div>
        <div class="card-body text-secondary">
          <h5 class="card-title">English</h5>
          <p class="card-text">Some qu make up the bulk of the card's content.</p>
          <a href="" class="link-info">Join</a>
        </div>
        <div class="card-footer rows">
          <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-time-five" data-width="1.1em"></span> 16:00</p>
          <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-calendar" data-width="1.1em"></span> 12.12.2220</p>
        </div>
      </div>

      <div class="card border-info mb-3" style="max-width: 35rem;">
        <div class="card-header rowsb">
            <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="bi:person-circle" data-width="1.1em"></span> Nikita Lazovskyi</p>
            <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="akar-icons:location" data-width="1.1em"></span> m.Arnautskaya str. 49B</p>
          
        </div>
        <div class="card-body text-secondary">
          <h5 class="card-title">Math</h5>
          <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
          <a href="" class="link-info">Join</a>
        </div>
        <div class="card-footer rows">
          <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-time-five" data-width="1.1em"></span> 17:00</p>
            <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-calendar" data-width="1.1em"></span> 12.12.2220</p>
        </div>
      </div>

      <div class="card border-info mb-3" style="width: 35rem;">
        <div class="card-header rowsb">
            <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="bi:person-circle" data-width="1.1em"></span> Ilya Lazovskyi</p>
            <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="pepicons:internet" data-width="1.1em"></span> <a class="link-info" href="vk.com">skype.com/asda</a></p>
        </div>
        <div class="card-body text-secondary">
          <h5 class="card-title">English</h5>
          <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
          <a href="" class="link-info">Join</a>
        </div>
        <div class="card-footer rows">
          <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-time-five" data-width="1.1em"></span> 16:00</p>
          <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-calendar" data-width="1.1em"></span> 12.12.2220</p>
        </div>
      </div>

      <div class="card border-info mb-3" style="width: 35rem;">
        <div class="card-header rowsb">
            <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="bi:person-circle" data-width="1.1em"></span> Nikita Lazovskyi</p>
            <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="akar-icons:location" data-width="1.1em"></span> m.Arnautskaya str. 49B</p>
          
        </div>
        <div class="card-body text-secondary">
          <h5 class="card-title">Math</h5>
          <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
          <a href="" class="link-info">Join</a>
        </div>
        <div class="card-footer rows">
          <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-time-five" data-width="1.1em"></span> 17:00</p>
          <p class="c-f-item"><span class="iconify-inline" data-icon="bx:bx-calendar" data-width="1.1em"></span> 12.12.2220</p>
        </div>
      </div>

      <div class="col">
        <a href="" class="btn btn-info" style="width: 10rem;">More</a>
      </div>

    </div>
  </section>
<jsp:include page="footer.html"/>
</body>
</html>