<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/12
  Time: 10:38 PM
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
    <link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
    <title>Title</title>
</head>
<body>
<my:navBar current="shareRoom"/>

<div class="container">
    <h1 class="text-center">Share Room</h1>
    <my:alert/>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th class="col text-center">#</th>
            <th class="col text-center">제목</th>
            <th class="col text-center">조회수</th>
            <th class="col text-center">작성자</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="list">
            <tr>
                <th class="col text-center">${list.id}</th>
                <td class="col-10 text-center" boardId="${list.id}">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div style="flex: 1; text-align: center;">
                            <a href="/board/detail?boardId=${list.id}">${list.title}</a>
                            <a class="ui basic label ${list.roll == 1 ? 'yellow' : ''}">${list.roll == 1 ? '파티장' : '파티원'}</a>
                            <c:if test="${list.commentCount gt 0}">
                                <span style="color: gray;">[${list.commentCount}]</span>
                            </c:if>
                        </div>
                        <div>
                            <span id="heartBox"><i style="color: gray;" class="heart ${list.likeCheck ? '' : 'outline'} icon"></i></span>
                            <span id="likeCount" style="color: gray;">${list.likeCount != null ? list.likeCount : 0}</span> &nbsp;
                            <span><i style="color: gray;" class="bookmark outline icon"></i></span>
                        </div>
                    </div>
                </td>
                <td class="col text-center">${list.viewCount}</td>
                <td class="col text-center">${list.writer}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="d-flex justify-content-end">
        <a type="button" class="btn btn-outline-secondary" href="/board/addBoard">
            <i class="fa-regular fa-pen-to-square"></i>
            글쓰기
        </a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script src="/js/semantic/semantic.min.js"></script>옴
</body>
</html>
