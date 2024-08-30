<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
<link href="main.css" rel="stylesheet"> <!-- index.jspのスタイルを適用 -->
</head>
<body>
  <div class="header"><strong>ログイン画面</strong></div>
  <script>
  window.addEventListener('load', function() {
    document.body.style.backgroundImage = 'none';
  });
</script>
  <% if (request.getAttribute("errorMessage") != null) { %>
    <p class="error"><%= request.getAttribute("errorMessage") %></p>
  <% } %>
  <form action="login" method="post" class="form-container">
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
  </form>
  <div class="return-link">
    <a href="index">トップ画面に戻る</a>
  </div>
</body>
</html>
