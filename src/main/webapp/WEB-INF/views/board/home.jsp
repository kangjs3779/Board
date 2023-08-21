<%--
  Created by IntelliJ IDEA.
  User: kangjisu
  Date: 2023/08/08
  Time: 10:45 PM
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
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <title>shareMate</title>
    <style>
        .post-slider {
            margin: 0px auto;
        }

        .post-slider {
            top: 50%;
            right: 30px;
        }

        .post-slider {
            top: 50%;
            left: 30px;
        }

        .post-slider .post-wrapper {
            width: 90%;
            margin: 0px auto;
            overflow: hidden;
            padding: 10px 0px 10px 0px;

        }

        .post-slider .post-wrapper .post {
            margin: 0px 10px;
            display: inline-block;
            background: white;
            border-radius: 5px;

        }

        .post-slider .post-wrapper .post .post-info {
            font-size: 15px;
            padding-left: 10px;
        }

        .post-slider .post-wrapper .post .slider-image {
            width: 100%;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<my:navBar></my:navBar>

<div class="text-center">
    <img src="/images/background.jpg" class="img-fluid" alt="..." width="1000">
</div>
<h3 class="ui center aligned header">비싼 구독 서비스! 요금 혼자 내지 마세요!</h3>
<h1 class="ui center aligned header" style="font-size: 35px;">공유를 원한다면</h1>
<h1 class="ui center aligned header violet" style="font-size: 50px;">Share Mate</h1>
<div class="d-flex justify-content-center">
    <a class="massive ui inverted secondary button" href="/member/login">
        LOGIN
    </a>
    <a class="massive ui inverted secondary button" href="/member/signup">
        SIGN UP
    </a>
    <a class="massive ui inverted secondary button" href="/board/addBoard">
        Share Mate
    </a>
</div>
<div class="container">
    <br>
    <hr>
    <h2 class="ui center aligned header">공유 가능한 서비스</h2>
    <div class="page-wrapper" style="position:relative;">
        <!--슬라이더 -->
        <div class="post-slider" style="height: 180px;">
            <div class="post-wrapper">
                <c:forEach items="${otts}" var="ott">
                    <div class="post ui move down reveal">
                        <div class="visible content">
                            <img src="http://bucket0503-qkskkfkk.s3.ap-northeast-2.amazonaws.com/ShareMate/ott/${ott.id}/${ott.logo}" class="ui slider-image image">
                        </div>
                        <div class="hidden content slider-image" style="background-color: lightgrey;">
                            <p>
                                파티장 포함 ${ott.limitedAttendance}명 모집 가능 <br>
                                파티원 1명당<br> 매달 ${ott.costPerPerson}원 지출! <br>
                                최대 인원을 모집하면, <br>매달 최대 ${ott.saveMoney}원 절약!
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <br>
    <br>
    <hr>
</div>

<footer>
    <my:foot></my:foot>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js" integrity="sha512-3gJwYpMe3QewGELv8k/BX9vcqhryRdzRMxVfq6ngyWXwo03GFEzjsUm8Q7RZcHPHksttq7/GFoxjCVUjkjvPdw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="/js/semantic/semantic.min.js"></script>
<script>
    $('.post-wrapper').slick({
        slidesToShow: 6,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 1000,
        nextArrow: $('.next'),
        prevArrow: $('.prev'),
    });
</script>
</body>
</html>
