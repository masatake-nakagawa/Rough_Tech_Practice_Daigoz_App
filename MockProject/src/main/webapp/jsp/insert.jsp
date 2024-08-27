<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="jp.co.hoge.web.entity.Role" %>
<%
    request.setCharacterEncoding("UTF-8"); 
    String loginId = request.getParameter("loginId") != null ? request.getParameter("loginId") : "";
    String userName = request.getParameter("userName") != null ? request.getParameter("userName") : "";
    String tel = request.getParameter("tel") != null ? request.getParameter("tel") : "";
    String pass = request.getParameter("pass") != null ? request.getParameter("pass") : "";
    String roleId = request.getParameter("roleId") != null ? request.getParameter("roleId") : ""; 
    String errorMessage = (String) request.getAttribute("errorMessage");
    List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<!DOCTYPE html>
<html><head>
<meta charset="UTF-8">
<title>登録画面</title>
<link href="commons.css" rel="stylesheet">
</head>
<body>
  <p>
    登録情報を入力してください<br> 
    <span class="required"></span>は必須です
  </p>

  <% if (errorMessage != null) { %>
    <p class="error"><%= errorMessage %></p>
  <% } %>

  <form action="insert" method="post">
    <fieldset class="label-60">
      <div>
        <label class="required">ID</label>
        <input type="text" name="loginId" value="<%= loginId %>">
      </div>
      <div>
        <label class="required">名前</label>
        <input type="text" name="userName" value="<%= userName %>">
      </div>
      <div>
        <label class="required">TEL</label>
        <input type="text" name="tel" value="<%= tel %>">
      </div>
      <div>
        <label class="required">権限</label> 
        <select name="roleId">
          <c:forEach var="role" items="${roles}">
            <option value="${role.roleId}" <c:if test="${role.roleId == 2}">selected</c:if>>${role.roleName}</option>
          </c:forEach>
        </select>
      </div>
      <div>
        <label class="required">PASS</label>
        <input type="password" name="pass" value="<%= pass %>">
      </div>
    </fieldset>
    <button type="submit">確認</button>
  </form>
  <div>
    <a href="menu">メニューに戻る</a>
  </div>
</body>
</html>
