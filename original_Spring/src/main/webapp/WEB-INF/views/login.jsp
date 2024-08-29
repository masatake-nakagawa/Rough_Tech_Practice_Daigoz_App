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
  <div class="header">ログイン画面</div>
  <% if (request.getAttribute("errorMessage") != null) { %>
    <p class="error"><%= request.getAttribute("errorMessage") %></p>
  <% } %>
  <form action="login" method="post">
    <fieldset>
      <div class="form-group">
        <label>ID</label>
        <input type="text" name="loginId">
      </div>
      <div class="form-group">
        <label>PASS</label>
        <input type="password" name="pass">
      </div>
      <div class="form-group">
        <button type="submit" class="btn">ログイン</button>
      </div>
    </fieldset>
  </form>
  <div>
    <a href="index">トップ画面に戻る</a>
  </div>
</body>
</html>

