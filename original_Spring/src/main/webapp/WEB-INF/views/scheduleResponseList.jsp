<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>出欠回答</title>
<link href="main.css" rel="stylesheet">
<script>
function toggleButton(button, eventId) {
    const buttons = document.querySelectorAll(`.response-btn[data-event-id="${eventId}"]`);
    buttons.forEach(btn => btn.classList.remove('selected'));
    button.classList.add('selected');
    checkAllSelected();
}

function checkAllSelected() {
    const events = document.querySelectorAll('.event-row');
    let allSelected = true;
    events.forEach(event => {
        const selectedButton = event.querySelector('.response-btn.selected');
        if (!selectedButton) {
            allSelected = false;
        }
    });
    document.getElementById('submit-btn').disabled = !allSelected;
}

function submitResponses() {
    const events = document.querySelectorAll('.event-row');
    const responses = [];
    events.forEach(event => {
        const eventId = event.getAttribute('data-event-id');
        const selectedButton = event.querySelector('.response-btn.selected');
        const status = selectedButton ? selectedButton.textContent : '';
        responses.push({ eventId: eventId, status: status });
    });

    const form = document.createElement('form');
    form.method = 'POST';
    form.action = 'submitResponses';

    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'responses';
    input.value = JSON.stringify(responses);
    form.appendChild(input);

    document.body.appendChild(form);
    form.submit();
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
  <div class="header">出欠回答</div><br>
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
        <tr class="event-row" data-event-id="${event.eventId}">
          <td>${event.eventId}</td>
          <td>${event.eventName}</td>
          <td>${event.dateAndTime}</td>
          <td>${event.venue}</td>
          <td>${event.text}</td>
          <td>${event.number}</td>
          <td><button class="info-btn" data-event-id="${event.eventId}" onclick="toggleButton(this, ${event.eventId})">参加</button></td>
          <td><button class="info-btn" data-event-id="${event.eventId}" onclick="toggleButton(this, ${event.eventId})">不参加</button></td>
          <td><button class="info-btn" data-event-id="${event.eventId}" onclick="toggleButton(this, ${event.eventId})">保留</button></td>
        </tr>
      </c:forEach>
    </tbody>
  </table><br>
  <button id="info-btn" class="btn" disabled onclick="submitResponses()">回答</button><br><br>
  <a href="informationMenu">情報共有メニューへ戻る</a>
</body>
</html>
