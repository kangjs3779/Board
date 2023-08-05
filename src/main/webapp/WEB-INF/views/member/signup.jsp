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
<my:navBar current="join"/>

<div class="container w-25">
    <h1>회원 가입</h1>
    <my:alert status="${status}"/>
    <form id="joinForm" method="post">
        <div class="input-group mb-3">
            <label class="input-group-text" for="usernameInput">아이디</label>
            <input type="text" required class="form-control" name="username" id="usernameInput" placeholder="Username">
            <button class="btn btn-outline-secondary" type="button" id="usernameCheckBtn">중복확인</button>
            <div class="valid-feedback">
                사용가능한 아이디입니다.
            </div>
            <div class="invalid-feedback">
                사용 불가능한 아이디 입니다.
            </div>
        </div>
        <div class="input-group mb-3">
            <label class="input-group-text" for="pwInput">비밀번호</label>
            <input type="text" required name="password" class="form-control pw" id="pwInput" placeholder="Password">
        </div>
        <div class="input-group mb-3">
            <label class="input-group-text" for="pwCheckInput">비밀번호 확인</label>
            <input type="text" required name="password" class="form-control pw" id="pwCheckInput" placeholder="Password Check">
            <div class="valid-feedback pwCheck">
                비밀번호가 일치합니다.
            </div>
            <div class="invalid-feedback pwCheck">
                비밀번호가 일치하지 않습니다.
            </div>
        </div>
        <div class="input-group mb-3">
            <label class="input-group-text" for="emailInput">이메일</label>
            <input type="email" required name="email" class="form-control" id="emailInput" placeholder="email">
            <button class="btn btn-outline-secondary" type="button" id="checkEmailBtn" disabled>중복확인</button>
            <div class="valid-feedback emailCheckComment">
            </div>
            <button class="btn btn-outline-secondary d-none" id="veriCodeSendBtn" type="button">인증 번호 발송</button>
            <div class="invalid-feedback emailCheckComment">
            </div>
        </div>
        <div class="input-group mb-3 d-none" id="verificationCodeInput">
            <label class="input-group-text">인증번호</label>
            <input type="text" required class="form-control" id="veriCodeInput" placeholder="인증번호를 입력해주세요.">
            <button class="btn btn-outline-secondary" id="veriCodeBtn" type="button">인증</button>
            <div class="valid-feedback veriCodeCheckComment">
            </div>
            <div class="invalid-feedback veriCodeCheckComment">
            </div>
        </div>
        <div class="input-group mb-3">
            <label class="input-group-text" for="phoneNumInput">전화번호</label>
            <input type="text" required name="phoneNum" class="form-control" id="phoneNumInput" placeholder="'-'를 빼고 입력해주세요.">
        </div>
        <div class="input-group mb-3">
            <label class="input-group-text" for="nicknameInput">닉네임</label>
            <input type="text" required name="nickname" class="form-control" id="nicknameInput" placeholder="nickname">
            <button class="btn btn-outline-secondary" id="nicknameBtn" type="button">중복확인</button>
            <div class="valid-feedback">
                사용가능한 닉네임입니다.
            </div>
            <div class="invalid-feedback">
                이미 사용중인 닉네임입니다.
            </div>
        </div>
        <%--주소--%>
        <div class="input-group mb-3">
            <label class="input-group-text" for="addressInput">주소</label>
            <input type="text" readonly required name="address" class="form-control" id="addressInput" placeholder="우편번호 찾기 버튼을 눌러주세요.">
            <button class="btn btn-outline-secondary" type="button" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
        </div>
        <%--다음 주소 찾기 input--%>
        <input type="hidden" id="sample4_roadAddress" placeholder="도로명주소">
        <input type="hidden" id="sample4_jibunAddress" placeholder="지번주소">
        <span id="guide" style="color:#999;display:none"></span>
        <input type="hidden" id="sample4_detailAddress" placeholder="상세주소">
        <input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
    </form>

    <button class="btn btn-outline-secondary" id="joinBtn" type="submit" form="joinForm" disabled>
        JOIN
    </button>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/signupCheck.js"></script>
<script src="/js/address.js"></script>
</body>
</html>
