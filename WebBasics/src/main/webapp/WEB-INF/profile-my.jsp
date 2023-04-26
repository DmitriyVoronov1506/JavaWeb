<%@ page import="itstep.learning.data.entity.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  User myProfile = (User) request.getAttribute("authUser");
  String contextPath = request.getContextPath();
%>

<div class="row">
  <div class="col l10 m11 s12">
    <h2 class="header" style="text-align: center">My profile</h2>
    <div class="card horizontal">
      <div class="card-image">
        <img id="avatar" style="max-width: 90%" src="<%= contextPath %>/image/<%= myProfile.getAvatar()%>" alt=""/>
        <label for="avatar_uploads" class="btn-floating btn-small waves-effect waves-light teal"
               style="position: absolute; top: 5px; right: 35px;"
        >
          <i class="material-icons" style="font-size: 1rem;">edit</i>
        </label>
        <input hidden id="avatar_uploads" type="file" name="avatar_uploads" accept=".jpg, .jpeg, .png" />
      </div>
      <div class="card-stacked">
        <div class="card-content"
             style="display: flex;
                            flex-direction: column;
                            justify-content: center;
                            gap: 5px;"
        >
          <div style="display: flex;
                                align-items: center;
                                justify-content: space-between;
                                padding: 10px 0;"
          >
                        <span>
                            <b>Login: </b><i><%= myProfile.getLogin() %></i>
                        </span>
          </div>
          <div style="display: flex;
                                align-items: center;
                                justify-content: space-between;
                                padding: 10px 0;"
          >
                        <span>
                            <b>Real Name: </b><i id="user-name"><%= myProfile.getName() %></i>
                        </span>
            <a id="user-name-btn" class="btn-floating btn-small waves-effect waves-light teal">
              <i class="material-icons" style="font-size: 1rem;">edit</i>
            </a>
          </div>
          <div style="display: flex;
                                align-items: center;
                                justify-content: space-between;
                                padding: 10px 0;"
          >
                        <span>
                            <b>Email: </b><i id="email"><%= myProfile.getEmail() %></i>
                        </span>
            <a id="email-btn" class="btn-floating btn-small waves-effect waves-light teal">
              <i class="material-icons" style="font-size: 1rem;">edit</i>
            </a>
          </div>
          <div style="padding-top: 10px;">
            <b>Active from:</b> <%= new SimpleDateFormat("dd/MM/yyyy").format(myProfile.getRegDt()) %>
          </div>
        </div>
        <div class="card-action">
          <a id="change_password_link" style="cursor: pointer">Change password</a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Change password Modal -->
<div id="change_password_modal" class="modal">
  <div class="modal-content">
    <h4>Change Password</h4>
    <div class="row input-field">
      <i class="material-icons prefix">lock_open</i>
      <input id="old-pass" type="password">
      <label for="old-pass">Old password</label>
    </div>
    <label class="auth-error" id="login-err"></label>
    <div class="row input-field">
      <i class="material-icons prefix">lock_open</i>
      <input id="new-pass" type="password">
      <label for="new-pass">New password</label>
    </div>
    <div class="row input-field">
      <i class="material-icons prefix">lock_open</i>
      <input id="repeat-pass" type="password">
      <label for="repeat-pass">Repeat password</label>
    </div>
    <label class="password-error" id="password-err"></label>
  </div>
  <div class="modal-footer">
    <div class="btn" id="change_password_button">
      <span>Change password</span>
    </div>
    <div class="btn" id="cancel_change_password">
      <span>Cancel</span>
    </div>
  </div>
</div>

<div id="save_name_modal" class="modal">
  <div class="modal-content">
    <h4 style="text-align: center" id="save_name_title"></h4>
  </div>
  <div class="modal-footer">
    <div class="btn" id="save_name_button">
      <i class="material-icons left">save</i>Save
    </div>
    <div class="btn" id="cancel_save_name_button">
      <span>Cancel</span>
    </div>
  </div>
</div>

<!-- Save email Modal -->
<div id="save_email_modal" class="modal">
  <div class="modal-content">
    <h4 style="text-align: center" id="save_email_title"></h4>
  </div>
  <div class="modal-footer">
    <div class="btn" id="save_email_button">
      <i class="material-icons left">save</i>Save
    </div>
    <div class="btn" id="cancel_save_email_button">
      <span>Cancel</span>
    </div>
  </div>
</div>

