<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mysql.db_dao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="mysql.db_util" %>
<%@ page import="java.util.HashMap" %>
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
    String currentUser = (String) session.getAttribute("memberEmail");
    // 상품 조회 메서드 호출
    ArrayList<HashMap<String, String>> history_list = userDao.print_orderList(currentUser);
%>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <li><a href="#">로그아웃</a></li>
        <li><a href="#">정보수정</a></li>
    </ul>
    <!-- //top-menu -->
    <div class="logo">
        <a href="../seller-home/seller-home.jsp"><img src="../../images/logo.png"></a>
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
        int productNumber = 1; //1부터 시작
        for ( HashMap<String,String> h_dummy : history_list) {
    %>
    <!-- 여기에 동적으로 추가될 행들이 들어갈 자리  모양 예시-->
    <tr>
        <td><%=productNumber%></td>
        <td><%=h_dummy.get("hid")%></td>
        <td><%=h_dummy.get("email")%></td>
        <td><%=h_dummy.get("pname")%></td>
        <td><%= NumberFormat.getInstance().format(Integer.parseInt(h_dummy.get("cost"))) %>원</td>
        <td><%=h_dummy.get("quantity")%></td>
        <td><%= NumberFormat.getInstance().format(Integer.parseInt(h_dummy.get("total_cost"))) %>원</td>
        <td><%=h_dummy.get("name")%></td>
        <td><%=h_dummy.get("phone")%></td>
        <td><%=h_dummy.get("address")%></td>
        <td><%=h_dummy.get("datetime")%></td>
    </tr>
    <%  // 번호 증가
        productNumber++;
    } // for문 종료
    %>
</table>
</body>
</html>
