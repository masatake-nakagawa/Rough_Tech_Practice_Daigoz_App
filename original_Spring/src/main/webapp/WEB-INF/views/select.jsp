<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
<meta charset="UTF-8">
<title>検索画面</title>
<link href="commons.css" rel="stylesheet">
</head>
<body>
  <p>
    検索したいデータ情報を入力してください<br> 
    ※全て空白の場合は全検索を行います
  </p>
  <p class="error">${errorMessage}</p>
  <form action="list" method="get">
    <fieldset>
      <div>
        <label>名前</label>
        <input type="text" name="userName">
      </div>
      <div>
        <label>TEL</label>
        <input type="text" name="tel">
      </div>
    </fieldset>
    <button type="submit">検索</button>
  </form>
  <div>
    <a href="menu">メニューに戻る</a>
  </div>
</body>
</html>
