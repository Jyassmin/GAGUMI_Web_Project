<%@ page import="mysql.db_dao" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="mysql.ProductDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>sales-check</title>
    <!--공통 스타일-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--sales-check 스타일-->
    <link rel="stylesheet" href="./sales-check.css">
</head>
<body>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <li><a href="#">로그아웃</a></li>
        <li><a href="#">정보수정</a></li>
    </ul>
    <!-- //top-menu -->
    <div class="logo">
        <a href="../seller-home/seller-home.html"><img src="../../images/logo.png"></a>
    </div>
    <h1>매출조회</h1>
</header>
<main>
    <%
        String currentEmail = (String) session.getAttribute("memberEmail");
        db_dao dbDao = new db_dao();
        int[] totalList = dbDao.printTotalCost(currentEmail);
        List<ProductDTO> revenue = dbDao.printOneProductTotalCost(currentEmail);
    %>
    <!--   sales-total-list-table     -->
    <table class="sales-total-list-table">
        <tr>
            <th>총매출</th>
            <th>총판매수량</th>
        </tr>
        <tr>
            <td><%= NumberFormat.getInstance().format(totalList[0])%> 원</td>
            <td><%= NumberFormat.getInstance().format(totalList[1])%> 개</td>
        </tr>
    </table>
    <!-- 아래 예는 상품이 추가로 등록 될 때 그 상품의 매출을 조회 하는 임시 틀 예시 입니다.-->
    <!--   sales-product-list-table     -->
    <table class="sales-product-list-table">
        <%
            for(ProductDTO p : revenue) {
        %>
        <tr>
            <th rowspan="2"><%= p.getProduct_name()%></th>
            <th>제품별 총 매출</th>
            <th>총 판매 수량</th>
        </tr>

        <tr>
            <td><%= NumberFormat.getInstance().format(p.getCost())%>원</td>
            <td><%= NumberFormat.getInstance().format(p.getStock())%>개</td>
            <br>
        </tr>
        <%
            }
        %>
    </table>

</main>
<footer>

</footer>
</body>
</html>