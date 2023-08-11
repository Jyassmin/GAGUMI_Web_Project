<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>register</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="register.css">
    <script src="../script/jquery.min.js"></script>
    <script src="../script/script.js"></script>
</head>
<body>
    <header>
        <!-- top-menu -->
        <ul class="top-menu">
            <li><a href="#">게시판</a></li>
            <li><a href="#" id="mypage">마이페이지</a>
                <ul class="submenu">
                    <li><a href="#">정보수정</a></li>
                    <li><a href="#">주문내역</a></li>
                    <li><a href="#">장바구니</a></li>
                </ul>
            </li>
            <li><a href="#">로그아웃</a></li>
            <li><a href="#">회원가입</a></li>
        </ul>

        <!--  logo   -->
        <div class="logo">
            <img src="../../images/logo.png">
        </div>

    </header>

    <!-- menu-name -->
    <div class="menu-name">
        <p>회 원 가 입</p>
    </div>

    <!--  register  -->
    <section class="register">
            <!--    고객, 판매자 선택    -->
            <div class="register-top">
                <h3 class="register-top-customer">고 객</h3>
                <h3 class="register-top-seller">판 매 자</h3>
            </div>
            <!--   정보입력 & 제출     -->
            <div class="register-box">
                <div class="register-box-input">
                    <div class="input1">
                        <div class="info">
                            <p class="info-name">이름</p>
                            <input class="info-value" type="text"><br>
                        </div>
                        <div class="info">
                            <p class="info-name">이메일</p>
                            <input class="info-value" type="text"><br>
                        </div>
                        <div class="info">
                            <p class="info-name">비밀번호</p>
                            <input class="info-value" type="text"><br>
                        </div>
                        <div class="info">
                            <p class="info-name">비밀번호 확인</p>
                            <input class="info-value" type="text"><br>
                        </div>
                    </div>
                    <div class="input2">
                        <div class="info">
                            <p class="info-name">휴대폰번호</p>
                            <input class="info-value" type="text"><br>
                        </div>
                        <div class="info">
                            <p class="info-name">생년월일</p>
                            <input class="info-value" type="text"><br>
                        </div>
                        <div class="info">
                            <p class="info-name">성별</p>
                            <input class="info-value" type="text"><br>
                        </div>
                    </div>
                </div>
                <div class="register-box-submit">
                    <input type="button" value="회원가입">
                </div>
            </div>
    </section>










    <section class="gap"></section>

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
