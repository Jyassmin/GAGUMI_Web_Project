<%@ page import="mysql.db_dao" %>
<%@ page import="java.util.List" %>
<%@ page import="mysql.ProductDTO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>상품목록</title>
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="product-list.css?after">
</head>
<body>
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
            <li><a href="#">000님 환영합니다.</a></li>
            <li><a href="#">게시판</a></li>
            <li><a href="#">마이페이지</a></li>
            <li><a href="#">로그인</a></li>
            <li><a href="#">회원가입</a></li>
        </ul>

        <!--  logo   -->
        <div class="logo">
            <a href="../../index.jsp"><img src="../../images/logo.png"></a>
        </div>

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
            <a>
                <img class="product_box_img" src="../<%=p.getPimage()%>" alt="productImage">
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
