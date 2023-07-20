<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="current" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="container w-75">
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="/board/list">Share Mate</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link ${current == 'shareRoom' ? 'active' : ''}" href="/board/list">Share Room</a>
                    </li>
                    <sec:authorize access="isAnonymous()">
                        <li class="nav-item">
                            <a class="nav-link ${current == 'login' ? 'active' : ''}" href="/member/login">로그인</a>
                        </li>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <li class="nav-item">
                            <a class="nav-link " href="/member/logout">로그아웃</a>
                        </li>
                    </sec:authorize>
                    <sec:authorize access="isAnonymous()">
                        <li class="nav-item">
                            <a class="nav-link ${current == 'join' ? 'active' : ''}" href="/member/signup">회원가입</a>
                        </li>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <li class="nav-item">
                            <a class="nav-link ${current == 'myPage' ? 'active' : ''}" href="/member/myPage">마이페이지</a>
                        </li>
                    </sec:authorize>
                </ul>
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </nav>
</div>