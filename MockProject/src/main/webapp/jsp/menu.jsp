<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー画面</title>
<link href="commons.css" rel="stylesheet">
</head>
<body>
  <%
    if (session == null || session.getAttribute("user_name") == null || session.getAttribute("role") == null) {
        response.sendRedirect("index");
        return;
    }

    String userName = (String) session.getAttribute("user_name");
    String role = (String) session.getAttribute("role");
  %>
  <p><%= userName %>さん、こんにちは</p>
  <% if ("管理者".equals(role)) { %>
    <p>
      <a href="select">検索</a>
    </p>
    <p>
      <a href="<c:url value='/insert' />">登録</a>
    </p>
  <% } else { %>
    <p>一般ユーザーとしてログインしています。</p>
    <p>
      <a href="select">検索</a>
    </p>
  <% } %>
 <form action="logout" method="post">
    <button type="submit">ログアウト</button>
</form>
</body>
</html>
