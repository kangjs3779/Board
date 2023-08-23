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
            <h3 class="flex-grow-1 text-center">
                ${board.title}&nbsp;&nbsp;
                <%--ott 구분점--%>
                <a class="ui empty circular label" style="background-color: ${ott.color};"></a>
                <c:if test="${ott.limitedAttendance == mateCount}">
                    <%--모집완료 체크--%>
                    <i class="check icon"></i>
                </c:if>
            </h3>
            <p class="text-end m-0" style="color: gray;">
                <%--조회수 조회--%>
                <span>[${board.roll == 1 ? '파티장' : '파티원'}]&nbsp;&nbsp;</span>
                조회수 ${board.viewCount} &nbsp;&nbsp;
                <%--좋아요 조회--%>
                <span><i style="color: gray;" class="heart icon ${check.like ? '' : 'outline'}"></i></span>
                <span id="likeCount" style="color: gray;"></span> &nbsp;
                <c:if test="${board.roll == 1}">
                    <%--모인 파티원 인원 수 조회--%>
                    <span><i style="color: gray;" class="user ${check.mate ? '' : 'outline'} icon"></i></span>
                    <span style="color: gray;" class="countShare"></span>
                </c:if>
            </p>
        </div>

        <div class="card-body">
            <%--게시글 간단 정보--%>
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <span style="font-size: 20px;"><strong>${board.writer}&nbsp;&nbsp;</strong></span>
                    <span style="font-size: 13px; color: gray;"><fmt:formatDate value="${board.inserted}" pattern="yyyy.MM.dd. hh:mm"/></span>
                </div>
                <sec:authorize access="isAuthenticated()">
                    <c:if test="${board.roll == 1 and board.memberId != member.username}">
                        <%--파티장의 게시글이면서 본인이 쓴 게시글이 아닐 때--%>
                        <c:if test="${ott.limitedAttendance > mateCount}">
                            <%--모집인원이 다 안찼을 때--%>
                            <%--저요 버튼--%>
                            <div class="ui blue ${check.mate ? '' : 'basic'} icon button circular" data-tooltip="저요!" id="addMateBtn" data-bs-toggle="modal" data-bs-target="#addMateModal">
                                <i class="user outline icon"></i>
                                <span class="countShare"></span>
                            </div>
                        </c:if>
                        <c:if test="${ott.limitedAttendance == mateCount}">
                            <%--모집인원이 다 찼을 때--%>
                            <button class="ui basic button" data-tooltip="모집 완료!">
                                <i class="icon user"></i>
                                모집 완료!
                            </button>
                        </c:if>
                    </c:if>
                    <c:if test="${board.roll == 1 and board.memberId == member.username}">
                        <%--파티장의 게시글이면서 본인이 쓴 게시글일 때--%>
                        <%--파티원 목록 보기--%>
                        <div>
                            <c:forEach items="${mates}" var="mate" varStatus="num">
                                <img src="/images/사람${num.index + 1}.png" class="ui avatar image mateInfo">
                                <div class="ui flowing popup top left transition hidden" style="width: 180px;">
                                    <div class="ui center aligned grid">
                                        <div class="column">
                                            <h4 class="ui header">${mate.nickname}님</h4>
                                            <p>참여 신청을 완료했습니다!</p>
                                            <button class="ui button approveBtn" mate-id="${mate.id}">${mate.approve == 1 ? '참여 승인' : '승인 완료'}</button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </sec:authorize>
            </div>

            <hr>

            <%--본문--%>
            <pre>${board.body}</pre>
            <hr>

            <%--구독 정보--%>
            <form class="ui form">
                <div class="field">
                    <label style="color: gray;">Ott 서비스</label>
                    <input readonly type="text" value="${ott.ott}" id="ottName">
                </div>
                <div class="field">
                    <label style="color: gray;">시작 날짜</label>
                    <input type="text" readonly value="${board.startDate}">
                </div>
                <div class="field">
                    <label style="color: gray;">끝나는 날짜</label>
                    <input type="text" readonly value="${board.endDate}">
                </div>
            </form>
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
        <c:if test="${mateCount == 0}">
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
        </c:if>
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

<!-- 메이트 추가 모달 -->
<div class="modal fade" id="addMateModal" tabindex="-1" aria-labelledby="addMateModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="addMateModalLabel">${ott.ott}구독에 참여하시겠습니까?</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <img class="ui small centered rounded image" src="http://bucket0503-qkskkfkk.s3.ap-northeast-2.amazonaws.com/ShareMate/ott/${ott.id}/${ott.logo}">
                <br>
                한 달 요금은 <span style="color: red;">${ott.costPerPerson}원</span> 입니다.<br>
                시작 날짜는 <span style="color: red;">${board.startDate}부터 ${board.endDate}</span>입니다.<br>
                최대 <span style="color: #5a30b5"><strong>${ott.limitedAttendance}명</strong></span>을 모집할 수 있습니다.<br>
                현재 <strong style="color: #5a30b5"><span class="countShare"></span>명</strong>이 모집되었습니다.
            </div>
            <!-- 기본 정보 -->
            <div>
                <input type="hidden" value="${ott.id}" id="ottId">
                <input type="hidden" value="${param.boardId}" id="boardId">
                <input type="hidden" value="${member.username}" id="memberId">
            </div>
            <div class="modal-footer">
                <button type="button" class="ui basic button" data-bs-dismiss="modal">취소</button>
                <button type="button" class="ui basic button" id="addMateModalBtn" data-bs-dismiss="modal">
                    <i class="icon user"></i>
                    ${check.mate ? '참여 취소' : '참여 신청'}
                </button>
            </div>
        </div>
    </div>
</div>

<footer>
    <my:foot></my:foot>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script src="/js/semantic/semantic.min.js"></script>
<script src="/js/BoardComment.js"></script>
<script src="/js/likeBoard.js"></script>
<script src="/js/addMate.js"></script>

<script>
    $('.mateInfo')
        .popup({
            on: 'click',
            position   : 'bottom center'
        })
    ;
</script>
</body>
</html>
