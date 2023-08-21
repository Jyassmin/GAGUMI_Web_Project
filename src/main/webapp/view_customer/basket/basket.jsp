<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mysql.db_dao" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="mysql.ShoppingCartDTO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="basket.css">
    <script src="basket.js"></script>
</head>
<body>
    <%
        // DAO 인스턴스 생성
        db_dao userDao = new db_dao();
        String currentUser = (String) session.getAttribute("memberEmail");
        // uid 기준으로 장바구니 데이터 출력해주는 함수 (이미지 / 제품명 / 주문 수량 / 총 금액)
        List<ShoppingCartDTO> cartItems = userDao.getShoppingCart(currentUser);
    %>
    <header>
        <!-- top-menu -->
        <ul class="top-menu">
            <%--세션에서 UID를 가져와 name을 저장--%>
            <%
                String user_email = (String) session.getAttribute("memberEmail"); // 로그인 되어 있으면 email 가져옴
                String user_name = "";
                if (user_email != null) {
                    user_name = userDao.getNameByEmail(user_email);
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
        <h1>장바구니</h1>
    </header>


    <form action="basket-delete.jsp" method="post" id="basket_info">
    <div class="delete">
        <input type="submit" id="selectDelete" value="삭제">
    </div>

    <div class="wrap">
        <!-- left-menu -->
        <ul class="left-menu">
            <li><a href="#">정보수정</a></li>
            <li><a href="#">주문내역</a></li>
            <li><a href="#" id="basket">장바구니</a></li>
        </ul>
        <div class="table-container">
            <table class="product-table">
                <thead>
                <tr>
                    <th></th>
                    <th></th>
                    <th>제품명</th>
                    <th>금액</th>
                    <th>주문수량</th>
                    <th>총금액</th>
                </tr>
                </thead>
                <tbody>
                <!-- 아래는 동적 으로 DB가 추가될 행들이 들어갈 자리 모양 예시-->
                <% for (ShoppingCartDTO cartItem : cartItems) { %>
                <tr>
                    <td><input type="checkbox" name="selectedItems" checked value="<%= cartItem.getSid() %>"></td>
                    <td><img src="<%= cartItem.getPimage() %>" alt="<%= cartItem.getProduct_name() %>" width="50"></td>
                    <td><%= cartItem.getProduct_name() %></td>
                    <td><%= cartItem.getQuantitiy() %></td>
                    <td><%= cartItem.getCost() %></td>
                    <td><%= NumberFormat.getInstance().format(cartItem.getTotalCost()) %>원</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
    </form>
    <div class="total-price-wrap">
        <table class="total-price">
            <tr>
                <th>주문금액</th>
                <th>+</th>
                <th>배송비</th>
                <th>=</th>
                <th>총 금액</th>
            </tr>
            <tr>
                <!--주문토탈금액-->
                <td><%= NumberFormat.getInstance().format(totalCartCost(cartItems)) %>원</td>
                <td>+</td>
                <td>3000원</td>
                <td>=</td>
                <!--배송비 3000원 추가-->
                <td><%= NumberFormat.getInstance().format(totalCartCost(cartItems) + 3000) %>원</td>
            </tr>
        </table>
        <button type="submit" form="basket_info" formaction="../order-payment/order-payment.jsp" id="order">주문하기</button>
    </div>
    <footer>
        <div class="footer1">
            <!-- 프로젝트 소개, 제품, 마이페이지 등 메뉴 항목 -->
        </div>
        <p class="copyright">@COPYRIGHT GAGUMI ALL RIGHTS RESERVED.</p>
    </footer>
</body>
</html>

<%!
    private int totalCartCost(List<ShoppingCartDTO> cartItems) {
        int totalCost = 0;
        for (ShoppingCartDTO cartItem : cartItems) {
            totalCost += cartItem.getTotalCost();
        }
        return totalCost;
    }
%>
