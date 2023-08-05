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
<my:navBar/>

<div class="container w-50">
    <h1>${member.nickname}님 수정 정보를 입력해주세요.</h1>
    <my:alert status="${status}"/>
    <form action="/member/modify" id="modifyForm" method="post">
        <div class="mb-3 row">
            <div class="col-sm-10">
                <input type="hidden" readonly class="form-control" name="username" id="usernameInput" value="${member.username}">
            </div>
        </div>
        <div class="mb-3 row">
            <label for="nicknameInput" class="col-sm-2 col-form-label">NickName</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="nickname" id="nicknameInput" value="${member.nickname}">
            </div>
        </div>
        <%--        <div class="mb-3 row">--%>
        <%--            <label for="addressInput" class="col-sm-2 col-form-label">Address</label>--%>
        <%--            <div class="col-sm-10">--%>
        <%--                <input type="text" class="form-control" name="address" id="addressInput" value="${member.address}">--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <div class="mb-3 row">
            <label for="emailInput" class="col-sm-2 col-form-label">Email</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="email" id="emailInput" value="${member.email}">
            </div>
        </div>
        <%--주소--%>
        <div class="mb-3 row">
            <label class="col-sm-2 col-form-label" for="addressInput">Address</label>
            <div class="col-sm-10 input-group">
                <input type="text" readonly required name="address" class="form-control" id="addressInput" value="${member.address}" >
                <button class="btn btn-outline-secondary" type="button" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
            </div>
        </div>
        <%--다음 주소 찾기 input--%>
        <input type="hidden" id="sample4_roadAddress" placeholder="도로명주소">
        <input type="hidden" id="sample4_jibunAddress" placeholder="지번주소">
        <span id="guide" style="color:#999;display:none"></span>
        <input type="hidden" id="sample4_detailAddress" placeholder="상세주소">
        <input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
    </form>

    <div class="d-grid gap-2 d-md-block">
        <button class="btn btn-outline-secondary" type="submit" form="modifyForm">Modify</button>
        <a class="btn btn-outline-secondary" href="/member/myPage">Back</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/address.js"></script>
</body>
</html>
