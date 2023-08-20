<%@ page import="mysql.db_dao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--공통 스타일-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--product-detail 스타일-->
    <link rel="stylesheet" href="product-detail.css">
    <meta charset="UTF-8">
    <title>상품 정보</title>

</head>
<body>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <%--세션에서 UID를 가져와 name을 저장--%>
        <%
            db_dao user_dao = new db_dao();
            String user_email = (String) session.getAttribute("memberEmail"); // 로그인 되어 있으면 email 가져옴
            String user_name = "";
            if (user_email != null) {
                user_name = user_dao.getNameByEmail(user_email);
            }
        %>
        <%--오른쪽 상단의 메뉴들. 세션(로그인)이 있을 때에 따라 보이는게 다르도록 함.--%>
        <% if (user_email != null) { %><li><p><%= user_name %>님 환영합니다</p></li><% } %>
        <li><a href="../board/board.html">게시판</a></li> <!--게시판은 항상 보이게-->
        <% if (user_email != null) { %>
        <li class=my-page><a href="#">마이페이지</a>
            <ul class="submenu">
                <li><a href="../customer-info/customer-info.jsp">정보수정</a></li>
                <li><a href="../order-history/order-history.jsp">주문내역</a></li>
                <li><a href="../basket/basket.jsp">장바구니</a></li>
            </ul>
        </li>
        <% } %>
        <%--<li><a href="#" class="move_login_customer">로그인 테스트</a></li>--%> <!--class & js로 페이지 이동하는 예시-->
        <% if (user_email == null) { %><li><a href="../login-logout/login_customer.jsp">로그인</a></li><% } %>
        <% if (user_email != null) { %><li><a href="../login-logout/logout_process.jsp">로그아웃</a></li><% } %>
        <% if (user_email == null) { %><li><a href="../register/register_customer.jsp">회원가입</a></li><% } %>
    </ul>
    <!-- //top-menu -->
    <div class="logo">
        <a href="../../index.jsp"><img src="../../images/logo.png"></a>
    </div>
    <!--  search      -->
    <div class="search">
        <input type="text" placeholder="검색">
        <a href="#"><i class="bi bi-search"></i></a>
    </div>
    <ul class="navmenu">
        <li><a href="../product-list/product-list.jsp?productName=의자&productID=1">의자</a></li>
        <li><a href="../product-list/product-list.jsp?productName=소파&productID=2">쇼파</a></li>
        <li><a href="../product-list/product-list.jsp?productName=서랍%2F수납장&productID=3">서랍/수납장</a></li> <%--%2F = /--%>
        <li><a href="../product-list/product-list.jsp?productName=책상&productID=4">책상</a></li>
        <li><a href="../product-list/product-list.jsp?productName=침대&productID=5">침대</a></li>
        <li><a href="../product-list/product-list.jsp?productName=장롱&productID=6">장롱</a></li>
    </ul>
    <h1>상품 정보</h1>
</header>
<main>
    <section class="product-section">
        <div class="product-detail">
            <!--상품 이미지-->
            <div class="product-detail-image" >
                <img src="../../images/sofa/sofa1.jpg" alt="product-image">
            </div>
            <!--제픔정보-->
            <div class="product-detail-info" >
                <!--제품명, 제품 설명-->
                <div class="product-desc-top">
                    <h1>댕편한 소파</h1>
                    <p style="height: 100px">위 코드에서 font-size 값을 조절하여 원하는 글씨 크기로
                        변경할 수 있습니다. 값을 픽셀(px) 단위로 설정하거나, em, rem, % 등의
                        다른 단위를 사용하여 글씨 크기를 조절할 수 있습니다. 예를 들어, 글씨 크기를
                        상대적인 em 단위로 설정하려면 아래와 같이 할 수 있습니다:</p>
                </div>
                <!--제품 크기, 제품 가격, 수량-->
                <div class="product-desc-bottom">
                    <p>제품 크기 : 150X100X200</p>
                    <h3>10,000원</h3>
                    <p>수량 <input id="quantity" type="number" min="1" max="100" value="1"></p>
                </div>
                <!--장바구니 담기 버튼-->
                <div class="product-basket-button">
                    <input id="basket-button" type="button" value=" 장 바 구 니 담 기 ">
                </div>
            </div>
        </div>
    </section>
    <hr>
    <!--리뷰 작성 및 리뷰 내용 보기-->
    <section class="review-section">
        <div class="review-info">
            <!--리뷰 작성 버튼-->
            <div class="review-button">
                <form action="../review-writer/review-writer.html">

                </form>
                <input id="review-button" type="button" value=" 리 뷰 작 성 하 기  ">
            </div>

        </div>

    </section>


</main>
<footer>
    <div class="footer1">
        <div class="project-intro">
            <h4>PROJECT INTRO.</h4>
            <p>This project consists of 3 team members, and the subject is a shopping mall. The period is from August 9 to August 18, 2023 and was developed using JSP, HTML, MYSQL, etc.</p>
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