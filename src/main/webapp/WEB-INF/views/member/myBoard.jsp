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
    <link rel="stylesheet" type="text/css" href="/js/semantic/semantic.min.css">
    <title>Title</title>
</head>
<body>
<my:navBar/>
<%--등록된 게시글이 있으면--%>
<c:if test="${not empty boards}">
    <div class="container">
        <h1 class="text-center">내가 쓴 게시글 목록</h1>
        <my:alert/>
        <div class="container">
                <%--검색 버튼--%>
            <sec:authorize access="isAuthenticated()">
                <sec:authentication property="principal.username" var="username"/>
            </sec:authorize>
            <c:forEach items="${otts}" var="ott">
                <a class="ui empty circular label ottSearchBtn ottColor" ottColor="${ott.color}" style="background-color: ${ott.color}" ottId="${ott.id}" username="${username}" page="myboard"></a>
                <span class="ottSearchBtn" ottId="${ott.id}" page="myboard" page="myboard">${ott.ott}</span>
            </c:forEach>
            <a class="ui empty circular label ottSearchBtn" ottId="0" username="${username}" page="myboard"></a>
            <span class="ottSearchBtn" ottId="0" username="${username}" page="myboard">초기화</span>
        </div>

        <table class="table table-bordered">
            <thead>
            <tr>
                <th class="col text-center"><input type="checkbox" class="text-center" id="fullCheckBtn"></th>
                <th class="col text-center">제목</th>
                <th class="col text-center">조회수</th>
                <th class="col text-center">작성자</th>
            </tr>
            </thead>
            <tbody id="boardListBox">
            <c:forEach items="${boards}" var="list">
                <tr>
                    <th class="col text-center"><input type="checkbox" class="checkBtn" boardId="${list.id}"></th>
                    <td class="col-10 text-center" boardId="${list.id}">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div style="flex: 1; text-align: center;">
                                <a style="color: black;" href="/board/detail?boardId=${list.id}">${list.title}</a>
                                <c:if test="${list.commentCount gt 0}">
                                    <span style="color: gray;">[${list.commentCount}]</span>
                                </c:if>
                                    <%--파티장 파티원 구분--%>
                                <a class="ui basic label ${list.roll == 1 ? 'yellow' : ''}">${list.roll == 1 ? '파티장' : '파티원'}</a>
                                    <%--ott 구분 점--%>
                                <a class="ui empty circular label ottService" ottId="${list.ottId}"></a>
                            </div>
                            <div>
                                <span id="heartBox"><i style="color: gray;" class="heart ${list.likeCheck ? '' : 'outline'} icon"></i></span>
                                <span id="likeCount" style="color: gray;">${list.likeCount != null ? list.likeCount : 0}</span> &nbsp;
                                <i style="color: gray;" class="user outline icon"></i>
                            </div>
                        </div>
                    </td>
                    <td class="col text-center">${list.viewCount}</td>
                    <td class="col text-center">${list.writer}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="d-flex justify-content-end gap-2 ">
            <button type="button" class="btn btn-outline-danger" id="deleteBtn" data-bs-toggle="modal" data-bs-target="#deleteModal" disabled>
                <i class="fa-regular fa-trash-can"></i>
                삭제하기
            </button>
            <a type="button" class="btn btn-outline-secondary" href="/board/addBoard">
                <i class="fa-regular fa-pen-to-square"></i>
                글쓰기
            </a>
        </div>
    </div>
</c:if>

<%--등록된 게시글이 없으면--%>
<c:if test="${empty boards}">
    <br>
    <br>
    <br>
    <div class="container w-50">
        <h1 class="ui center aligned header">
            등록된 게시글이 없습니다.
        </h1>
        <br>
        <div class="d-flex justify-content-center ">
            <a type="button" class="btn btn-outline-secondary" href="/board/addBoard">
                <i class="fa-regular fa-pen-to-square"></i>
                글쓰기
            </a>
        </div>
    </div>
</c:if>
<%--삭제하기 모달 --%>
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="deleteModalLabel">게시물 삭제</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                게시물을 삭제하려면 비밀번호를 입력해주세요.
                <div class="mb-3">
                    <label for="passwordInput" class="col-form-label">Password:</label>
                    <input type="password" class="form-control" id="passwordInput">
                    <sec:authentication property="principal.username" var="username"/>
                    <input type="hidden" id="usernameInput" class="form-control" value="<c:out value='${username}' />">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" id="deleteModalBtn" class="btn btn-outline-danger" data-bs-dismiss="modal">삭제</button>
            </div>
        </div>
    </div>
</div>

<my:foot></my:foot>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script src="/js/semantic/semantic.min.js"></script>
<script src="/js/myBoard.js"></script>
<script src="/js/ott.js"></script>
</body>
</html>
