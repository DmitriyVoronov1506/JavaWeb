<%@ page import="itstep.learning.data.entity.User" %>
<%@ page import="itstep.learning.data.entity.Team" %>
<%@ page import="java.util.List" %>
<%@ page import="itstep.learning.data.entity.Task" %>
<%@ page import="itstep.learning.data.entity.Entity" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String domain = request.getContextPath();
  User authUser = (User) request.getAttribute("authUser");
  List<Team> teams = (List<Team>) request.getAttribute("teams");
  List<Team> userTeams = (List<Team>) request.getAttribute("userTeams");
  List<Task> tasks = (List<Task>) request.getAttribute("tasks");
  List<User> users = (List<User>) request.getAttribute("users");
%>

<!-- region Tasks block -->
<div style="display: block; width: 100%; background: lightblue; border-radius: 20px">
  <div style="display: flex; flex-direction: column; width: 95%; margin: auto;">
    <h4 style="text-align: center">Active tasks</h4>
    <% for (int i = 1; i <= tasks.size(); ++i) { %>
    <div class="task" id="task<%= i %>" style="padding: 10px; margin-bottom: 10px; display: flex; align-items: center; justify-content: space-between">
      <div style="display: flex; align-items: center;">
        <i id="task<%= i %>_priority_icon" class="material-icons" style="margin-right: 10px;"></i>
        <b id="task<%= i %>_name"><%= tasks.get(i - 1).getName() %></b>
        <b hidden id="task<%= i %>_team">
          <% for(Team team : teams) { %>
          <% if(team.getId().equals(tasks.get(i - 1).getIdTeam())) %><%= team.getName() %>
          <% } %>
        </b>
        <b hidden id="task<%= i %>_createdDt"><%= Entity.sqlDatetimeFormat.format(tasks.get(i - 1).getCreatedDt()) %></b>
        <b hidden id="task<%= i %>_deadline"><%= Entity.sqlDatetimeFormat.format(tasks.get(i - 1).getDeadline()) %></b>
        <b hidden id="task<%= i %>_priority"><%= tasks.get(i - 1).getPriority() %></b>
        <b hidden id="task<%= i %>_status"><%= tasks.get(i - 1).getStatus() %></b>
      </div>
      <div style="display: flex; align-items: center; gap: 5px">
        <i id="check_box_icon<%= i %>" style="cursor: pointer" class="material-icons">check_box_outline_blank</i>
        <i id="eye_icon<%= i %>" style="cursor: pointer" class="material-icons">remove_red_eye</i>
        <i id="edit_icon<%= i %>" class="material-icons">edit</i>
        <i id="delete_icon<%= i %>" class="material-icons">delete</i>
        <a id="mail_icon<%= i %>" href="#<%= tasks.get(i - 1).getId() %>" style="cursor: pointer; margin-top: 5px">
          <i style="color: black" class="material-icons mail_<%= tasks.get(i - 1).getId() %>">mail</i>
        </a>
      </div>
    </div>
    <% } %>
  </div>
</div>
<!-- endregion -->

<!-- region Discuss block -->
<div style="display: block; width: 100%; background: lightblue; border-radius: 20px; margin-top: 15px">
  <h4 style="text-align: center" id="discussion-title">Discussion</h4>
  <div id="chat" style="width: 90%; margin: auto"></div>
  <form method="post" id="story-form" style="width: 90%; margin: auto">
    <textarea id="textarea1" class="materialize-textarea" name="story-text"></textarea>
    <div class="row input-field right-align">
      <button class="btn waves-effect waves-teal" type="submit" style="margin-bottom: 15px">Send<i class="material-icons right">add</i></button>
    </div>
    <input type="hidden" name="story-id-task" />
  </form>
</div>
<!-- endregion -->

