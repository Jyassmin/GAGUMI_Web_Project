<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mysql.db_dao" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>홈</title>
    <!-- 부   -->
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
        <%--세션에서 UID를 가져와 name을 저장--%>
        <%
            String user_email = (String) session.getAttribute("memberEmail"); // 로그인 되어 있으면 email 가져옴
            String user_name = "";
            if (user_email != null) {
                user_name = dbDao.getNameByEmail(user_email);
            }
        %>
        <%--오른쪽 상단의 메뉴들. 세션(로그인)이 있을 때에 따라 보이는게 다르도록 함.--%>
        <% if (user_email != null) { %>
        <li><p><%= user_name %>님 환영합니다</p></li>
        <% } %>
        <li><a href="./view_customer/board/board.html">게시판</a></li> <!--게시판은 항상 보이게-->
        <% if (user_email != null) { %>
        <li class=my-page><a href="#">마이페이지▼</a>
            <ul class="submenu">
                <li><a href="./view_customer/customer-info/customer-info.jsp">정보수정</a></li>
                <li><a href="view_customer/order-history/order-history.jsp">주문내역</a></li>
                <li><a href="view_customer/basket/basket.jsp">장바구니</a></li>
            </ul>
        </li>
        <% } %>
        <%--<li><a href="#" class="move_login_customer">로그인 테스트</a></li>--%> <!--class & js로 페이지 이동하는 예시-->
        <% if (user_email == null) { %>
        <li><a href="./view_customer/login-logout/login_customer.jsp">로그인</a></li>
        <% } %>
        <% if (user_email != null) { %>
        <li><a href="./view_customer/login-logout/logout_process.jsp">로그아웃</a></li>
        <% } %>
        <% if (user_email == null) { %>
        <li><a href="./view_customer/register/register_customer.jsp">회원가입</a></li>
        <% } %>
    </ul>
    <!-- //top-menu -->

    <!--  logo   -->
    <div class="logo">
        <a href="./index.jsp"><img src="images/logo.png"></a>
    </div>

    <ul class="navmenu">
        <li><a href="./view_customer/product-list/product-list.jsp?productName=의자&productID=1">의자</a></li>
        <li><a href="./view_customer/product-list/product-list.jsp?productName=소파&productID=2">쇼파</a></li>
        <li><a href="./view_customer/product-list/product-list.jsp?productName=서랍%2F수납장&productID=3">서랍/수납장</a></li>
        <%--%2F = /--%>
        <li><a href="./view_customer/product-list/product-list.jsp?productName=책상&productID=4">책상</a></li>
        <li><a href="./view_customer/product-list/product-list.jsp?productName=침대&productID=5">침대</a></li>
        <li><a href="./view_customer/product-list/product-list.jsp?productName=장롱&productID=6">장롱</a></li>
    </ul>
</header>
<div class="main-content">
    <section class="main-image">
        <img src="images/main-image.webp">
    </section>
    <section class="main-banner">
        <% if (user_email == null) { %>
        <div><a class="background1" href="./view_customer/login-logout/login_customer.jsp">주문내역</a></div>
        <% } else { %>
        <div><a class="background1" href="./view_customer/order-history/order-history.jsp">주문내역</a></div>
        <% } %>

        <div><a class="background2" href="./view_customer/board/board.html">게시판</a></div>

        <% if (user_email == null) { %>
        <div><a class="background1" href="./view_customer/login-logout/login_customer.jsp">장바구니</a></div>
        <% } else { %>
        <div><a class="background1" href="view_customer/basket/basket.jsp">장바구니</a></div>
        <% } %>

        <% if (user_email == null) { %>
        <div><a class="background2" href="./view_customer/login-logout/login_customer.jsp">마이페이지</a></div>
        <% } else { %>
        <div><a class="background2" href="./view_customer/customer-info/customer-info.jsp">마이페이지</a></div>
        <% } %>

        <div><a class="background1" href="./view_customer/company-intro/company-intro.html">회사소개</a></div>
    </section>
</div>

<section class="gap">
    <img src="./images/bed1.jpg">
    <img src="./images/sofa8.jpg">
    <img src="./images/bed8.jpg">
</section>
<footer>
    <div class="footer1">
        <div class="project-intro">
            <h4>PROJECT INTRO.</h4>
            <p>This project consists of 3 team members, and the subject is a shopping mall. The period is from August 9
                to August 18, 2023 and was developed using JSP, HTML, MYSQL, etc.</p>
        </div>
        <div class="product">
            <h4>PRODUCT</h4>
             <ul>

                <li><a href="./view_customer/product-list/product-list.jsp?productName=의자&productID=1">의자</a></li>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=소파&productID=2">쇼파</a></li>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=서랍%2F수납장&productID=3">서랍/수납장</a></li> <%--%2F = /--%>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=책상&productID=4">책상</a></li>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=침대&productID=5">침대</a></li>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=장롱&productID=6">장롱</a></li>
            </ul>
        </div>
    </div>
    <p class="copyright">@COPYRIGHT GAGUMI ALL RIGHTS RESERVED.</p>
</footer>
</body>
</html>