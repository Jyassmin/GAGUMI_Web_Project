<%@ page import="mysql.ProductDTO" %>
<%@ page import="mysql.db_dao" %>
<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: elane
  Date: 2023-08-18
  Time: PM 6:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--공통 스타일-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--product-detail 스타일-->
    <link rel="stylesheet" href="product-detail.css">
    <meta charset="UTF-8">
    <title>상품 정보</title>

</head>
<body>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <li><a href="#">OOO님 환영합니다.</a></li>
        <li><a href="#">게시판</a></li>
        <li class=my-page><a href="#">마이페이지</a>
            <ul class="submenu">
                <li><a href="#">정보수정</a></li>
                <li><a href="#">주문내역</a></li>
                <li><a href="#">장바구니</a></li>
            </ul>
        </li>
        <li><a href="#">로그아웃</a></li>
        <li><a href="#">회원가입</a></li>
    </ul>
    <!-- //top-menu -->
    <div class="logo">
        <a href="../../index.jsp"><img src="../../images/logo.png"></a>
    </div>
    <h1 id="title">상품 정보</h1>
    <hr>
</header>
<main>
    <%
        String currentUser = (String) session.getAttribute("memberEmail");
        int pid = Integer.parseInt(request.getParameter("pid"));
        db_dao detail_dao = new db_dao();
        ProductDTO pdto = detail_dao.printProductDetail(pid);
    %>


    <section class="product-section">
        <div class="product-detail">
            <!--상품 이미지-->
            <div class="product-detail-image" >
                <img src="../<%=pdto.getPimage()%>" alt="product-image">
            </div>
            <!--제픔정보-->
            <div class="product-detail-info" >
                <!--제품명, 제품 설명-->
                <div class="product-desc-top">
                    <h1><%=pdto.getProduct_name()%></h1>
                    <p style="height: 100px"><%=pdto.getDesc()%></p>
                </div>
                <!--제품 크기, 제품 가격, 수량-->
                <form id="basket" name="basket" action="product-detail-request.jsp" method="post">
                    <input style="display: none" type="text" name="pid" value="<%=pdto.getPid()%>">
                    <div class="product-desc-bottom">
                        <p>제품 크기 : <%=pdto.getSize()%></p>
                        <h3><%=NumberFormat.getInstance().format(pdto.getCost())%>원</h3>
                        <p>수량 <input name="quantity" id="quantity" type="number" min="1" max="100" value="1"></p>
                    </div>
                </form>
                <!--장바구니 담기 버튼-->
                <div class="product-basket-button">
                        <button type="submit" form="basket" id="product-basket-button">장 바 구 니 담 기</button>
                </div>
            </div>
        </div>
    </section>

    <hr>
    <!--리뷰 작성 및 리뷰 내용 보기-->
    <section class="review-section">
        <div class="review-info">
            <!--리뷰 작성 버튼-->
            <div class="review-button">
                <form action="../review-writer/review-writer.html">
                    <input id="review-button" type="button" value=" 리 뷰 작 성 하 기  ">
                </form>
            </div>

        </div>

    </section>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const basketForm = document.getElementById('basket');
            const loginStatus = <%= currentUser %>; // 로그인 상태에 따라 값을 설정해주세요
            console.log(loginStatus)
            basketForm.addEventListener('submit', function(event) {
                if (loginStatus == null) {
                    event.preventDefault();
                    if (confirm('로그인 후에 장바구니에 담을 수 있습니다. 로그인 페이지로 이동하시겠습니까?')) {
                        window.location.href = '../../view_customer/login-logout/login_customer.jsp'; // 로그인 페이지의 URL
                    }
                }
            });
        });
    </script>

</main>
<footer>
    <div class="footer1">
        <div class="project-intro">
            <h4>PROJECT INTRO.</h4>
            <p>This project consists of 3 team members, and the subject is a shopping mall. The period is from August 9 to August 18, 2023 and was developed using JSP, HTML, MYSQL, etc.</p>
        </div>
        <div class="product">
            <h4>PRODUCT</h4>
            <ul>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=의자&productID=1">의자</a></li>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=소파&productID=2">쇼파</a></li>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=서랍%2F수납장&productID=3">서랍/수납장</a></li> <%--%2F = /--%>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=책상&productID=4">책상</a></li>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=침대&productID=5">침대</a></li>
                <li><a href="./view_customer/product-list/product-list.jsp?productName=장롱&productID=6">장롱</a></li>
            </ul>
        </div>
        <div class="mypage">
            <h4>MYPAGE</h4>
            <ul>
                <li><a href="#">정보 수정</a></li>
                <li><a href="#">주문 내역</a></li>
                <li><a href="#">장바구니</a></li>
            </ul>
        </div>
    </div>
    <p class = "copyright">@COPYRIGHT GAGUMI ALL RIGHTS RESERVED.</p>
</footer>
</body>
</html>