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
    <style>
        .scrollable-box {
            border: 1px solid rgba(34, 36, 38, .15);
            border-radius: 0.28571429rem;
            height: 200px;
            overflow: auto; /* 스크롤 활성화 */
        }

        .content {
            padding: 10px; /* 내용 여백 */
        }

        .subscription {
            margin-bottom: 10px; /* 항목 간 여백 */
        }

        .service {
            font-weight: bold;
            margin-bottom: 0px;
        }

        .date {
            color: gray;
            margin-bottom: 0px;
        }
    </style>
</head>
<body>
<my:navBar current="myPage"/>
<br>
<br>
<div class="container" style="width: 500px;">
    <my:alert status="${status}"/>
    <div class="ui top attached tabular menu">
        <a class="item active" data-tab="myPage">나의 정보</a>
        <a class="item" data-tab="mateInfo">파티원 정보</a>
        <a class="item" data-tab="leaderInfo">파티장 정보</a>
    </div>
    <%-- 나의 정보 --%>
    <div class="ui bottom attached tab segment active" data-tab="myPage">
        <div id="findIdBox">
            <form class="ui form">
                <div class="field">
                    <label>ID</label>
                    <input readonly type="text" value="${member.username}" id="memberIdInput">
                </div>
                <div class="field">
                    <label>Email</label>
                    <input readonly type="text" value="${member.email}" id="emailInput">
                </div>
                <div class="field">
                    <label>Name</label>
                    <input readonly type="text" value="${member.name}" id="nameInput">
                </div>
                <div class="field">
                    <label>Nick Name</label>
                    <input readonly type="text" value="${member.nickname}">
                </div>
                <div class="field">
                    <label>Phone Number</label>
                    <input readonly type="text" value="${member.phoneNum}" id="phoneInput">
                </div>
                <div class="field">
                    <label>Address</label>
                    <input readonly type="text" value="${member.address}" id="addressInput">
                </div>
                <a class="ui primary basic button" href="/member/myBoard">나의 게시글</a>
                <button type="button" class="ui orange basic button" data-bs-toggle="modal" data-bs-target="#joinCheckModal">참여 서비스</button>
                <a class="ui secondary basic button" href="/member/modify">수정</a>
                <button class="ui negative basic button" type="button" data-bs-toggle="modal" data-bs-target="#deleteModal">탈퇴</button>
            </form>
        </div>
    </div>

    <%-- 파티원 정보 --%>
    <div class="ui bottom attached tab segment" data-tab="mateInfo">
        <form class="ui form">
            <div class="field">
                <label>결제 정보</label>
                <div class="scrollable-box">
                    <div class="content">
                        <div class="subscription">
                            <c:if test="${not empty otts}">
                                <%--참여 중인 ott 서비스가 있으면--%>
                                <c:forEach items="${otts}" var="ott">
                                    <c:if test="${ott.approve eq 3}">
                                        <%--결제완료 단계이면, approve = 3이면--%>
                                        <p class="service">구독 서비스 : ${ott.ott}<span style="color: darkred;">[결제완료]</span></p>
                                        <p class="date">결제 금액 : ${ott.costPerPerson}원</p>
<%--                                        <p class="date">결제 날짜 : 23.01.01</p>--%>
                                        <hr>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </div>

                    </div>
                </div>
            </div>
            <div class="field">
                <label>승인 대기</label>
                <div class="scrollable-box" style="height: 100px;">
                    <div class="content">
                        <div class="subscription">
                            <c:if test="${not empty otts}">
                                <%--참여 중인 ott 서비스가 있으면--%>
                                <c:forEach items="${otts}" var="ott">
                                    <c:if test="${ott.approve eq 1}">
                                        <%--승인대기 단계이면, approve = 2이면--%>
                                        <label class="form-check-label">
                                            <div style="display: flex; align-items: center;">
                                                <a class="ui empty circular label ottService ottColor" ottId="${ott.id}" ottColor="${ott.color}"></a>
                                                <a href="/board/detail?boardId=${ott.boardId}" style="margin-left: 10px;">${ott.ott}</a>
                                            </div>
                                        </label>
                                        <br>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty otts}">
                                <%--참여 중인 ott 서비스가 없으면--%>
                                <h3 class="ui header center aligned">참여 중인 서비스가 없습니다.</h3>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <div class="field">
                <label>결제 요청</label>
                <div class="scrollable-box" style="height: 100px;">
                    <div class="content">
                        <div class="subscription">
                            <c:if test="${not empty otts}">
                                <%--참여 중인 ott 서비스가 있으면--%>
                                <c:forEach items="${otts}" var="ott">
                                    <c:if test="${ott.approve eq 2}">
                                        <%--승인완료/결제요청 단계이면, approve = 2이면--%>
                                        <label class="form-check-label" for="ott${ott.id}">
                                            <div style="display: flex; align-items: center;">
                                                <div class="form-check" style="margin-left: auto;">
                                                    <input class="form-check-input total" type="checkbox" value="${ott.ott}" id="ott${ott.id}" ottId="${ott.id}" shareMateId="${ott.shareMateId}">
                                                </div>
                                                <a class="ui empty circular label ottService ottColor" ottId="${ott.id}" ottColor="${ott.color}"></a>
                                                <a style="margin-left: 10px;">${ott.ott} [<span id="ottCost${ott.id}" class="costPerPersonInfo">${ott.costPerPerson}원</span>]</a>
                                            </div>
                                        </label>
                                        <br>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty otts}">
                                <%--참여 중인 ott 서비스가 없으면--%>
                                <h3 class="ui header center aligned">참여 중인 서비스가 없습니다.</h3>
                            </c:if>
                        </div>
                    </div>
                </div>
                <span style="color: gray">결제는 하나씩 진행해주세요!</span>
            </div>
            <div class="field">
                <label>합 계</label>
                <input readonly type="number" id="totalCostInput" value="0">
            </div>
            <button type="button" class="btn payBtn" payMethod="kakaopay"><img style="width: 60px;" src="/images/kakaopay.png"></button>
            <button class="ui button payBtn" payMethod="kicc" type="button">
                kicc
            </button>
        </form>
    </div>
    <%--파티장 정보--%>
    <div class="ui bottom attached tab segment" data-tab="leaderInfo">
        <div>
            <form class="ui form">
