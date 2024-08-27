<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
<link href="commons.css" rel="stylesheet">
</head>
<body>
  <% if (request.getAttribute("errorMessage") != null) { %>
    <p class="error"><%= request.getAttribute("errorMessage") %></p>
  <% } %>
  <form action="login" method="post">
    <fieldset>
      <div>
        <label>ID</label>
        <input type="text" name="loginId">
      </div>
      <div>
        <label>PASS</label>
        <input type="password" name="pass">
      </div>
    </fieldset>
    <button type="submit">ログイン</button>
  </form>
  <div>
    <a href="index">TOP画面に戻る</a>
  </div>
</body>
</html>
