<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/17
  Time: 12:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title>Title</title>
</head>
<body>
<my:navBar/>
<div class="container w-50">
    <h1>${member.nickname}님의 회원정보입니다.</h1>
    <form action="/member/modify" id="modifyForm" method="post">
        <div class="mb-3 row">
            <label for="usernameInput" class="col-sm-2 col-form-label">ID</label>
            <div class="col-sm-10">
                <input type="text" readonly class="form-control" name="username" id="usernameInput" value="${member.username}">
            </div>
        </div>
        <div class="mb-3 row">
            <label for="nicknameInput" class="col-sm-2 col-form-label">NickName</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="nickname" id="nicknameInput" value="${member.nickname}">
            </div>
        </div>
        <div class="mb-3 row">
            <label for="IDNumberInput" class="col-sm-2 col-form-label">IDNumber</label>
            <div class="col-sm-10">
                <input type="text" readonly class="form-control" name="idNumber" id="IDNumberInput" value="${member.idNumber}">
            </div>
        </div>
        <div class="mb-3 row">
            <label for="addressInput" class="col-sm-2 col-form-label">Address</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="address" id="addressInput" value="${member.address}">
            </div>
        </div>
        <div class="mb-3 row">
            <label for="emailInput" class="col-sm-2 col-form-label">Email</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="email" id="emailInput" value="${member.email}">
            </div>
        </div>
    </form>

    <div class="d-grid gap-2 d-md-block">
        <button class="btn btn-outline-secondary" type="submit" form="modifyForm">Modify</button>
        <a class="btn btn-outline-secondary" href="/member/myPage">Back</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>
