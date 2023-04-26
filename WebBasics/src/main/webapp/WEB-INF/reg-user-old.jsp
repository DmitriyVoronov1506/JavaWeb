<%@ page contentType="text/html;charset=UTF-8" %>

<%
  String path = request.getContextPath();
%>

<html>

<head>
  <title>Reg User</title>

  <style>

    main {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 4em;
    }

    form {
      background: darksalmon;
      padding: 1em;
    }

    h2 {
      margin: 0;
    }

    div.form-control {
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
    }

    div.form-control label,
    div.form-control input[type="submit"] {
      cursor: pointer;
    }

  </style>

</head>

<body>
<main>

  <form method="post" enctype="multipart/form-data" action="<%= path %>/register">

    <h2>Registration</h2>
    <div class="form-control">
      <label for="user-login">Login:</label>
      <input name="user-login" type="text" id="user-login"/>
    </div>

    <div class="form-control">
      <label for="user-pass1">Password:</label>
      <input name="user-pass1" type="password" id="user-pass1"/>
    </div>

    <div class="form-control">
      <label for="user-pass2">Repeat password:</label>
      <input name="user-pass2" type="password" id="user-pass2"/>
    </div>

    <div class="form-control">
      <label for="user-name">Real Name:</label>
      <input name="user-name" type="text" id="user-name"/>
    </div>

    <div class="form-control">
      <label for="user-email">Email:</label>
      <input name="user-email" type="email" id="user-email"/>
    </div>

    <div class="form-control">
      <input type="file" name="user-avatar" accept="image/png, image/jpeg"/>
    </div>

    <div class="form-control">
      <input type="submit" value="Send" />
    </div>

  </form>

</main>

</body>
</html>