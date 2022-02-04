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
    <title>Profile</title>
</head>
<nav class="container-xl navbar sticky-top rowsa">
    <!-- Navbar content -->
    <div>
        <a class="btn btn-grey" href="homepage.jsp">jConference</a>
        <a class="btn btn-info" href="">FAQ</a>
        <a class="btn btn-info" href="events.jsp">Events</a>
    </div>
    <div>
        <form class="d-flex">
            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" style="width: 30rem;">
            <button class="btn btn-outline-info" type="submit">Search</button>
        </form>
    </div>
    <div>
        <%if (request.getSession().getAttribute("user")==null){%>
            <a class="btn btn-info" href="homepage.jsp">Sign up</a>
            <a class="btn btn-info" href="login.jsp">Log in</a>
            <a class="btn btn-blue" href="">RU</a>
        <%}else {%>
            <a class="btn btn-info" href="profile.jsp">Profile</a>
            <a class="btn btn-info" href="logout.jsp">Log out</a>
            <a class="btn btn-blue" href="">RU</a>
        <%}%>
    </div>
</nav>
