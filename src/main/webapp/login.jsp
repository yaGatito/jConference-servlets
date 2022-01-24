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