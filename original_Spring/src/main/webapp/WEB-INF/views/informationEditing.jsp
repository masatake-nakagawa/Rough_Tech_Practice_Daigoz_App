<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>イベント編集画面</title>
<link href="commons.css" rel="stylesheet">
</head>
<body>
  <p>
    <span class="required"></span>は必須です
  </p>

  <c:if test="${not empty errorMessage}">
    <p class="error">${errorMessage}</p>
  </c:if>
<form action="updateEvent" method="post">
    <input type="hidden" name="eventId" value="${event.event_id}">
    <fieldset class="label-60">
      <div>
        <label class="required">イベント名</label>
        <input type="text" name="eventName" value="${event.eventName}">
      </div>
      <div>
        <label class="required">日時</label>
       <input type="text" name="dateAndTime" value="<fmt:formatDate value='${event.dateAndTime}' pattern='yyyy-MM-dd HH:mm:ss'/>" placeholder="yyyy-MM-dd HH:mm:ss">
      </div>
      <div>
        <label class="required">開催場所</label>
        <input type="text" name="venue" value="${event.venue}">
      </div>
      <div>
        <label class="required">詳細</label>
        <input type="text" name="text" value="${event.text}">
      </div>
      <div>
        <label class="required">参加可能人数</label>
        <input type="number" name="number" value="${event.number}">
      </div>
    </fieldset>
    <button type="submit">編集</button>
  </form>  
  <div>
    <a href="informationMenu">情報共有メニューに戻る</a>
  </div>
</body>
</html>



