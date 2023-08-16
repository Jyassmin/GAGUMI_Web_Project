<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="mysql.db_dto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mysql.db_dao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="mysql.db_util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>고객주문목록</title>
    <!--공통 스타일-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--order-list 스타일-->
    <link rel="stylesheet" href="./order-list.css">
</head>
<body>
<%
    // DAO 인스턴스 생성
    db_dao userDao = new db_dao();
    String currentUser = (String) session.getAttribute("uid");
    // 상품 조회 메서드 호출
    List<db_dto> orderList = userDao.print_orderList(currentUser);
%>
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
    <h1>고객주문목록</h1>
</header>
<!--   order-list -table     -->
<table class="order-list-table">
    <tr>
        <th></th>
        <th>주문코드</th>
        <th>고객아이디</th>
        <th>주문상품</th>
        <th>상품가격</th>
        <th>상품수량</th>
        <th>총금액</th>
        <th>이름</th>
        <th>전화번호</th>
        <th>주소</th>
        <th>주문날짜</th>
    </tr>
    <%--주문목록을 순회하며 테이블 행을 생성--%>
    <%
        int productNumber = 1; //주문번호 1부터 시작
        for (db_dto order : orderList) {
    %>
    <!-- 여기에 동적으로 추가될 행들이 들어갈 자리  모양 예시-->
    <tr>
        <td><%=productNumber%></td>
        <td><%=order.getOrderCode()%></td>
        <td><%=order.getUserID()%></td>
        <td><%=order.getProductName()%></td>
        <td><%=order.getProductPrice()%></td>
        <td><%=order.getOrderQuantity()%></td>
        <td><%=order.getTotalPrice()%></td>
        <td><%=order.getOrderName()%></td>
        <td><%=order.getOrderPhone()%></td>
        <td><%=order.getOrderAdress()%></td>
        <td><%=order.getDateTime()%></td>
    </tr>
    <%  // 주문번호 증가
        productNumber++;
    } // for문 종료
    %>
</table>
</body>
</html>
