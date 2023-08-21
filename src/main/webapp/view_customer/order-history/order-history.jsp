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
            <li class=my-page><a href="#">마이페이지▼</a>
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


        <ul class="navmenu">
            <li><a href="../product-list/product-list.jsp?productName=의자&productID=1">의자</a></li>
            <li><a href="../product-list/product-list.jsp?productName=소파&productID=2">쇼파</a></li>
            <li><a href="../product-list/product-list.jsp?productName=서랍%2F수납장&productID=3">서랍/수납장</a></li> <%--%2F = /--%>
            <li><a href="../product-list/product-list.jsp?productName=책상&productID=4">책상</a></li>
            <li><a href="../product-list/product-list.jsp?productName=침대&productID=5">침대</a></li>
            <li><a href="../product-list/product-list.jsp?productName=장롱&productID=6">장롱</a></li>
        </ul>
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