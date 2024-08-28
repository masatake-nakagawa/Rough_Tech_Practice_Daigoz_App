<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>情報共有メニュー画面</title>
<link href="commons.css" rel="stylesheet">
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
  <p><%= userName %>さん、こんにちは</p>
  <div class="button-container">
    <% if (roleId == 1) { %>
      <p>
        <form action="insertInformationForm" method="get">
          <button type="submit" class="btn">イベント登録</button>
        </form>
      </p>
      <p>
        <a href="eventEdit" class="btn">イベント編集</a>
      </p>
    <% } %>
    <p>
      <a href="eventResponse" class="btn">イベント出欠回答</a>
    </p>
    <p>
      <a href="scheduleView" class="btn">スケジュール表示</a>
    </p>
  </div>
  <form action="logout" method="post">
    <button type="submit" class="btn logout-btn">ログアウト</button>
  </form>
</body>
</html>
