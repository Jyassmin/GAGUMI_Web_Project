<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="./login.css">
</head>
<body>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <li><a href="#">게시판</a></li>
        <li><a href="#">로그인</a></li>
        <li><a href="#">회원가입</a></li>
    </ul>

    <!--  logo   -->
    <div class="logo">
        <img src="../../images/logo.png">
    </div>
    <!-- menu-name -->
    <div class="menu-name">
        <p>로 그 인</p>
    </div>
</header>
<main>
    <!--  login  -->
    <section class="login">
        <!--    고객, 판매자 선택    -->
        <div class="login-top">
            <p class="login-top-customer" id="select_customer">고 객</p>
            <p class="login-top-seller" id="select_seller">판 매 자</p>
        </div>

         <!--   정보입력 & 제출     -->
        <form class="input" id="login_form" action="login_process.jsp" method="post">
            <div>
                <div class="info">
                    <p class="info-name">아이디</p>
                    <input class="info-value" type="text" name="input_id"><br>
                </div>
                <div class="info">
                    <p class="info-name">비밀번호</p>
                    <input class="info-value" type="password" name="input_pw"><br>
                </div>
            </div>
        </form>
        <div class="login-box-submit" id="button_login">
            <button type="submit" form="login_form" id="id_submit">로 그 인</button>
        </div>
    </section>
    <script>
        const selectCustomer = document.getElementById('select_customer');
        const selectSeller = document.getElementById('select_seller');

        selectCustomer.addEventListener('click', () => {
            selectCustomer.style.backgroundColor = '#F5EFE2';
            selectCustomer.style.color = '#a43e1d';
            selectSeller.style.backgroundColor = '#a43e1d';
            selectSeller.style.color = '#ffffff';
            // F5EFE2
            // #a43e1d
            // ffffff
        });

        selectSeller.addEventListener('click', () => {
            selectCustomer.style.backgroundColor = '#a43e1d';
            selectCustomer.style.color = '#ffffff';
            selectSeller.style.backgroundColor = '#F5EFE2';
            selectSeller.style.color = '#a43e1d';
        });
    </script>
    <script>
        const inputId = document.getElementById('input_id');
        const inputPw = document.getElementById('input_pw');
        const buttonLogin = document.getElementById('button_login');

        buttonLogin.addEventListener('click', () => {
            const id = 'test'; // 실제 아이디로 변경하세요
            const pw = '123'; // 실제 비밀번호로 변경하세요

            if (inputPw.value === pw) {
                alert('로그인 되었습니다.');
            } else {
                alert('아이디 또는 비밀번호가 일치하지 않습니다.');
            }
        });
    </script>
    <div class="gap"></div>
</main>
<!--  footer  -->
<footer>
    <div class="footer1">
        <div class="project-intro">
            <h4>PROJECT INTRO.</h4>
            <p>This project consists of 3 team members, and the subject is a shopping mall. The period is from August 9 to August 18, 2023 and was developed using JSP, HTML, MYSQL, etc.</p>
        </div>
        <div class="product">
            <h4>PRODUCT</h4>
            <ul>
                <li><a href="#">의자</a></li>
                <li><a href="#">서랍/수납장</a></li>
                <li><a href="#">책상</a></li>
                <li><a href="#">침대</a></li>
                <li><a href="#">장롱</a></li>
            </ul>
        </div>
        <div class="mypage">
            <h4>MYPAGE</h4>
            <ul>
                <li><a href="#">정보 수정</a></li>
                <li><a href="#">주문 내역</a></li>
                <li><a href="#">장바구니</a></li>
            </ul>
        </div>
    </div>
    <p class = "">@COPYRIGHT GAGUMI ALL RIGHTS RESERVED.</p>
</footer>
</body>
</html>
