<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/17
  Time: 3:58 PM
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
<my:navBar current="myPage"/>

<%--수정 폼--%>
<div class="container w-50">
    <my:alert status="${status}"/>
    <div class="card">
        <h4 class="card-header">게시글 수정</h4>
        <div class="card-body">
            <form id="boardForm" method="post" action="/board/modify">
                <input type="hidden" name="memberId" value="${member.username}">
                <input type="hidden" name="id" value="${board.id}">
                <%--역할 설명란--%>
                <div class="col-auto">
                    <h3 class="mb-3">
                      역할은 <span class="ui green header">${board.roll == 1? '파티장' : '파티원'}</span>입니다.
                    </h3>
                </div>
                <%--제목 입력란--%>
                <div class="form-floating mb-3">
                    <input type="text" name="title" class="form-control form-control-lg" id="titleInput" value="${board.title}">
                    <label for="titleInput">Title</label>
                </div>
                <%--본문 입력란--%>
                <div class="form-floating mb-3">
                    <textarea name="body" class="form-control" id="bodyInput" style="height: 300px">${board.body}</textarea>
                    <label for="bodyInput">Comment</label>
                </div>
                <%--ott 선택란--%>
                <select class="ui fluid selection dropdown" name="ottId" required >
                    <c:forEach items="${otts}" var="ott">
                        <option value="${ott.id}">${ott.ott}</option>
                    </c:forEach>
                </select>
                <br>
                <%--날짜 선택란--%>
                <div class="form-floating mb-3">
                    <input type="date" value="${board.startDate}" class="form-control" name="startDate" id="startDate" placeholder="Password">
                    <label for="startDate">시작 날짜</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="date" value="${board.endDate}" class="form-control" name="endDate" id="endDate" placeholder="Password">
                    <label for="endDate">끝나는 날짜</label>
                </div>
                <%--작성자 정보--%>
                <div class="form-floating mb-3">
                    <input name="writer" readonly type="text" class="form-control-plaintext form-control-lg" id="writerInput" value="${member.nickname}">
                    <label for="writerInput">Mate Leader</label>
                </div>
                <button type="submit" class="btn btn-outline-secondary" form="boardForm">
                    수정
                </button>
            </form>
        </div>
    </div>
</div>

<my:foot></my:foot>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script src="/js/semantic/semantic.min.js"></script>
<script>
    $('.ui.dropdown')
        .dropdown()
    ;
</script>
</body>
</html>
