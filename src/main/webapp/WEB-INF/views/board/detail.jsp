<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/12
  Time: 11:43 PM
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
<span id="boardIdInfo" class="d-none">${board.id}</span>

<div class="container w-50">
    <my:alert status="${status}"/>
    <div class="card mb-3">
        <div class="card-header d-flex flex-column align-items-center">
            <h3 class="flex-grow-1 text-center">${board.title}</h3>
            <p class="text-end m-0" style="color: gray;">
                <span>[${board.roll == 1 ? '파티장' : '파티원'}]&nbsp;&nbsp;</span>
                조회수 ${board.viewCount} &nbsp;&nbsp;
                <span><i style="color: gray;" class="heart icon ${member.like ? '' : 'outline'}"></i></span>
                <span id="likeCount" style="color: gray;"></span> &nbsp;
                <span><i style="color: gray;" class="user outline icon"></i></span>
                <span style="color: gray;"></span>
            </p>
        </div>

        <div class="card-body">
            <%--게시글 간단 정보--%>
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span style="font-size: 20px;"><strong>${board.writer}&nbsp;&nbsp;</strong></span>
                        <span style="font-size: 13px; color: gray;"><fmt:formatDate value="${board.inserted}" pattern="yyyy.MM.dd. hh:mm"/></span>
                    </div>
                    <div class="ui icon button circular" data-tooltip="저요!">
                        <i class="user outline icon"></i>
                    </div>
                </div>

            <hr>

            <%--본문--%>
            <pre>${board.body}</pre>
            <hr>

            <%--댓글--%>
            <div class="mb-3"><strong>댓글&nbsp;<span id="commentCount"></span>개</strong></div>

            <%--댓글 리스트--%>
            <div id="commentListBox">

            </div>

            <%--댓글 입력창--%>
            <sec:authorize access="isAuthenticated()">
                <form>
                    <input type="hidden" value="${member.username}" id="usernameInput">
                    <div class="form-floating">
                        <input class="form-control" id="commentInput">
                        <label for="commentInput" style="color: gray"><span id="nicknameInfo">${member.nickname}</span>님 댓글을 남겨보세요.</label>
                    </div>
                    <div class="d-flex justify-content-end">
                        <button type="button" class="btn" style="color: gray;" id="addCommentBtn">등록</button>
                    </div>
                </form>
            </sec:authorize>
        </div>
    </div>


    <%--  버튼  --%>
    <sec:authorize access="isAuthenticated() and #board.memberId == principal.username">
        <div class="d-grid gap-2 d-md-block">
            <a type="button" class="btn btn-outline-secondary" href="/board/modify?boardId=${param.boardId}">
                <i class="fa-regular fa-pen-to-square"></i>
                수정
            </a>
            <button class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                <i class="fa-regular fa-trash-can"></i>
                삭제
            </button>
        </div>
    </sec:authorize>
</div>

<%--삭제 모달--%>
<sec:authorize access="isAuthenticated() and #board.memberId == principal.username">
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="deleteModalLabel">게시물 삭제</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    게시물을 삭제하려면 비밀번호를 입력해주세요.
                    <form id="deleteForm" action="/board/delete" method="post">
                        <div class="mb-3">
                            <label for="passowordInput" class="col-form-label">Password:</label>
                            <input type="text" name="password" class="form-control" id="passowordInput">
                            <input type="hidden" name="boardId" class="form-control" value="${param.boardId}">
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
</sec:authorize>

<my:foot></my:foot>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script src="/js/semantic/semantic.min.js"></script>
<script src="/js/BoardComment.js"></script>
<script src="/js/likeBoard.js"></script>
</body>
</html>
