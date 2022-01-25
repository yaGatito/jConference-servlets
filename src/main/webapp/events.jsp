<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="header.html"/>
<body>
  <section class="container-xl col">
    <div class="margin col">
      <!--Events-->

      <h2 class="display-6 margin">Events</h2>

      <div class="dropdown">
        <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
          Sort events
        </button>
        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
          <li><a class="dropdown-item" href="#">by date</a></li>
          <li><a class="dropdown-item" href="#">by name of speaker</a></li>
          <li><a class="dropdown-item" href="#">by name of events</a></li>
        </ul>
      </div>
      
      <div class="card border-info mb-3" style="width: 35rem;">
        <div class="card-header rowsb">
            <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="bi:person-circle" data-width="1.1em"></span> Uliana Medvedeva</p>
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
            <p style="margin-left: 10px;"><span class="iconify-inline" data-icon="bi:person-circle" data-width="1.1em"></span> Uliana Medvedeva</p>
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

      <nav aria-label="...">
        <ul class="pagination">
          <li class="page-item disabled"><a class="page-link">Previous</a> </li>
          <li class="page-item"><a class="page-link" href="#">1</a></li>
          <li class="page-item active" aria-current="page"><a class="page-link" href="#">2</a></li>
          <li class="page-item"><a class="page-link" href="#">3</a></li>
          <li><a class="page-link" href="#">Next</a></li>
        </ul>
      </nav>

    </div>
  </section>
<jsp:include page="footer.html"/>
</body>
</html>