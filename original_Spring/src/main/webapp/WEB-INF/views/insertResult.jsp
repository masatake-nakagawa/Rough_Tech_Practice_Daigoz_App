<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録結果画面</title>
<link href="commons.css" rel="stylesheet">
</head>
<body>
  <p>実行者：<%= request.getAttribute("loggedInUserName") %></p>
  <p>新規ユーザーの登録が完了しました。</p>
  <div>
    <a href="menu">メニューに戻る</a>
  </div>
</body>
</html>
