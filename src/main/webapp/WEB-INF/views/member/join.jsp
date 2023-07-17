<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/15
  Time: 11:46 PM
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

<div class="container w-25">
    <h1>회원 가입 페이지</h1>
    <my:alert status="${status}"/>
    <form id="joinForm" method="post">
        <div class="input-group mb-3">
            <label class="input-group-text" for="usernameInput">아이디</label>
            <input type="text" required class="form-control" name="username" id="usernameInput" placeholder="Username">
            <button class="btn btn-outline-secondary" type="button">중복확인</button>
        </div>
        <div class="input-group mb-3">
            <label class="input-group-text" for="pwInput">비밀번호</label>
            <input type="text" required name="password" class="form-control" id="pwInput" placeholder="Password">
        </div>
        <div class="input-group mb-3">
            <label class="input-group-text" for="emailInput">이메일</label>
            <input type="email" required name="email" class="form-control" id="emailInput" placeholder="email">
        </div>
        <%--        <div class="input-group mb-3">--%>
        <%--            <label class="input-group-text" for="pwCheckInput">비밀번호 확인</label>--%>
        <%--            <input type="text" class="form-control" id="pwCheckInput" placeholder="Password Check" aria-label="Username" aria-describedby="basic-addon1">--%>
        <%--        </div>--%>
        <div class="input-group mb-3">
            <label class="input-group-text" for="idNumberInput">주민번호</label>
            <input type="text" required name="idNumber" class="form-control" id="idNumberInput" placeholder="주민번호">
        </div>
        <div class="input-group mb-3">
            <label class="input-group-text" for="nicknameInput">닉네임</label>
            <input type="text" required name="nickname" class="form-control" id="nicknameInput" placeholder="nickname">
        </div>
        <div class="input-group mb-3">
            <label class="input-group-text" for="addressInput">주소</label>
            <input type="text" required name="address" class="form-control" id="addressInput" placeholder="address">
        </div>
    </form>

    <button class="btn btn-outline-secondary" type="submit" form="joinForm">
        JOIN
    </button>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>
