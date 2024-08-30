<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>情報共有メニュー画面</title>
<link href="main.css" rel="stylesheet">
</head>
<body>
  <div class="header">情報共有メニュー画面</div>
  <%
    if (session == null || session.getAttribute("user_name") == null || session.getAttribute("role_id") == null) {
        response.sendRedirect("index");
        return;
    }

    String userName = (String) session.getAttribute("user_name");
    String roleIdStr = (String) session.getAttribute("role_id");
    int roleId = Integer.parseInt(roleIdStr);
  %>
  <div class="button-container">
    <% if (roleId == 1) { %>
      <p>
        <form action="insertInformationForm" method="get">
          <button type="submit" class="btn">イベント登録</button>
        </form>
      </p>
     <p>
  <a href="scheduleView" class="btn">イベント編集</a>
</p>
    <% } %>
   <p>
  <a href="scheduleView" class="btn">イベント出欠回答</a>
</p>
    <p>
  <a href="scheduleView" class="btn">スケジュール表示</a>
</p>
  </div>
   <div>
    <a href="menu">メニュー画面に戻る</a>
  </div>
</body>
</html>
