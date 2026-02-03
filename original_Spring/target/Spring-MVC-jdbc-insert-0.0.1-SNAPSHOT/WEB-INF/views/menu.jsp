<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー画面</title>
<link href="main.css" rel="stylesheet">
</head>
<body>
  <div class="header">メニュー画面</div>
  <%
    if (session == null || session.getAttribute("user_name") == null || session.getAttribute("role_id") == null) {
        response.sendRedirect("index");
        return;
    }

    String userName = (String) session.getAttribute("user_name");
    String roleId = (String) session.getAttribute("role_id");
  %>
  <p class="greeting"><%= userName %>さん、こんにちは</p>
  <div class="button-container">
    <p>
      <a href="userMenu" class="btn">ユーザー</a>
    </p>
    <p>
      <a href="<c:url value='/informationMenu' />" class="btn">情報共有</a>
    </p>
  </div>
  <form action="logout" method="post">
    <button type="submit" class="btn logout-btn">ログアウト</button>
  </form>
</body>
</html>
