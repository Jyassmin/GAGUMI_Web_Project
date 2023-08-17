<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mysql.db_dao"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>홈</title>
    <!-- 부   -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="base-style.css">
    <link rel="stylesheet" href="view_customer/home/home.css">
    <script src="jquery.min.js"></script>
    <script src="view_customer/home/script/home.js"></script>

</head>
<body>
    <%db_dao dbDao = new db_dao();%> // dao 인스턴스 생성
    <header class="header-fixed">
        <!-- top-menu -->
        <ul class="top-menu">
            <%
                String user_email = (String) session.getAttribute("memberEmail");
                String user_name = "";
                if (user_email != null) {
                    user_name = dbDao.getNameByEmail(user_email);
                }
            %>
            <li><p><%= user_name %>님 환영합니다.</p></li>
            <li><a href="#">게시판</a></li>
            <li class=my-page><a href="#">마이페이지</a>
                <ul class="submenu">
                    <li><a href="view_customer/customer-info/customer-info.jsp">정보수정</a></li>
                    <li><a href="#">주문내역</a></li>
                    <li><a href="#">장바구니</a></li>
                </ul>
            </li>
            <%--<li><a href="#" class="move_login_customer">로그인 테스트</a></li>--%> <!--class & js로 페이지 이동하는 예시-->
            <li><a href="view_customer/login/login_customer.html">로그인</a></li>
            <li><a href="view_customer/register/register_customer.jsp">회원가입</a></li>
        </ul>
        <!-- //top-menu -->

        <!--  logo   -->
        <div class="logo">
            <a href="#"><img src="images/logo.png"></a>
        </div>
        <!--  search      -->
        <div class="search">
            <input type="text" placeholder="검색">
            <a href="#"><i class="bi bi-search"></i></a>
        </div>
        <ul class="navmenu">
            <li><a href="view_customer/product-list/product-list.html">의자</a></li>
            <li><a href="view_customer/product-list/product-list.html">쇼파</a></li>
            <li><a href="view_customer/product-list/product-list.html">서랍/수납장</a></li>
            <li><a href="view_customer/product-list/product-list.html">책상</a></li>
            <li><a href="view_customer/product-list/product-list.html">침대</a></li>
            <li><a href="view_customer/product-list/product-list.html">장롱</a></li>
        </ul>
    </header>
    <div class="main-content">
    <section class="main-image">
        <img src="images/main-image.webp">
    </section>
    <section class="main-banner">
       <div><a href="./view_customer/order-history/orderhistory.html">주문내역</a></div>
       <div><a href="#">게시판</a></div>
       <div><a href="./view_customer/basket/basket.html">장바구니</a></div>
       <div><a href="./view_customer/customer-info/customer-info.jsp">마이페이지</a></div>
       <div><a href="#">회사소개</a></div>
    </section>
    </div>
    <section class="gap"></section>
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
        <p class = "copyright">@COPYRIGHT GAGUMI ALL RIGHTS RESERVED.</p>
    </footer>
</body>
</html>