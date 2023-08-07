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
    <link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
    <title>Title</title>
</head>
<body>
<my:navBar current="myPage"/>
<br>
<br>
<div class="container" style="width: 500px;">
    <my:alert status="${status}"/>
    <div class="ui top attached tabular menu">
        <a class="item active" data-tab="myPage">나의 정보</a>
    </div>
    <%-- 아이디 찾기 --%>
    <div class="ui bottom attached tab segment active" data-tab="myPage">
        <div id="findIdBox">
            <form class="ui form">
                <div class="field">
                    <label>ID</label>
                    <input readonly type="email" value="${member.username}">
                </div>
                <div class="field">
                    <label>Email</label>
                    <input readonly type="text" value="${member.email}">
                </div>
                <div class="field">
                    <label>Name</label>
                    <input readonly type="text" value="${member.name}">
                </div>
                <div class="field">
                    <label>NickName</label>
                    <input readonly type="text" value="${member.nickname}">
                </div>
                <div class="field">
                    <label>Phone Number</label>
                    <input readonly type="text" value="${member.phoneNum}">
                </div>
                <div class="field">
                    <label>Address</label>
                    <input readonly type="text" value="${member.address}">
                </div>
                <a class="ui button" href="/member/modify">수정</a>
                <button class="ui button" type="button" data-bs-toggle="modal" data-bs-target="#deleteModal">탈퇴</button>
            </form>
        </div>
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
                <button type="submit" form="deleteForm" class="btn btn-outline-danger" data-bs-dismiss="modal">탈퇴</button>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/semantic/semantic.js"></script>
<script>
    $('.menu .item')
        .tab()
    ;
</script>
</body>
</html>
