<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TOP画面</title>
<link href="main.css" rel="stylesheet">
<style>
  body {
    background-image: url('resources/images/lightfieldstudios190326107.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    height: 100vh; /* 画面全体の高さを使用 */
    margin: 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
</style>
<script>
  function removeBackground() {
    document.body.style.backgroundImage = 'none';
  }
</script>
</head>
<body>
  <div class="centered-header">
    <h1>扇武館<br>情報共有アプリ</h1>
  </div>
  <div class="btn-container">
    <a href="login" class="btn" onclick="removeBackground()">始める</a>
  </div>
</body>
</html>
