<%@ page import="itstep.learning.data.entity.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  User profileUser = (User) request.getAttribute("profileUser");
  String contextPath = request.getContextPath();
%>

<div class="row">
  <div class="col l6 m10 s12">
    <h2 class="header" style="text-align: center">Personal Profile</h2>
    <div class="card horizontal">
      <div class="card-image">
        <img style="max-width: 90%" src="<%= contextPath %>/image/<%= profileUser.getAvatar()%>" alt=""/>
      </div>
      <div class="card-stacked">
        <div class="card-content"
             style="display: flex;
                            flex-direction: column;
                            justify-content: center;
                            gap: 20px;"
        >
          <p>
            <b>Login:</b> <%= profileUser.getLogin() %>
          </p>
          <p>
            <b>Real Name:</b> <%= profileUser.getName() %>
          </p>
          <p>
            <b>Email:</b> <%= profileUser.getEmail() %>
          </p>
          <p>
            <b>Active from:</b> <%= new SimpleDateFormat("dd/MM/yyyy").format(profileUser.getRegDt()) %>
          </p>
        </div>
        <div class="card-action">
          <a href="mailto:<%= profileUser.getEmail() %>">Send Message</a>
        </div>
      </div>
    </div>
  </div>
</div>