<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録確認画面</title>
<link href="commons.css" rel="stylesheet">
</head>
<body>
  <p>これでよろしいですか？</p>

  <% String errorMessage = (String) request.getAttribute("errorMessage");
     if (errorMessage != null && !"".equals(errorMessage)) { %>
    <p class="error"><%= errorMessage %></p>
  <% } %>

<form action="insertConfirm" method="post">
    <fieldset class="label-130">
        <div>
            <label>ID</label>
            <input type="text" name="loginId" value="<%= request.getAttribute("loginId") %>" readonly="">
        </div>
        <div>
            <label>名前</label>
            <input type="text" name="userName" value="<%= request.getAttribute("userName") %>" readonly="">
        </div>
        <div>
            <label>TEL</label>
            <input type="text" name="tel" value="<%= request.getAttribute("tel") %>" readonly="">
        </div>
        <div>
            <label>権限</label>
            <input type="text" name="roleName" value="<%= "2".equals(request.getAttribute("roleId")) ? "一般" : "管理者" %>" readonly="">
            <input type="hidden" name="roleId" value="<%= request.getAttribute("roleId") %>">
        </div>
        <div>
            <label>PASS（再入力）</label>
            <input type="password" name="rePass">
        </div>
        <div>
            <input type="password" name="pass" value="<%= request.getAttribute("pass") %>" hidden>
        </div>
    </fieldset>
    <div>
        <button type="submit">登録</button>
        <button type="button" onclick="location.href='insert?loginId=<%= request.getAttribute("loginId") %>&userName=<%= request.getAttribute("userName") %>&tel=<%= request.getAttribute("tel") %>&roleId=<%= request.getAttribute("roleId") %>&pass=<%= request.getAttribute("pass") %>';">戻る</button>
    </div>
</form>

  <div>
    <a href="menu">メニューに戻る</a>
  </div>
</body>
</html>
