<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html><head>
<meta charset="UTF-8">
<title>検索結果画面</title>
<link href="main.css" rel="stylesheet">
</head>
<body>
  <c:if test="${not empty userList}">
    <table>
      <caption>検索結果</caption>
      <thead>
        <tr>
          <th>ID</th>
          <th>名前</th>
          <th>TEL</th>
          <th>権限</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="userInfo" items="${userList}">
          <tr>
            <td>${userInfo.loginId}</td>
            <td>${userInfo.userName}</td>
            <td>${userInfo.telephone}</td>
            <td>${userInfo.role.roleName}</td>  
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