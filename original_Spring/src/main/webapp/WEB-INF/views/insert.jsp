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
    String rePass = request.getParameter("rePass") != null ? request.getParameter("rePass") : ""; // 追加
    String roleId = request.getParameter("roleId") != null ? request.getParameter("roleId") : ""; 
    String mail = request.getParameter("mail") != null ? request.getParameter("mail") : ""; // 追加
    String errorMessage = (String) request.getAttribute("errorMessage");
    List<Role> roles = (List<Role>) request.getAttribute("roles");
%>
<!DOCTYPE html>
<html><head>
<meta charset="UTF-8">
<title>登録画面</title>
<link href="main.css" rel="stylesheet">
</head>
<body>
  <p>
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
        <label class="required">メールアドレス</label>
        <input type="text" name="mail" value="<%= mail %>"> <!-- 修正 -->
      </div>
      <div>
        <label class="required">電話番号</label>
        <input type="text" name="tel" value="<%= tel %>">
      </div>
      <div>
        <label class="required">パスワード</label>
        <input type="password" name="pass" value="<%= pass %>">
      </div>
      <div>
        <label class="required">パスワード（再入力）</label> <!-- 追加 -->
        <input type="password" name="rePass" value="<%= rePass %>"> <!-- 追加 -->
      </div>
      <div>
        <label class="required">権限</label> 
        <select name="roleId">
          <c:forEach var="role" items="${roles}">
            <option value="${role.roleId}" <c:if test="${role.roleId == 2}">selected</c:if>>${role.roleName}</option>
          </c:forEach>
        </select>
      </div>
    </fieldset>
    <button type="submit">登録</button>
  </form>
  <div>
    <a href="userMenu">ユーザーメニューに戻る</a>
  </div>
</body>
</html>