<script>
  const fileTypes = [
    "image/apng",
    "image/bmp",
    "image/gif",
    "image/jpeg",
    "image/pjpeg",
    "image/png",
    "image/svg+xml",
    "image/tiff",
    "image/webp",
    "image/x-icon"
  ];

  const icon_edit = '<i class="material-icons" style="font-size: 1rem;">edit</i>';
  const icon_save = '<i class="material-icons" style="font-size: 1rem;">save</i>';

  const onBlurElem = (editableElem, oldValue, editBtn, modal, modalTitle) => {

    editableElem.onblur = () => {

      const curValue = editableElem.innerText
      if (curValue !== oldValue) {

        let instance = M.Modal.init(modal, {dismissible: false});
        modalTitle.innerText = "Save new value: " + editableElem.innerText
        instance.open();
      }

      editableElem.removeAttribute("contenteditable")
      editBtn.innerHTML = icon_edit;
      oldValue = curValue
    }
  }

  document.addEventListener("DOMContentLoaded", () => {

    let oldValue;
    const userName = document.getElementById("user-name");
    const email = document.getElementById("email");
    const userNameBtn = document.getElementById("user-name-btn");

    userNameBtn.addEventListener("click", () => {

      let oldNameValue = userName.innerText;
      oldValue = oldNameValue;

      if (userName.getAttribute("contenteditable")) {

        userName.removeAttribute("contenteditable")
        userNameBtn.innerHTML = icon_edit;

      }
      else {

        userName.setAttribute("contenteditable", "true");
        userNameBtn.innerHTML = icon_save;
        userName.focus();


        let sel = window.getSelection();
        sel.selectAllChildren(userName);
        sel.collapseToEnd();

      }

      userName.onkeydown = (keyboardEvent) => {

        if (keyboardEvent.key === "Enter") userName.blur()
      }

      const modal = document.getElementById('save_name_modal');
      const modalTitle = document.getElementById("save_name_title");
      onBlurElem(userName, oldNameValue, userNameBtn, modal, modalTitle)
    });

    const saveNameButton = document.getElementById("save_name_button");

    saveNameButton.addEventListener("click", () => {

      fetch(window.location.href, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: `{"userName": "${userName.innerText}"}`
      }).then(r => r.text()).then(resp => console.log("change userName: " + resp));

      M.Modal.getInstance(window.save_name_modal).close();
      userName.removeAttribute("contenteditable")
      userNameBtn.innerHTML = icon_edit;
    });

    cancel_save_name_button.addEventListener("click", () => {

      M.Modal.getInstance(window.save_name_modal).close();
      userNameBtn.innerHTML = icon_edit;
      userName.removeAttribute("contenteditable")
      userName.innerText = oldValue;
    });

    const emailBtn = document.getElementById("email-btn");

    emailBtn.addEventListener("click", () => {

      let oldEmailValue = email.innerText;
      oldValue = oldEmailValue

      if (email.getAttribute("contenteditable")) {

        email.removeAttribute("contenteditable")
        emailBtn.innerHTML = icon_edit;
      }
      else {

        email.setAttribute("contenteditable", "true");
        emailBtn.innerHTML = icon_save;
        email.focus();

        let sel = window.getSelection();
        sel.selectAllChildren(email);
        sel.collapseToEnd();
      }

      email.onkeydown = (keyboardEvent) => {
        if (keyboardEvent.key === "Enter") email.blur()
      }

      const modal = document.getElementById('save_email_modal');
      const modalTitle = document.getElementById("save_email_title");
      onBlurElem(email, oldEmailValue, emailBtn, modal, modalTitle)
    });

    const saveEmailButton = document.getElementById("save_email_button");

    saveEmailButton.addEventListener("click", () => {

      fetch(window.location.href, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: `{"email": "${email.innerText}"}`
      }).then(r => r.text()).then(resp => console.log("change email: " + resp));

      M.Modal.getInstance(window.save_email_modal).close();
      email.removeAttribute("contenteditable")
      emailBtn.innerHTML = icon_edit;
    });

    cancel_save_email_button.addEventListener("click", () => {

      M.Modal.getInstance(window.save_email_modal).close();
      emailBtn.innerHTML = icon_edit;
      email.removeAttribute("contenteditable")
      email.innerText = oldValue;
    })

    const avatarUploadBtn = document.getElementById("avatar_uploads");

    avatarUploadBtn.addEventListener("change", (e) => {

      const avatar = document.getElementById("avatar");
      const file = e.target.files[0];

      if (fileTypes.includes(file.type)) {

        let formData = new FormData();
        formData.append("userAvatar", file);
        fetch(window.location.href, {
          method: "PATCH",
          body: formData
        }).then(r => r.text()).then(console.log)

        avatar.src = URL.createObjectURL(file)
      }
      else {
        alert(`File name ${file.name} not a valid file type`)
      }
    });
  });
</script>