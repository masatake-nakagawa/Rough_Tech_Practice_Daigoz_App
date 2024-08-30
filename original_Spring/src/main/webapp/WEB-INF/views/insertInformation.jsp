<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="jp.co.hoge.web.entity.Role" %>
<%
    request.setCharacterEncoding("UTF-8"); 
    String eventName = request.getParameter("eventName") != null ? request.getParameter("eventName") : "";
    String dateAndTime = request.getParameter("dateAndTime") != null ? request.getParameter("dateAndTime") : "";
    String venue = request.getParameter("venue") != null ? request.getParameter("venue") : "";
    String text = request.getParameter("text") != null ? request.getParameter("text") : "";
    String number = request.getParameter("number") != null ? request.getParameter("number") : "";
    String errorMessage = (String) request.getAttribute("errorMessage");
    List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<!DOCTYPE html>
<html><head>
<meta charset="UTF-8">
<title>イベント登録画面</title>
<link href="main.css" rel="stylesheet">
</head>
<body>
  <p>
    <span class="required"></span>は必須です
  </p>

  <% if (errorMessage != null) { %>
    <p class="error"><%= errorMessage %></p>
  <% } %>

  <form action="insertInformation" method="post">
    <fieldset class="label-60">
      <div>
        <label class="required">イベント名</label>
        <input type="text" name="eventName" value="<%= eventName %>">
      </div>
      <div>
	  <label class="required">日時</label>
	  <input type="text" name="dateAndTime" value="<%= dateAndTime %>" placeholder="yyyy-MM-dd HH:mm:ss">
	</div>
      
      <div>
        <label class="required">開催場所</label>
        <input type="text" name="venue" value="<%= venue %>">
      </div>
      <div>
        <label class="required">詳細</label>
        <input type="text" name="text" value="<%= text %>">
      </div>
      <div>
        <label class="required">参加可能人数</label>
        <input type="number" name="number" value="<%= number %>">
      </div>
    </fieldset>
    <button type="submit">登録</button>
  </form>
  <div>
    <a href="informationMenu">情報共有メニューに戻る</a>
  </div>
</body>
</html>
