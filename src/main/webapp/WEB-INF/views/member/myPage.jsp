<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/16
  Time: 11:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <title>Title</title>
</head>
<body>
<my:navBar current="myPage"/>

<%--회원 정보--%>
<div class="container w-50">
    <h1>${member.nickname}님의 회원정보입니다.</h1>
    <my:alert status="${status}"/>
    <div class="mb-3 row">
        <label for="usernameInput" class="col-sm-2 col-form-label">ID</label>
        <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" id="usernameInput" value="${member.username}">
        </div>
    </div>
    <div class="mb-3 row">
        <label for="nicknameInput" class="col-sm-2 col-form-label">NickName</label>
        <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" id="nicknameInput" value="${member.nickname}">
        </div>
    </div>
    <div class="mb-3 row">
        <label for="phoneNumInput" class="col-sm-2 col-form-label">phone number</label>
        <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" id="phoneNumInput" value="${member.phoneNum}">
        </div>
    </div>
    <div class="mb-3 row">
        <label for="addressInput" class="col-sm-2 col-form-label">Address</label>
        <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" id="addressInput" value="${member.address}">
        </div>
    </div>
    <div class="mb-3 row">
        <label for="emailInput" class="col-sm-2 col-form-label">Email</label>
        <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" id="emailInput" value="${member.email}">
        </div>
    </div>

    <%--  버튼  --%>
    <div class="d-grid gap-2 d-md-block">
        <a class="btn btn-outline-secondary" href="/member/myBoard">내가 쓴 게시글</a>
        <a class="btn btn-outline-secondary" href="/member/modify">Modify</a>
        <button class="btn btn-outline-secondary" type="button" data-bs-toggle="modal" data-bs-target="#deleteModal">Delete</button>
    </div>
</div>

<%--삭제 모달--%>
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="deleteModalLabel">회원 탈퇴</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                회원 탈퇴를 하시려면 비밀번호를 입력해주세요.
                <form id="deleteForm" action="/member/delete" method="post">
                    <div class="mb-3">
                        <label for="passowordInput" class="col-form-label">Password:</label>
                        <input type="text" name="password" class="form-control" id="passowordInput">
                        <input type="hidden" name="username" class="form-control" value="${member.username}">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="deleteForm" class="btn btn-outline-danger" data-bs-dismiss="modal">Delete</button>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</body>
</html>
