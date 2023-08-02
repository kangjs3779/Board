<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/26
  Time: 1:10 AM
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
<my:navBar/>
<div class="container">
    <h1 class="text-center">내가 쓴 게시글 목록</h1>
    <my:alert/>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th class="col text-center"><input type="checkbox" class="text-center" id="fullCheckBtn"></th>
            <th class="col text-center">제목</th>
            <th class="col text-center">조회수</th>
            <th class="col text-center">작성자</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${board}" var="list">
            <tr>
                <th class="col text-center"><input type="checkbox" class="checkBtn" value="${list.id}"></th>
                <td class="col-10 text-center titleLink" boardId="${list.id}">
                    <a href="/board/detail?boardId=${list.id}">${list.title}</a>
                    <span class="badge text-bg-${list.roll == 1 ? 'warning' : 'success'}">${list.roll == 1 ? '파티장' : '파티원'}</span>
                    <c:if test="${list.commentCount gt 0}">
                        <span style="color: gray;">[${list.commentCount}]</span>
                    </c:if>
                </td>
                <td class="col text-center">${list.viewCount}</td>
                <td class="col text-center">${list.writer}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="d-flex justify-content-end gap-2 ">
        <button type="button" class="btn btn-outline-danger" id="deleteBtn" disabled>
            <i class="fa-regular fa-trash-can"></i>
            삭제하기
        </button>
        <a type="button" class="btn btn-outline-secondary" href="/board/addBoard">
            <i class="fa-regular fa-pen-to-square"></i>
            글쓰기
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="/js/myBoard.js"></script>
<script src="/js/viewCount.js"></script>
</body>
</html>
