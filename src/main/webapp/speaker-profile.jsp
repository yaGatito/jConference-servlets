<%@ page import="com.conference.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.conference.dao.UserDAO" %>
<%@ page import="com.conference.bean.Event" %>
<%@ page import="com.conference.dao.EventDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  if(request.getSession().getAttribute("user") == null){
    response.sendRedirect("restricted-access.jsp");
  }
%>
<%!List<User> users;%>
<%!List<Event> events;%>
<%!UserDAO udao = new UserDAO();%>
<%!EventDAO edao = new EventDAO();%>
  <!--Speaker profile-->
  <section class="container-xl col">
    <div class="card border-info mb-3" style="max-width: 50rem;">
      <div class="card-header rowsb">
          <h2 style="margin-left: 10px;">We are looking for speakers for next topics:</h2>
      </div>
      <div class="card-body text-secondary">
        <%
          events = edao.selectByStatus(1);
          for (Event event : events){%>
          <div class="card border-info mb-3" style="width: 35rem;">
            <div class="card-body text-secondary">
              <h5 class="card-title"><%=event.getTopic()%></h5>
              <p class="card-text"><%=event.getDescription()%></p>
              <a href="" class="link-info">Offer<span class="iconify-inline" data-icon="ic:outline-local-offer"></span></a>
            </div>
          </div>
        <%}%>

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

  <!-- Listener -->
  <section class="container-xl col">
    <div class="card border-info mb-3" style="max-width: 50rem;">
      <div class="card-header rowsb">
        <h2 style="margin-left: 10px;">You registered for next conferences: </h2>
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