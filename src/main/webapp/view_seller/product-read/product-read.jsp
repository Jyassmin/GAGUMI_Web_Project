<%@ page import="mysql.db_dao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>product-read</title>
    <!-- 공통스타일   -->
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="./product-read.css">

</head>
<body>
<%
    // 쿼리 실행
    db_dao userDao = new db_dao();
    int cnt = userDao.print_product(); // 로그인 실패 0, 성공 1
%>
</body>
</html>