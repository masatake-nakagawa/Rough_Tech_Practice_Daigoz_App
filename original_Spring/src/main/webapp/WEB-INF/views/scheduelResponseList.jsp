<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>出欠回答</title>
<link href="commons.css" rel="stylesheet">
<script>
function toggleButton(button) {
    button.classList.toggle('selected');
    checkAllSelected();
}

function checkAllSelected() {
    const buttons = document.querySelectorAll('.response-btn');
    const allSelected = Array.from(buttons).every(button => button.classList.contains('selected'));
    document.getElementById('submit-btn').disabled = !allSelected;
}
</script>
<style>
.selected {
    background-color: #4CAF50; /* 緑色 */
    color: white;
}
</style>
</head>
<body>
  <div class="header">出欠回答</div>
  <table>
    <thead>
      <tr>
        <th>イベントID</th>
        <th>イベント名</th>
        <th>日時</th>
        <th>場所</th>
        <th>詳細</th>
        <th>人数</th>
        <th>参加</th>
        <th>不参加</th>
        <th>保留</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="event" items="${events}">
        <tr>
          <td>${event.event_id}</td>
          <td>${event.eventName}</td>
          <td>${event.dateAndTime}</td>
          <td>${event.venue}</td>
          <td>${event.text}</td>
          <td>${event.number}</td>
          <td><button class="response-btn" onclick="toggleButton(this)">参加</button></td>
          <td><button class="response-btn" onclick="toggleButton(this)">不参加</button></td>
          <td><button class="response-btn" onclick="toggleButton(this)">保留</button></td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
  <button id="submit-btn" disabled>回答</button>
  <a href="informationMenu">情報共有メニューへ戻る</a>
</body>
</html>

