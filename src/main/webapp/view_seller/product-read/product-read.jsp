<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="mysql.db_DTO.ProductDTO" %>
<%@ page import="mysql.db_DAO.ProductDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 조회</title>
    <!-- 공통 스타일 -->
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="./product-read.css?after">
    <!--<script src="./product-read.js"></script>-->
</head>
<body>
<%
    // DAO 인스턴스 생성
    ProductDAO productDAO = new ProductDAO();
    String currentUser = (String)session.getAttribute("memberEmail");
    // 상품 조회 메서드 호출
    List<ProductDTO> productList = productDAO.print_product(currentUser);
%>
<header>
    <!-- 상단 메뉴 -->
    <ul class="top-menu">
        <li><a href="#">로그아웃</a></li>
        <li><a href="#">정보수정</a></li>
    </ul>
    <!-- 상단 메뉴 끝 -->
    <div class="logo">
        <a href="../seller-home/seller-home.jsp"><img src="../../images/logo.png" alt="로고"></a>
    </div>
    <h1>등록상품조회</h1>
</header>

<table class="product-table">
    <tr>
        <th></th>
        <th>제품코드</th>
        <th>이미지</th>
        <th>상품명</th>
        <th>상품카테고리</th>
        <th>상품가격</th>
        <th>상품수량</th>
        <th>수정/삭제</th>
    </tr>

    <%-- 상품 목록을 순회하며 테이블 행을 생성 --%>
    <%  int productNumber = 1; //주문번호 1부터 시작
        for (ProductDTO product : productList) {
    %>

    <tr>
        <td><%= productNumber %></td>
        <td><%= product.getPid()%></td>
        <td><img src="<%=product.getPimage()%>" alt="<%= product.getProduct_name() %>" width="50"></td>
        <td><%= product.getProduct_name()%></td>
        <td><%= productDAO.getCategoryText(product.getCa2id()) %></td>
        <!--숫자를 10,000 뒤에서 세자리로 포맷팅하여 출력-->
        <td><%= NumberFormat.getInstance().format(product.getCost()) %>원</td>
        <td><%= product.getStock() %>개</td>
        <td><a class="modify" href="../product-update/product-update.jsp?pid=<%=product.getPid()%>">수정</a>
            <a class="delete" href="<%= deleteProductURL(product.getPid()) %>">삭제</a>
        </td>
    </tr>
    <%!
        String deleteProductURL(int pid) {
            return String.format("./product-read-delete.jsp?pid=%d", pid);
        }
    %>

    <%
            // 주문번호 1씩증가
            productNumber++;
        }
    %>
</table>

</body>
</html>
