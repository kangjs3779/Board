<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/07/17
  Time: 12:49 PM
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
<my:navBar current="addBoard"/>

<div class="container w-50">
    <my:alert status="${status}"/>
    <div class="card">
        <h4 class="card-header">Find Mate</h4>
        <div class="card-body">
            <form id="boardForm" method="post" action="/board/addBoard">
                <%--역할 선택란--%>
                <div class="col-auto">
                    <span class="form-text">
                      역할을 선택해주세요!
                    </span>
                    <br>
                </div>
                <input type="radio" class="btn-check" name="roll" id="leaderBtn" autocomplete="off" value="1">
                <label class="btn btn-outline-secondary mb-3" for="leaderBtn">파티장</label>
                <input type="radio" class="btn-check" name="roll" id="memberBtn" autocomplete="off" value="2">
                <label class="btn btn-outline-secondary mb-3" for="memberBtn">파티원</label>
                <%--제목 입력란--%>
                <div class="form-floating mb-3">
                    <input type="text" name="title" class="form-control form-control-lg" id="titleInput" placeholder="제목을 입력해주세요.">
                    <label for="titleInput">Title</label>
                </div>
                <%--본문 입력란--%>
                <div class="form-floating mb-3">
                    <textarea name="body" class="form-control" placeholder="본문을 적어주세요." id="bodyInput" style="height: 300px"></textarea>
                    <label for="bodyInput">Comment</label>
                </div>
                <%--ott 선택란--%>
                <select class="ui fluid selection dropdown" name="ottId" required>
                    <option value="">공유하고 싶은 ott서비스를 선택해주세요!</option>
                    <c:forEach items="${otts}" var="ott">
                        <option value="${ott.id}">${ott.ott}</option>
                    </c:forEach>
                </select>
                <br>
                <%--날짜 선택란--%>
                <div class="form-floating mb-3">
                    <input type="date" class="form-control" name="startDate" id="startDate" placeholder="Password">
                    <label for="startDate">시작 날짜</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="date" class="form-control" name="endDate" id="endDate" placeholder="Password">
                    <label for="endDate">끝나는 날짜</label>
                </div>
                <%--작성자 정보--%>
                <div class="form-floating mb-3">
                    <input name="writer" readonly type="text" class="form-control-plaintext form-control-lg" id="writerInput" value="${member.nickname}">
                    <label for="writerInput">Mate Leader</label>
                </div>
                <button type="submit" id="addBoardBtn" class="btn btn-outline-secondary">
                    <i class="fa-regular fa-pen-to-square"></i>
                    글쓰기
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
