<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザーメニュー画面</title>
<link href="main.css" rel="stylesheet">
</head>
<body>
  <div class="header">ユーザーメニュー画面</div>
  <%
    if (session == null || session.getAttribute("user_name") == null || session.getAttribute("role_id") == null) {
        response.sendRedirect("index");
        return;
    }

    String userName = (String) session.getAttribute("user_name");
    String roleIdStr = (String) session.getAttribute("role_id");
    int roleId = Integer.parseInt(roleIdStr);
  %>
  <p><%= userName %>さん、こんにちは</p>
  <div class="button-container">
    <% if (roleId == 1) { %>
      <p>
        <a href="userList" class="btn">ユーザー一覧表示</a>
      </p>
      <p>
        <a href="insert" class="btn">新規登録</a>
      </p>
    <% } %>
    <p>
      <a href="changePassword" class="btn">パスワード変更</a>
    </p>
    <p>
      <a href="withdrawl" class="btn">退会</a>
    </p>
  </div>
  <form action="logout" method="post">
    <button type="submit" class="btn logout-btn">ログアウト</button>
  </form>
</body>
</html>

