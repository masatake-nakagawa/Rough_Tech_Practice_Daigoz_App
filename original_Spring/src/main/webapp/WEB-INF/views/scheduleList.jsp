<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>スケジュール一覧</title>
<link href="main.css" rel="stylesheet">
</head>
<body><br>
  <div class="header">スケジュール一覧</div>
  <table>
    <thead>
      <tr>
        <th>番号</th>
        <th>イベント名</th>
        <th>日時</th>
        <th>場所</th>
        <th>詳細</th>
        <th>人数</th>
        <th>操作</th>
      </tr>
    </thead>
    <tbody>
  <c:forEach var="event" items="${events}">
    <tr>
      <td>${event.eventId}</td>
      <td>${event.eventName}</td>
      <td>${event.dateAndTime}</td>
      <td>${event.venue}</td>
      <td>${event.text}</td>
      <td>${event.number}</td>
      <td>
        <a href="eventResponse?eventId=${event.eventId}" class="info-btn">出欠回答</a>
        <c:if test="${roleId == 1}">
          <a href="editEventInfo?eventId=${event.eventId}&dateAndTime=${fn:substringBefore(event.dateAndTime, '.')}" class="info-btn">編集</a>                                      
         <%--  <a href="attendanceList?eventId=${event.eventId}" class="info-btn">出欠確認</a> --%>
          
        </c:if>
      </td>
    </tr>
  </c:forEach>
</tbody>
  </table>
     <div>
    <a href="informationMenu">情報共有メニューへ戻る</a>
  </div>
</body>
</html>