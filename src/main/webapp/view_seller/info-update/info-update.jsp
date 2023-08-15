<%--
  Created by IntelliJ IDEA.
  User: elane
  Date: 2023-08-15
  Time: PM 5:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--공통 css style-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--product-create 스타일-->
    <link rel="stylesheet" href="info-update.css">
    <meta charset="UTF-8">
    <title>개인 정보 수정</title>
</head>
<body>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <li><a href="#">로그아웃</a></li>
        <li><a href="#">정보수정</a></li>
    </ul>
    <!-- //top-menu -->
    <div class="logo">
        <a href="../seller-home/seller-home.html"> <img src="../../images/logo.png"></a>
    </div>
    <h1>등록상품조회</h1>
</header>
<main>
    <section id="passwordCheck">
        <h4>비밀번호 확인</h4>
        <input type="password" id="passwordInput" placeholder="비밀번호">
        <button id="checkPasswordButton">확인</button>
    </section>

    <section id="updateInfo">
        <h4>정보 수정</h4>
        <form id="updateForm">
            <div>
                <p><span>이름</span> <input name="modify-name" type="text"></p>
                <p><span>비밀번호</span> <input name="modify-pw" type="password"></p>
                <p><span>비밀번호 확인</span> <input type="password"></p>
            </div>
            <div>
                <p><span>전화번호</span> <input name="modify-phone" type="text"></p>
                <p><span>회사명</span> <input name="modify-company" type="text"></p>
                <p>주소</p>
                <p id="address">
                   <span><input disabled type="text" id="user_postcode" placeholder="우편번호">
                       <input disabled type="text" id="user_roadAddress" placeholder="도로명주소">
                       <input disabled type="text" id="user_jibunAddress" placeholder="지번주소">
                       <span id="guide" style="color:#999;display:none"></span>
                       <input type="text" id="user_detailAddress" placeholder="상세주소">
                       <input disabled type="text" id="user_extraAddress" placeholder="참고항목">
                   </span>
                    <span><input type="button" onclick="userDaumPostcode()" value="우편번호 찾기"></span>
                </p>
            </div>
        </form>

        <div id="button">
            <a href="#" class="info-update">정보 수정</a>
        </div>
    </section>

    <script src="../../jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="info-update.js"></script>

</main>
<footer>

</footer>
</body>
</html>