<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: elane
  Date: 2023-08-14
  Time: AM 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    // POST 방식의 한글처리
    request.setCharacterEncoding("UTF-8");

    String p_name = request.getParameter("product-name");
    String item = request.getParameter("item");
    String p_price = request.getParameter("product-price");
    String p_quan = request.getParameter("product-quan");
    String p_desc = request.getParameter("product-desc");
    String p_img = request.getParameter("product-img");

    // JDBC 참조 변수 준비
    Connection con = null;
    String url = "jdbc:mysql://localhost:3306/gagumi_db"; // db선택
    String userName = "root"; // user
    String password = "12341234"; // pw


         // 1) JDBC 드라이버 로딩
    try {
        Class.forName("oracle.jdbc.OracleDriver");
    } catch (ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
    // 2) db 연결 매니저
    try {
        con = DriverManager.getConnection(url, userName, password);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    // 3) SQL문 준비

    //String sql = "INSERT INTO "

//    현재 관리자로 로그인한 계정 가져오기

    out.println("상품이름: "+p_name+"<br>");
    out.println("상품품목 : "+item+"<br>");
    out.println("상품가격 : "+p_price+"<br>");
    out.println("상품수량 : "+p_quan+"<br>");
    out.println("상품설명 : "+p_desc+" "+"<br>");
    out.println("상품이미지 : "+p_img+"<br>");
%>
</body>
</html>
