<%@ page import="mysql.db_DTO.ProductDTO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="mysql.db_DAO.ProductDAO" %>
<%@ page import="mysql.db_DAO.LoginDAO" %>
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
        <%--세션에서 UID를 가져와 name을 저장--%>
        <%
            LoginDAO loginDAO = new LoginDAO();
            ProductDAO productDAO = new ProductDAO();
            String user_email = (String) session.getAttribute("memberEmail"); // 로그인 되어 있으면 email 가져옴
            String user_name = "";
            if (user_email != null) {
                user_name = loginDAO.getNameByEmail(user_email);
            }
        %>
        <%--오른쪽 상단의 메뉴들. 세션(로그인)이 있을 때에 따라 보이는게 다르도록 함.--%>
        <% if (user_email != null) { %><li><p><%= user_name %>님 환영합니다</p></li><% } %>
        <li><a href="../board/board.html">게시판</a></li> <!--게시판은 항상 보이게-->
        <% if (user_email != null) { %>
        <li class=my-page><a href="#">마이페이지▼</a>
            <ul class="submenu">
                <li><a href="../customer-info/customer-info.jsp">정보수정</a></li>
                <li><a href="../order-history/order-history.jsp">주문내역</a></li>
                <li><a href="../basket/basket.jsp">장바구니</a></li>
            </ul>
        </li>
        <% } %>
        <%--<li><a href="#" class="move_login_customer">로그인 테스트</a></li>--%> <!--class & js로 페이지 이동하는 예시-->
        <% if (user_email == null) { %><li><a href="../login-logout/login_customer.jsp">로그인</a></li><% } %>
        <% if (user_email != null) { %><li><a href="../login-logout/logout_process.jsp">로그아웃</a></li><% } %>
        <% if (user_email == null) { %><li><a href="../register/register_customer.jsp">회원가입</a></li><% } %>
    </ul>
  
    <!-- //top-menu -->
    <div class="logo">
        <a href="../../index.jsp"><img src="../../images/logo.png"></a>
    </div>

    <ul class="navmenu">
        <li><a href="../product-list/product-list.jsp?productName=의자&productID=1">의자</a></li>
        <li><a href="../product-list/product-list.jsp?productName=소파&productID=2">쇼파</a></li>
        <li><a href="../product-list/product-list.jsp?productName=서랍%2F수납장&productID=3">서랍/수납장</a></li> <%--%2F = /--%>
        <li><a href="../product-list/product-list.jsp?productName=책상&productID=4">책상</a></li>
        <li><a href="../product-list/product-list.jsp?productName=침대&productID=5">침대</a></li>
        <li><a href="../product-list/product-list.jsp?productName=장롱&productID=6">장롱</a></li>
    </ul>
    <h1 id="title">상품 정보</h1>
    <hr>
</header>
<main>
    <%
        String currentUser = (String) session.getAttribute("memberEmail");
        int pid = Integer.parseInt(request.getParameter("pid"));

        ProductDTO pdto = productDAO.printProductDetail(pid);
    %>


    <section class="product-section">
        <div class="product-detail">
            <!--상품 이미지-->
            <div class="product-detail-image" >
                <img src="<%=pdto.getPimage()%>" alt="product-image">
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