<%--                <div class="field">--%>
<%--                    <label>환급 정보</label>--%>
<%--                    <div class="scrollable-box">--%>
<%--                        <div class="content">--%>
<%--                            <div class="subscription">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
                <div class="field">
                    <label>승인 요청</label>
                    <%--approve가 1--%>
                    <div class="scrollable-box" style="height: 100px;">
                        <div class="content">
                            <div class="subscription">
                                <c:forEach items="${mates}" var="mate">
                                    <c:if test="${mate.approve eq 1}">
                                        <label class="form-check-label d-flex justify-content-between align-items-center">
                                            <div>
                                                <a class="ui empty circular label ottService ottColor" ottId="${mate.id}" ottColor="${mate.color}"></a>
                                                <a href="/board/detail?boardId=${mate.boardId}">${mate.ott}</a>
                                                &nbsp;[${mate.name}님]&nbsp;&nbsp;[${mate.nickname}님]
                                            </div>
                                            <button type="button" mate-id="${mate.id}" class="mini ui basic button approveBtn">참여 승인</button>
                                        </label>
                                        <br>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="field">
                    <label>결제 요청</label>
                    <%--approve가 2--%>
                    <div class="scrollable-box" style="height: 100px;">
                        <div class="content">
                            <div class="subscription">
                                <c:forEach items="${mates}" var="mate">
                                    <c:if test="${mate.approve eq 2}">
                                        <label class="form-check-label d-flex justify-content-between align-items-center">
                                            <div>
                                                <a class="ui empty circular label ottService ottColor" ottId="${mate.id}" ottColor="${mate.color}"></a>
                                                <a href="/board/detail?boardId=${mate.boardId}">${mate.ott}</a>
                                                &nbsp;[${mate.name}님]&nbsp;&nbsp;[${mate.nickname}님]
                                            </div>
                                        </label>
                                        <br>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="field">
                    <label>결제 완료/정보 전송</label>
                    <%--approve가 3--%>
                    <div class="scrollable-box" style="height: 100px;">
                        <div class="content">
                            <div class="subscription">
                                <c:forEach items="${mates}" var="mate">
                                    <c:if test="${mate.approve eq 3}">
                                        <label class="form-check-label d-flex justify-content-between align-items-center">
                                            <div>
                                                <a class="ui empty circular label ottService ottColor" ottId="${mate.id}" ottColor="${mate.color}"></a>
                                                <a href="/board/detail?boardId=${mate.boardId}">${mate.ott}</a>
                                                &nbsp;[${mate.name}님]&nbsp;&nbsp;[${mate.nickname}님]
                                            </div>
                                            <button type="button" class="mini ui basic button">정보 전송</button>
                                        </label>
                                        <br>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
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

<!-- 참여 중인 서비스 확인 모달 -->
<div class="modal fade" id="joinCheckModal" tabindex="-1" aria-labelledby="joinCheckModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="joinCheckModalLabel">참여 중인 서비스 확인</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <c:if test="${not empty otts}">
                    <c:forEach items="${otts}" var="ott">
                        <%--참여 중인 ott 서비스가 있으면--%>
                        <a class="ui empty circular label ottService ottColor" ottId="${ott.id}" ottColor="${ott.color}"></a>
                        <a href="/board/detail?boardId=${ott.boardId}">${ott.ott}</a>
                        <br>
                    </c:forEach>
                </c:if>

                <c:if test="${empty otts}">
                    <%--참여 중인 ott 서비스가 없으면--%>
                    <h3 class="ui header center aligned">참여 중인 서비스가 없습니다.</h3>
                </c:if>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>



<my:foot></my:foot>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/semantic/semantic.js"></script>
<script src="/js/ott.js"></script>
<script src="/js/totalCost.js"></script>
<script src="/js/approve.js"></script>
<!-- jQuery -->
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="/js/importPay.js"></script>
<script>
    $('.menu .item')
        .tab()
    ;
    $('.ui.radio.checkbox')
        .checkbox()
    ;
</script>
</body>
</html>
