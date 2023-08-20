<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="mysql.db_dao" %>
<%@ page import="mysql.ShoppingCartDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="basket.css">
    <script src="basket.js"></script>
</head>
<body>
<%
    // DAO 인스턴스 생성
    db_dao userDao = new db_dao();
    String currentUser = (String) session.getAttribute("memberEmail");
    // uid 기준으로 장바구니 데이터 출력해주는 함수 (이미지 / 제품명 / 주문 수량 / 총 금액)
    List<ShoppingCartDTO> cartItems = userDao.getShoppingCart(currentUser);
%>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <!-- OOO님 환영 메시지 및 메뉴 항목 -->
    </ul>
    <div class="logo">
        <a href="../../index.jsp"><img src="../../images/logo.png"></a>
    </div>
    <h1>장바구니</h1>
</header>
<form action="basket-delete.jsp" method="post">
<div class="delete">
    <input type="submit" id="selectAll" value="전체삭제">
    <input type="submit" id="selectDelete" value="선택삭제">
</div>
</form>
<div class="wrap">
    <!-- left-menu -->
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
                <th>금액</th>
                <th>주문수량</th>
                <th>총금액</th>
            </tr>
            </thead>
            <tbody>
            <!-- 아래는 동적 으로 DB가 추가될 행들이 들어갈 자리 모양 예시-->
            <% for (ShoppingCartDTO cartItem : cartItems) { %>
            <tr>
                <td><input type="checkbox"></td>
                <td><img src="<%= cartItem.getPimage() %>" alt="<%= cartItem.getProduct_name() %>" width="50"></td>
                <td><%= cartItem.getProduct_name() %></td>
                <td><%= cartItem.getQuantitiy() %></td>
                <td><%= cartItem.getCost() %></td>
                <td><%= NumberFormat.getInstance().format(cartItem.getTotalCost()) %>원</td>
            </tr>
            <% } %>
            </tbody>
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
        <tr>
            <!--주문토탈금액-->
            <td><%= NumberFormat.getInstance().format(totalCartCost(cartItems)) %>원</td>
            <td>+</td>
            <td>3000원</td>
            <td>=</td>
            <!--배송비 3000원 추가-->
            <td><%= NumberFormat.getInstance().format(totalCartCost(cartItems) + 3000) %>원</td>
        </tr>
    </table>
    <a href="#" id="order">주문하기</a>
</div>
<footer>
    <div class="footer1">
        <!-- 프로젝트 소개, 제품, 마이페이지 등 메뉴 항목 -->
    </div>
    <p class="copyright">@COPYRIGHT GAGUMI ALL RIGHTS RESERVED.</p>
</footer>
</body>
</html>

<%!
    private int totalCartCost(List<ShoppingCartDTO> cartItems) {
        int totalCost = 0;
        for (ShoppingCartDTO cartItem : cartItems) {
            totalCost += cartItem.getTotalCost();
        }
        return totalCost;
    }
%>
