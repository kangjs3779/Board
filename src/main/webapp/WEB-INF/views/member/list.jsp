<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/24
  Time: 10:12 AM
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <title>Title</title>
</head>
<body>
<my:navBar current="list"/>
<div class="container">
    <h1 class="text-center">회원 정보</h1>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th class="col text-center">#</th>
            <th class="col text-center">아이디</th>
            <th class="col text-center">닉네임</th>
            <th class="col text-center">이메일</th>
            <th class="col text-center">주소</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="list" varStatus="num">
            <tr>
                <th class="col text-center">${num.index + 1}</th>
                <td class="col text-center titleLink">
                    ${list.username}
                </td>
                <td class="col text-center">${list.nickname}</td>
                <td class="col text-center">${list.email}</td>
                <td class="col text-center">${list.address}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<my:foot></my:foot>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>
