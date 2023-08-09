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
    <link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
    <title>Title</title>
</head>
<body>
<my:navBar/>
<br>
<br>
<div class="container" style="width: 500px;">
    <my:alert status="${status}"/>
    <div class="ui top attached tabular menu">
        <a class="item active" data-tab="myPage">나의 정보 수정하기</a>
        <a class="item" data-tab="password">비밀번호 수정하기</a>
    </div>
    <%--나의 정보 수정하기 --%>
    <div class="ui bottom attached tab segment active" data-tab="myPage">
        <div>
            <form class="ui form" action="/member/modify" method="post">
                <input name="username" type="hidden" value="${member.username}">
                <div class="field">
                    <label>Phone Number</label>
                    <input name="phoneNum" type="text" value="${member.phoneNum}">
                </div>
                <div class="field">
                    <label>Address</label>
                    <div class="ui action input">
                        <input type="text" name="address" readonly id="addressInput" value="${member.address}" style="width: 364.32px;">
                        <div class="ui grey submit button" onclick="execDaumPostcode()">Search</div>
                        <%--다음 주소 찾기 input--%>
                        <input type="hidden" id="sample4_roadAddress" placeholder="도로명주소">
                        <input type="hidden" id="sample4_jibunAddress" placeholder="지번주소">
                        <span id="guide" style="color:#999;display:none"></span>
                        <input type="hidden" id="sample4_detailAddress" placeholder="상세주소">
                        <input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
                    </div>
                </div>
                <button type="submit" class="ui button">수정</button>
            </form>
        </div>
    </div>

    <%--비밀번호 수정하기--%>
    <div class="ui bottom attached tab segment" data-tab="password">
        <div>
            <form action="/member/modify" method="post" class="ui form">
                <input name="username" type="hidden" value="${member.username}">
                <div class="field" id="pwBox">
                    <label>새로운 비밀번호</label>
                    <input name="password" type="password" class="pwInput" id="pw">
                </div>
                <div class="field" id="checkPwBox">
                    <label>비밀번호 확인</label>
                    <input type="password" class="pwInput" id="checkPw">
                    <div class="valid-feedback pwCheck">
                        비밀번호가 일치합니다.
                    </div>
                    <div class="invalid-feedback pwCheck">
                        비밀번호가 일치하지 않습니다.
                    </div>
                </div>
                <button type="submit" class="ui button d-none" id="pwBtn">수정</button>
            </form>
        </div>
    </div>
</div>

<my:foot></my:foot>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/modifyCheck.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/semantic/semantic.js"></script>
<script>
    $('.menu .item')
        .tab()
    ;
</script>
</body>
</html>