<!-- region Add task block -->
<div style="display: block; width: 100%; background: lightblue; border-radius: 20px">
  <div class="row" style="width: 100%">
    <h4 style="text-align: center">Add task</h4>
    <form class="col s10 offset-s1 m8 offset-m2 l6 offset-l3" method="post" id="task-form">
      <div class="row input-field">
        <i class="material-icons prefix">content_paste</i>
        <input id="task-name" type="text" name="task-name">
        <label for="task-name">Name task</label>
      </div>
      <div class="row input-field">
        <div id="task-team">
          <i class="material-icons prefix" id="people-icon" style="position: absolute; top: 0; padding-top: 9px; padding-bottom: 9px;">people_outline</i>
          <select name="task-team">
            <option value="" disabled selected>Choose team</option>
            <% for (Team userTeam : userTeams) { %>
            <option value="<%= userTeam.getId() %>"><%= userTeam.getName() %></option>
            <% } %>
          </select>
          <label style="margin-top: 10px">Team</label>
        </div>
      </div>
      <div class="row input-field">
        <i class="material-icons prefix">event_available</i>
        <input id="task-deadline" type="text" class="datepicker" name="task-deadline">
        <label for="task-deadline">Deadline</label>
      </div>
      <div class="row input-field">
        <div id="task-priority">
          <i class="material-icons prefix" id="exclamation-mark-icon" style="position: absolute; top: 0; padding-top: 9px; padding-bottom: 9px;">priority_high</i>
          <select name="task-priority">
            <option value="" disabled selected>Choose priority</option>
            <option value="0">Usual</option>
            <option value="1">High</option>
            <option value="2">Extreme</option>
          </select>
          <label style="margin-top: 10px">Priority</label>
        </div>
      </div>
      <div class="row input-field right-align">
        <button class="btn waves-effect waves-teal" type="submit">
          add<i class="material-icons right">add</i>
        </button>
      </div>
    </form>
  </div>
</div>
<!-- endregion -->

<div style="display: block; width: 100%; background: lightblue; border-radius: 20px; margin-bottom: 20px">
  <!-- region Add team block -->
  <div class="row" style="width: 100%">
    <h4 style="text-align: center">Add team</h4>
    <div style="display: flex; align-items: center; justify-content: center; margin: 0 50px 0; gap: 20px">
      <div class="row input-field" style="width: 70%">
        <i class="material-icons prefix">people_outline</i>
        <input id="team-name" type="text" name="team-name">
        <label for="team-name">Team name</label>
      </div>
      <button class="btn waves-effect waves-teal" id="add-team-btn">
        add<i class="material-icons right">add</i>
      </button>
    </div>
  </div>
  <!-- endregion -->

  <!-- region Add user to team block  -->
  <div class="row" style="margin: 0 40px 0">
    <h4 style="text-align: center">Add user to team</h4>
    <div class="row input-field">
      <i class="material-icons prefix">people_outline</i>
      <select id="add-team" name="add-team">
        <option value="" disabled selected>Choose team</option>
        <% for (Team team : teams) { %>
        <option value="<%= team.getId() %>"><%= team.getName() %></option>
        <% } %>
      </select>
      <label>Team</label>
    </div>
    <div class="row input-field">
      <i class="material-icons prefix">tag_faces</i>
      <select id="add-user-to-team" name="add-user-to-team">
        <option value="" disabled selected>Choose user</option>
        <% for (User user : users) { %>
        <option value="<%= user.getId() %>"><%= user.getName() %></option>
        <% } %>
      </select>
      <label>User</label>
    </div>
    <div style="margin-bottom: 15px; display: flex; justify-content: end">
      <button class="btn waves-effect waves-teal" id="add-user-to-team-btn">
        add<i class="material-icons right">add</i>
      </button>
    </div>
  </div>
  <!-- endregion -->
</div>

<!-- region open task Modal -->
<div id="open_task_modal" class="modal">
  <div class="modal-content">
    <h5 id="task_name_modal"></h5>
    <h5 id="task_team_modal"></h5>
    <h5 id="task_createdDt_modal"></h5>
    <h5 id="task_deadline_modal"></h5>
    <h5 id="task_priority_modal"></h5>
    <h5 id="task_status_modal"></h5>
  </div>
  <div class="modal-footer">
    <div class="btn" id="save_task_button">
      <i class="material-icons left">save</i>Save
    </div>
    <div class="btn" id="close_task_button">
      <span>Close</span>
    </div>
  </div>
</div>
<!-- endregion -->

<!-- region add task error Modal -->
<div id="error_modal" class="modal">
  <div class="modal-content">
    <h4>Ошибка:</h4>
    <h5 id="error_message_modal"></h5>
  </div>
  <div class="modal-footer">
    <div class="btn" id="ok_button">
      <span>Ok</span>
    </div>
  </div>
