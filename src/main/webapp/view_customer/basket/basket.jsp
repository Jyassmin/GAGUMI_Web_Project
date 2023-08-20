<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mysql.db_dao" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>basket</title>
    <!--공통 스타일-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--basket 스타일-->
    <link rel="stylesheet" href="basket.css">
    <!--전체 선택 삭제 / 부분 선택 삭제 구현 script   -->
    <script src="basket.js"></script>
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

    <!--  logo   -->
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
    <h1>장바구니</h1>
</header>
<div class="delete">
    <input type="button" id="selectAll" value="전체삭제">
    <input type="button" id="selectDelete" value="선택삭제">

</div>


<div class="wrap">
    <!-- left-menu-->
    <ul class="left-menu">
        <li><a href="#">정보수정</a></li>
        <li><a href="#">주문내역</a></li>
        <li><a href="#" id="basket">장바구니</a></li>
    </ul>
    <div class="table-container">
    <table class="product-table">
        <thead>
        <tr>
            <th></th>
            <th></th>
            <th>제품명</th>
            <th>주문수량</th>
            <th>총금액</th>
        </tr>
        </thead>
        <!-- 아래는 동적 으로 DB가 추가될 행들이 들어갈 자리 모양 예시-->
        <tbody>
        <tr>
            <td><input type="checkbox"></td>
            <td><img src="../../images/empty-image.png" alt="Product 1" width="50"></td>
            <td>편한의자1</td>
            <td>3</td>
            <td>100,000원</td>
        </tr>
        <tr>
            <td><input type="checkbox"></td>
            <td><img src="../../images/empty-image.png" alt="Product 1" width="50"></td>
            <td>편한의자2</td>
            <td>3</td>
            <td>100,000원</td>
        </tr>
        <tr>
            <td><input type="checkbox"></td>
            <td><img src="../../images/empty-image.png" alt="Product 1" width="50"></td>
            <td>편한의자3</td>
            <td>3</td>
            <td>100,000원</td>
        </tr>
        <tr>
            <td><input type="checkbox"></td>
            <td><img src="../../images/empty-image.png" alt="Product 1" width="50"></td>
            <td>편한의자4</td>
            <td>3</td>
            <td>100,000원</td>
        </tr>
        </tbody>
        <!-- 나머지 행들도 위와 같이 추가 -->
    </table>
</div>
</div>
    <div class="total-price-wrap">
        <table class="total-price">
        <tr>
            <th>주문금액</th>
            <th>+</th>
            <th>배송비</th>
            <th>=</th>
            <th>총 금액</th>
        </tr>

    <!-- 아래는 주문 금액, 배송비, 총 금액을 받아 와야 합니다. 예시 틀 입니다. -->
        <tr>
            <td>400,000원</td>
            <td>+</td>
            <td>3000원</td>
            <td>=</td>
            <td>43,3000원</td>
        </tr>
        </table>
        <a href="#" id="order">주문하기</a>
    </div>
<!--footer-->
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