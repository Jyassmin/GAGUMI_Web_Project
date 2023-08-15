<%@ page import="java.util.List" %>
<%@ page import="mysql.db_dto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mysql.db_dao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 조회</title>
    <!-- 공통 스타일 -->
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="./product-read.css?after">
    <script src="./product-read.js"></script>
</head>
<body>
<%
    // DAO 인스턴스 생성
    db_dao userDao = new db_dao();

    // 상품 조회 메서드 호출
    List<db_dto> productList = userDao.print_product();
%>
<header>
    <!-- 상단 메뉴 -->
    <ul class="top-menu">
        <li><a href="#">로그아웃</a></li>
        <li><a href="#">정보수정</a></li>
    </ul>
    <!-- 상단 메뉴 끝 -->
    <div class="logo">
        <a href="../seller-home/seller-home.html"><img src="../../images/logo.png" alt="로고"></a>
    </div>
    <h1>등록상품조회</h1>
</header>

<table class="product-table">
    <tr>
        <th>주문번호</th>
        <th>이미지</th>
        <th>상품명</th>
        <th>상품카테고리</th>
        <th>상품가격</th>
        <th>상품수량</th>
        <th>수정/삭제</th>
    </tr>

    <%-- 상품 목록을 순회하며 테이블 행을 생성 --%>
    <%  int productNumber = 1; //주문번호 1부터 시작
        for (db_dto product : productList) {
    %>
    <tr>
<%--        <td><%= product.getOrderNumber() %></td>--%> <!--uid번호 들어감-->
        <td><%= productNumber %></td>
        <td><img src="../../images/empty-image.png" alt="<%= product.getProductName() %>" width="50"></td>
        <td><%= product.getProductName() %></td>
        <td><%= product.getProductCategory() %></td>
        <td><%= product.getProductPrice() %>원</td>
        <td><%= product.getProductQuantity() %>개</td>
        <td><a class="modify" href="../product-update/product-update.html">수정</a><a class="delete" href="">삭제</a></td>
    </tr>
    <%
            // 주문번호 1씩증가
            productNumber++;
        }
    %>
</table>

</body>
</html>
