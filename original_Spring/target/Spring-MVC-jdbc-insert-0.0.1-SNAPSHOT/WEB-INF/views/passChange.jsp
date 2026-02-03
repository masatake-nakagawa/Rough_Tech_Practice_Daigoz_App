<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>パスワード変更</title>
<link href="main.css" rel="stylesheet">
</head>
<body>
  <div class="header"><b>パスワード変更</b></div>
  <form action="changePassword" method="post">
    <br>
    <div>
      <label>現在のパスワード</label>
      <input type="password" name="currentPassword" required>
    </div>
    <div>
      <label>新しいパスワード</label>
      <input type="password" name="newPassword" required>
    </div>
    <div>
      <label>新しいパスワード</label>
      <input type="password" name="confirmPassword" required>
      <br>（確認用）
    </div>
    <div><p>
      <button type="submit">変更</button></p>
    </div>
  </form>
  <div>
    <a href="userMenu">ユーザーメニュー画面に戻る</a>
  </div>
</body>
</html>
