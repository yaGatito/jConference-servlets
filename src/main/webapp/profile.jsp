<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- font-family: 'Poiret One', cursive; -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poiret+One&display=swap" rel="stylesheet">
    <!-- font-family: 'Nixie One', cursive; -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nixie+One&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="styles.css">
    <title>jConf</title>
</head>
<body>
  <nav class="container-xl navbar sticky-top rowsa">
    <!-- Navbar content -->
    <div>
      <a class="btn btn-grey" href="">jConference</a>
      <a class="btn btn-info" href="">FAQ</a>
      <a class="btn btn-info" href="">Events</a>
    </div>
    <div>
      <form class="d-flex">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" style="width: 30rem;">
        <button class="btn btn-outline-info" type="submit">Search</button>
      </form>
    </div>
    <div>
      <a class="btn btn-info" href="">Profile</a>
      <a class="btn btn-blue" href="">RU</a>
    </div>
  </nav>

  <!--Speaker profile-->
  <section class="container-xl col">
    <div class="card border-info mb-3" style="max-width: 50rem;">
      <div class="card-header rowsb">
          <h2 style="margin-left: 10px;">We are looking for speakers for next topics:</h2>
      </div>
      <div class="card-body text-secondary">
        <div class="card border-info mb-3" style="width: 35rem;">
          <div class="card-body text-secondary">
            <h5 class="card-title">English</h5>
            <p class="card-text">Some qu make up the bulk of the card's content.</p>
            <a href="" class="link-info">Offer<span class="iconify-inline" data-icon="ic:outline-local-offer"></span></a>
          </div>
        </div>

        <div class="card border-info mb-3" style="width: 35rem;">
          <div class="card-body text-secondary">
            <h5 class="card-title">Math</h5>
            <p class="card-text">Some qu make up the bulk of the card's content. Some qu make up the bulk of the card's content.</p>
            <a href="" class="link-info">Offer<span class="iconify-inline" data-icon="ic:outline-local-offer"></span></a>
          </div>
        </div>

        <div class="col">
          <a href="" class="btn btn-info" style="width: 10rem;">More</a>
        </div>
      </div>
    </div>

    <div class="card border-info mb-3" style="max-width: 50rem;">
      <div class="card-header rowsb">
          <h2 style="margin-left: 10px;">You have to hold next conferences: </h2>
      </div>
      <div class="card-body text-secondary">

        <div class="card border-info mb-3" style="width: 35rem;">
          <div class="card-header rowsb">
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

      </div>
    </div>
  </section>

  <!--Footer-->
  <section class="container-xl rowsb">
    <div id="reg-sec" class="margin col">
      All rights reserved 
    </div>
  </section>


    <script src="https://code.iconify.design/2/2.1.1/iconify.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>