<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mysql.db_dao" %>
<%@ page import="java.util.List" %>
<%@ page import="mysql.ProductDTO" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>상품목록</title>
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="product-list.css?after">
</head>
<body>
    <%--세션에서 UID를 가져와 name을 저장--%>
    <%
        // 쿼리 매개변수에서 값을 가져와서 표시
        String productName = request.getParameter("productName"); // 카테고리 이름
        int productID = Integer.parseInt(request.getParameter("productID")); // 대분류 ID
        if (productName != null) {
            // URL 디코딩
            productName = java.net.URLDecoder.decode(productName, "UTF-8");
        }
        db_dao user_dao = new db_dao();
        List<ProductDTO> productList = user_dao.getProductList(productID); // 대분류별 제품 목록 덩어리
    %>
    <header>
        <!-- top-menu -->
        <ul class="top-menu">
            <%--세션에서 UID를 가져와 name을 저장--%>
            <%
                String user_email = (String) session.getAttribute("memberEmail"); // 로그인 되어 있으면 email 가져옴
                String user_name = "";
                if (user_email != null) {
                    user_name = user_dao.getNameByEmail(user_email);
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

        <!--  logo   -->
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

        <!-- menu-name -->
        <div class="menu-name">
            <p><%= productName %></p>
        </div>
    </header>

    <!-- main -->
    <main>
        <!--대분류 별 각 상품 정보 출력하기-->
        <div class="product_box">

            <%
                if(productList != null){
                    //제품 리스트의 수량만큼 제품 정보 출력하기
                    for(ProductDTO p : productList){
            %>
            <a href="../product-detail/product-detail.jsp?pid=<%=p.getPid()%>">
                <img class="product_box_img" src="<%=p.getPimage()%>" alt="productImage">
                <p class="product_box_name"><%=p.getProduct_name()%></p>
                <p class="product_box_cost"><%=NumberFormat.getInstance().format(p.getCost())%>원</p>
            </a>
            <%
                    } // for문 닫는 괄호
                }
            %>
        </div>
    </main>

    <div class="gap"></div>
    <!-- footer -->
    <footer>
        <div class="footer1">
            <div class="project-intro">
                <h4>PROJECT INTRO.</h4>
                <p>This project consists of 3 team members, and the subject is a shopping mall. The period is from August 9 to August 18,
                    2023 and was developed using JSP, HTML, MYSQL, etc.</p>
            </div>
            <div class="product">
                <h4>PRODUCT</h4>
                <ul>
                    <li><a href="#">의자</a></li>
                    <li><a href="#">서랍/수납장</a></li>
                    <li><a href="#">책상</a></li>
                    <li><a href="#">침대</a></li>
                    <li><a href="#">장롱</a></li>
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
