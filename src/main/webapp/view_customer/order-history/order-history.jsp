<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mysql.db_dao" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>주문내역</title>
    <!--    공통 스타일-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--    order-payment 스타일-->
    <link rel="stylesheet" href="orderhistory.css?after">
    <!-- top-menu 상단 공통 자바스크립트 경로   -->
    <script src="../home/script/home.js"></script>
</head>
<body>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <li><a href="#">OOO님 환영합니다.</a></li>
        <li><a href="#">게시판</a></li>
        <li class=my-page><a href="#">마이페이지</a>
            <ul class="submenu">
                <li><a href="#">정보수정</a></li>
                <li><a href="#">주문내역</a></li>
                <li><a href="#">장바구니</a></li>
            </ul>
        </li>
        <li><a href="#">로그아웃</a></li>
        <li><a href="#">회원가입</a></li>
    </ul>
    <!-- //top-menu -->
    <div class="logo">
        <a href="../../index.jsp"><img src="../../images/logo.png"></a>
    </div>
    <h1>주문내역</h1>
</header>

<main class="wrap">
    <!-- left-menu-->
    <ul class="left-menu">
        <li><a href="#">정보수정</a></li>
        <li><a href="#" id="order-history">주문내역</a></li>
        <li><a href="#">장바구니</a></li>
    </ul>
    <%
        // DAO 인스턴스 생성
        db_dao userDao = new db_dao();
        String currentUser = (String)session.getAttribute("memberEmail");
        // 고객 주문내역 가져오기.(주문번호별 주문내역 모음(Arraylist) > 주문번호가 같은 제품들 정보(Arraylist) > 제품 정보(Hasmap)
        ArrayList<ArrayList<HashMap<String, String>>> order_history_dao = userDao.order_history_dao(currentUser);
    %>
    <!-- 주문 내역 테이블   -->
    <section class="main-show">
        <%-- 주분 번호 별 주문내역 목록을 순회하며 테이블 행을 생성 --%>
        <%
            for (ArrayList<HashMap<String, String>> order_list_dummy : order_history_dao) {
        %>
        <div class="table-container"> <!--주문블럭 반복-->
            <table class="order-table">
                <thead>
                    <tr>
                        <th class="order-date"><p>주문일자 : <%= order_list_dummy.get(0).get("datetime")%><p></th>
                        <th class="order-number"><p>주문번호 : <%= order_list_dummy.get(0).get("oid")%><p></th>
                    </tr>
                </thead>

                <%
                    for (HashMap<String, String> hashmap_dummy : order_list_dummy) {
                %>
                <!-- 아래는 동적 으로 DB가 추가될 행-->
                <tbody id="h_tbody"> <!--제품주문정보 반복-->
                    <tr>
                        <td id="h_image"><img src="../<%= hashmap_dummy.get("pimage")%>" alt="Product 1" width="100"></td>
                        <td id="h_info" class="product-details">
                            <p> • 제품명 : <%= hashmap_dummy.get("oid")%></p><br>
                            <p class="price"> • 가격 : <%= Integer.parseInt(hashmap_dummy.get("cost")) * Integer.parseInt(hashmap_dummy.get("quantity")) %></p><br> <!--bold-->
                            <p> • 수량 : <%= hashmap_dummy.get("quantity")%></p><br>
                            <p> • 판매자 : <%= hashmap_dummy.get("name")%></p><br>
                            <p> • 문의번호 : <%= hashmap_dummy.get("phone")%></p>
                        </td>
                    </tr>
                </tbody>
                <%
                    }
                %>
                <!-- 나머지 행들도 위와 같이 추가 -->
            </table>
        </div>
        <div class="gap"></div>
        <%
            }
        %>
    </section>
</main>

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