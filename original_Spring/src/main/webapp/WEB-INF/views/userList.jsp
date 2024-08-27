<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザー一覧表示画面</title>
<link href="commons.css" rel="stylesheet">
</head>
<body>
  <div class="header">ユーザー一覧</div>
  <c:if test="${not empty userList}">
    <table>
      <caption>ユーザー一覧</caption>
      <thead>
        <tr>
          <th>ID</th>
          <th>名前</th>
          <th>TEL</th>
          <th>MAIL</th>
          <th>権限</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="userInfo" items="${userList}">
          <tr>
            <td>${userInfo.loginId}</td>
            <td>${userInfo.userName}</td>
            <td>${userInfo.telephone}</td>
            <td>${userInfo.mail}</td> <!-- メールアドレスを表示 -->
            <td>${userInfo.role.roleName}</td> <!-- 権限を表示 -->
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
