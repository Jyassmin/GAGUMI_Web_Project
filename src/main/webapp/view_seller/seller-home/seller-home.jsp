<%--
  Created by IntelliJ IDEA.
  User: elane
  Date: 2023-08-17
  Time: AM 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--공통 css style-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--seller-home style-->
    <link rel="stylesheet" href="seller-home.css">

    <meta charset="UTF-8">
    <title>판매자 Home</title>
    <script type="text/javascript">
        function changeBackgroundColor(element) {
            element.style.backgroundColor = "#A43E1D";
            element.style.color = "#F5EFE2";
        }

        function restoreBackgroundColor(element) {
            element.style.backgroundColor = ""; // 기본 배경색으로 돌아가도록 설정
            element.style.color = ""; // 기본 색으로 돌아가도록 설정
        }
    </script>
</head>
<body>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <li><a href="../../view_customer/login-logout/logout_process.jsp">로그아웃</a></li>
        <li><a href="../info-update/info-update.jsp">정보수정</a></li>
    </ul>
    <!-- //top-menu -->
    <div class="logo">
        <a href="../seller-home/seller-home.jsp"><img src="../../images/logo.png"></a>
    </div>
    <h1>판매자홈</h1>
</header>
<main>
    <%
        String user_email = (String) session.getAttribute("memberEmail"); // 로그인 정보 세션

    %>
    <!--판매자 메뉴-->
    <section class="seller-menu">
        <div class="menu-item">
            <a href="../product-create/product-create.html" onmouseover="changeBackgroundColor(this);" onmouseout="restoreBackgroundColor(this);">상 품 등 록</a>
            <a href="../product-read/product-read.jsp" onmouseover="changeBackgroundColor(this);" onmouseout="restoreBackgroundColor(this);">상 품 관 리</a>
        </div>
        <div class="menu-item">
            <a href="../order-list/order-list.jsp" onmouseover="changeBackgroundColor(this);" onmouseout="restoreBackgroundColor(this);">주 문 목 록</a>
            <a href="../sales-check/sales-check.jsp" onmouseover="changeBackgroundColor(this);" onmouseout="restoreBackgroundColor(this);">매 출 조 회</a>
        </div>
    </section>
</main>
<footer>

</footer>
</body>
</html>
