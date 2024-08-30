<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>出欠一覧表示画面</title>
<link href="main.css" rel="stylesheet">
</head>
<body>
  <div class="header">出欠一覧</div>
  <c:if test="${not empty attendanceList}">
    <table>
      <caption>出欠一覧</caption>
      <thead>
        <tr>
          <th>イベントID</th>
          <th>ユーザーID</th>
          <th>ステータス</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="attendance" items="${attendanceList}">
          <tr>
            <td>${attendance.eventId}</td>
            <td>${attendance.userId}</td>
            <td>${attendance.status}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </c:if>
  <div>
    <a href="menu">メニューに戻る</a>
  </div>
</body>
</html>
