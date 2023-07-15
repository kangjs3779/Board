<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/13
  Time: 12:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title>Title</title>
</head>
<body>
<div class="container w-25">
    <h1>로그인 페이지</h1>
    메세지 : ${message}
    <form id="loginForm" method="post">
        <div class="mb-3">
            <label for="idInput" class="form-label">ID</label>
            <input type="text" name="id" class="form-control" id="idInput">
        </div>
        <div class="mb-3">
            <label for="pwInput" class="form-label">Password</label>
            <input type="text" name="password" class="form-control" id="pwInput">
        </div>
    </form>

    <div class="d-grid gap-2 d-md-block">
        <button class="btn btn-outline-secondary" type="submit" form="loginForm">login</button>
        <a class="btn btn-outline-secondary" href="/member/join">join</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>
