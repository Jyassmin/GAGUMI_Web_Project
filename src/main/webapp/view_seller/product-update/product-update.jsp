<%@ page import="mysql.db_dao" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--공통 css style-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--product-create 스타일-->
    <link rel="stylesheet" href="product-update.css">
    <meta charset="UTF-8">
    <title>제품 수정</title>
    <style>
        span {
            margin-left: 2%;
            font-weight: bold;
        }
    </style>
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
        <a href="../seller-home/seller-home.jsp"><img src="../../images/logo.png"></a>
    </div>
    <h1>제품 수정</h1>
</header>
<%
    String currentUser = (String) session.getAttribute("memberEmail");
    System.out.println(currentUser);
    db_dao userDao = new db_dao();
    HashMap<String, String> sellerInfo = userDao.getSellerInfo(currentUser); // 판매자 정보 가져오기
%>
<main>
    <!--상품 수정 정보 입력 창-->
    <section class="product-add">
        <!--상품 수정 정보 입력하기-->
        <div class="product-data">
            <p>제품코드 : <span class="product-code">1</span></p>
            <p>상품이름 : <input class="product-element" type="text"></p>
            <p>상품가격 : <input class="product-element" type="text"></p>
            <p>상품수량 : <input class="product-element" type="number"></p>
            <p id="desc">상품설명 :
                <textarea class="product-element" minlength="10" placeholder="최소 10글자 이상 작성해주세요."></textarea>
            </p>
            <p>상품이미지 : <input class="product-element" type="file" accept="image/*"></p>
        </div>
        <!--상품수정하기 버튼-->
        <div class="add-button">
            <a id="add-button" href="#">상품수정</a>
        </div>
    </section>
    <!--상품 수정 버튼 클릭 시 alert 메세지 띄우기-->
    <script src="../../jquery.min.js"></script>
    <script src="product-update.js"></script>
</main>
<footer>

</footer>
</body>
</html>