</div>
<!-- endregion -->

<button class="btn waves-effect waves-teal" onclick="testEmail()">
  Test Email<i class="material-icons right">add</i>
</button>
<div id="preloader"></div>
<script>
  function testEmail() {
    preloader.innerHTML = "Wait...";
    fetch("<%= domain %>/story", {
      method: "PUT"
    }).then(r => r.text())
            .then(t => { console.log(t); preloader.innerHTML = "Done"; })
            .catch(err => { console.log(err); preloader.innerHTML = "Error"; });
  }
  const tpl = `
<div style="padding: 10px 20px; border-bottom: 1px solid black;">
    <div style="display: flex; justify-content: space-between;">
        <div>{{user}}</div>
        <div>{{moment}}</div>
    </div>
    <div style="margin-top: 15px;">{{content}}</div>
</div>
`;
  const new_task_name = document.getElementById("task-name");
  const new_task_team = document.getElementById("task-team");
  const new_task_deadline = document.getElementById("task-deadline");
  const new_task_priority = document.getElementById("task-priority");
  const error_message = document.getElementById("error_message_modal");
  document.addEventListener('DOMContentLoaded', function () {
    let elems = document.querySelectorAll('select');
    let instances = M.FormSelect.init(elems, {});
    elems = document.querySelectorAll('.datepicker');
    instances = M.Datepicker.init(elems, {format: "yyyy-mm-dd"});
    const tasks = document.getElementsByClassName("task");
    for (let i = 0; i < tasks.length; ++i) {
      let task_name = document.getElementById(`task${i + 1}_name`);
      const task_team = document.getElementById(`task${i + 1}_team`);
      const task_createdDt = document.getElementById(`task${i + 1}_createdDt`);
      const task_deadline = document.getElementById(`task${i + 1}_deadline`);
      const task_priority = document.getElementById(`task${i + 1}_priority`);
      const task_status = document.getElementById(`task${i + 1}_status`);
      const task_priority_icon = document.getElementById(`task${i + 1}_priority_icon`);
      const check_box_icon = document.getElementById(`check_box_icon${i + 1}`);
      const priority = parseInt(task_priority.innerText) + 1;
      const task = document.getElementById(`task${i + 1}`);
      let isChecked = task_status.innerText === "0" ? false : true;
      if (isChecked) {
        task_name.style.textDecoration = "line-through";
        check_box_icon.innerText = "check_box";
      }
      else {
        task_name.style.textDecoration = "none";
        check_box_icon.innerText = "check_box_outline_blank";
      }
      if (priority === 1) {
        task.style.border = "1px solid brown";
        task.style.background = "#1DC38B";
        task_priority_icon.innerText = "looks_one";
      }
      else if (priority === 2) {
        task.style.padding = "8px";
        task.style.border = "4px solid brown";
        task.style.background = "#939F41";
        task_priority_icon.innerText = "looks_two";
      }
      else if (priority === 3) {
        task.style.padding = "6px";
        task.style.border = "7px solid brown";
        task.style.background = "#B4654B";
        task_priority_icon.innerText = "looks_3";
      }
      document.getElementById(`eye_icon${i + 1}`).addEventListener('click', () => {
        document.getElementById("task_name_modal").innerHTML = "<b>Task name:</b> " + task_name.innerText;
        document.getElementById("task_team_modal").innerHTML = "<b>Team:</b> " + task_team.innerText;
        document.getElementById("task_createdDt_modal").innerHTML = "<b>Create datetime:</b> " + task_createdDt.innerText;
        document.getElementById("task_deadline_modal").innerHTML = "<b>Deadline:</b> " + task_deadline.innerText;
        document.getElementById("task_priority_modal").innerHTML = "<b>Priority:</b> "
                + (priority === 1 ? "(1) Usual" : priority === 2 ? "(2) High" : "(3) Extreme");
        document.getElementById("task_status_modal").innerHTML = "<b>Status:</b> "
                + (isChecked ? "Done ✅" : "Not done ❌");
        M.Modal.init(document.getElementById('open_task_modal'), {}).open();
      });
      check_box_icon.addEventListener('click', () => {
        if (!isChecked) {
          task_name.style.textDecoration = "line-through";
          check_box_icon.innerText = "check_box";
        }
        else {
          task_name.style.textDecoration = "none";
          check_box_icon.innerText = "check_box_outline_blank";
        }
        fetch(window.location.href, {
          method: "PUT",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "taskNumber": i.toString()
          }
        }).then(r => r.text()).then(t => {
          if (t !== "OK") alert("Invalid credentials: " + t);
        });
        isChecked = !isChecked;
      });
      document.getElementById(`mail_icon${i + 1}`).addEventListener('click', () => {
        const discussTitle = document.getElementById("discussion-title");
        discussTitle.innerText = `Discussion: ${task_name.innerText}`;
        const mailIcon = document.querySelector(`a#mail_icon${i + 1} > i`);
        if (mailIcon.innerText !== "mail") mailIcon.innerText = "mail";
        if (mailIcon.style.color !== "black") mailIcon.style.color = "black";
        document.getElementById("textarea1").focus()
      });
    }
    close_task_button.addEventListener("click", () => {
      M.Modal.getInstance(window.open_task_modal).close();
    });
    initWebsocket();
    window.dispatchEvent(new Event("hashchange"));
  });
  function initWebsocket() {
    window.websocket = new WebSocket(`ws://${window.location.host}/WebBasics/chat`);
    window.websocket.onopen = onWsOpen;
    window.websocket.onmessage = onWsMessage;
    window.websocket.onclose = onWsClose;
    window.websocket.onerror = onWsError;
  }
  function onWsOpen(e) {
    // console.log("onWsOpen", e)
  }
  let tempStory = null;
  function onWsMessage(e) {
    const model = JSON.parse(e.data);
    if(typeof model.status !== 'undefined') {
      alert("Message was not sent");
      return;
    }
    if(model.story.idTask === window.location.hash.substring(1)) {
      const chat = document.getElementById("chat");
      const html = `
<div id="{{storyId}}" style="padding: 10px 20px; border: 2px solid black; border-top: 0px; margin: 0 5%;">
    <div style="display: flex; justify-content: space-between;">
        <div>{{user}}</div>
        <div>{{moment}}</div>
    </div>
    <div style="margin-top: 15px;">{{content}}</div>
</div>
`.replace("{{storyId}}", model.story.id)
              .replace("{{moment}}",  utcDateToString(model.story.createdDt))
              .replace("{{user}}",    model.user.name)
              .replace("{{content}}", model.story.content);
      chat.insertAdjacentHTML("beforeend", html);
      tempStory = model.story.id;
    }
    else {
      // выводим иконку нового сообщения
      const newMsgIcon =  document.querySelector("i.mail_" + model.story.idTask);
      newMsgIcon.innerText = "fiber_new";
      newMsgIcon.style.color = "blue";
    }
  }
  function onWsClose(e) {
    // console.log("onWsClose", e)
  }
  function onWsError(e) {
    console.log("onWsError", e)
  }
  document.addEventListener('submit', e => {
    e.preventDefault();
    switch(e.target.id) {
      case 'story-form': sendStoryForm(); break;
      case 'task-form': sendTaskForm(); break;
    }
  });
  function sendStoryForm() { // версия с вебсокетом
    if(!window.websocket) throw 'websocket not init';
    const storyIdTask = document.querySelector('input[name="story-id-task"]');
    if(!storyIdTask) throw 'input[name="story-id-task"] not found';
    const taskId = storyIdTask.value; // TODO: Validate
    if(taskId.length < 36) {
      alert("Select a task");
      return;
    }
    const textarea = document.getElementById('textarea1');
    if(!textarea) throw 'textarea not found';
    const storyMessage = textarea.value; // TODO: Validate
    window.websocket.send(JSON.stringify({ taskId: taskId, content: storyMessage }));
    textarea.value = "";
  }
  function sendStoryFormHttp() {
    fetch('<%= domain + "/story" %>', {
      method: "POST",
      headers: {"Content-Type": "application/x-www-form-urlencoded",},
      body: new URLSearchParams(new FormData(document.querySelector("#story-form")))
    }).then(r => r.text()).then(console.log);
  }
  const people_icon = document.getElementById("people-icon");
  const exclamation_mark_icon = document.getElementById("exclamation-mark-icon");
  function sendTaskForm() {
    fetch(window.location.href, {
      method: "POST",
      headers: {"Content-Type": "application/x-www-form-urlencoded",},
      body: new URLSearchParams(new FormData(document.querySelector("#task-form")))
    }).then(r => r.text()).then(t => {
      if (t === "Unauthorized") error_message.innerText = t;
      else if (t === "Missing required parameter: task-name") {
        error_message.innerText = t;
        new_task_name.style.background = "rgba(255,0,0,.2)";
      }
      else if (t === "Missing required parameter: task-team") {
        error_message.innerText = t;
        people_icon.style.background = "lightblue";
        new_task_team.style.background = "rgba(255,0,0,.2)";
      }
      else if (t === "Missing required parameter: task-deadline") {
        error_message.innerText = t;
        new_task_deadline.style.background = "rgba(255,0,0,.2)";
      }
      else if (t === "Missing required parameter: task-priority") {
        error_message.innerText = t;
        exclamation_mark_icon.style.background = "lightblue";
        new_task_priority.style.background = "rgba(255,0,0,.2)";
      }
      else if (t === "OK") {
        window.location.reload();
        return;
      }
      M.Modal.init(document.getElementById('error_modal'), {}).open();
    });
  }
  new_task_name.addEventListener("input", () => {
    new_task_name.style.background = "none";
    error_message.innerText = "";
  });
  new_task_team.addEventListener("change", () => {
    new_task_team.style.background = "none";
    error_message.innerText = "";
  });
  new_task_deadline.addEventListener("change", () => {
    new_task_deadline.style.background = "none";
    error_message.innerText = "";
  });
  ok_button.addEventListener("click", () => {
    M.Modal.getInstance(window.error_modal).close();
  });
  window.addEventListener('hashchange', () => {
    if (tempStory !== null) document.getElementById(tempStory).style.display = "none";
    const taskId = window.location.hash.substring(1);
    if (! /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/.test(taskId) ) return;
    // TODO: проверить, что такая задача есть у пользователя
    // (зачистить хеш / вывести предупреждение, что нет такой задачи)
    document.querySelector('input[name="story-id-task"]').value = taskId ;
    // Получить список историй по этой задаче и отобразить
    fetch("<%= domain %>/story?task-id=" + taskId)
            .then(r => r.json())
            .then(j => {
              let chatHtml = `<div style='border: 2px solid black; border-bottom: 1px solid black;'>`;
              let models = j.sort((a, b) => Date.parse(a.story.createdDt) - Date.parse(b.story.createdDt));
              for(let model of models) chatHtml += htmlFromStoryModel(model);
              document.getElementById("chat").innerHTML = chatHtml + "</div>";
            });
  });
  function htmlFromStoryModel(model) {
    return tpl.replace("{{moment}}",  utcDateToString(model.story.createdDt))
            .replace("{{user}}",    model.user.name)
            .replace("{{content}}", model.story.content);
  }
  document.getElementById("add-team-btn").addEventListener("click", () => {
    fetch("<%= domain %>/team", {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: `{"teamName": "${document.getElementById("team-name").value}"}`
    }).then(r => r.text()).then(t => {
      if(t === "OK") {
        alert(t);
        window.location.reload();
      }
      else {
        alert(t);
      }
    });
  });
  document.getElementById("add-user-to-team-btn").addEventListener("click", () => {
    const addTeam = document.getElementById("add-team").value;
    const addUserToTeam = document.getElementById("add-user-to-team").value;
    fetch("<%= domain %>/team", {
      method: "PUT",
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: `{"id_team": "${addTeam}","id_user": "${addUserToTeam}"}`
    }).then(r => r.text()).then(t => {
      if (t === "OK") {
        alert(t);
        window.location.reload();
      }
      else {
        alert(t);
      }
    });
  });
  function utcDateToString(dateString) {
    const dt = new Date(dateString + " UTC");
    const timeString = dt.toTimeString().substring(0, 8);
    return dt.toDateString() === new Date().toDateString() ? timeString : dt.toDateString() + ' ' + timeString;
  }
</script>
