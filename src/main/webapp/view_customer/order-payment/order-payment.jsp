<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="mysql.db_DTO.ProductDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="mysql.db_DAO.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--    공통 스타일-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--    order-payment 스타일-->
    <link rel="stylesheet" href="order-payment.css">
    <!-- top-menu 상단 공통 자바스크립트 경로   -->
    <script src="../home/script/home.js"></script>
    <meta charset="UTF-8">
    <title>주문/결제</title>
</head>
<body>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <%--세션에서 UID를 가져와 name을 저장--%>
        <%
            LoginDAO loginDAO = new LoginDAO();
            CustomerDAO customerDAO = new CustomerDAO();
            SellerDAO sellerDAO = new SellerDAO();
            BasketDAO basketDAO = new BasketDAO();
            HistoryDAO historyDAO = new HistoryDAO();
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
        <li class=my-page><a href="#">마이페이지</a>
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
        <li><a href="../product-list/product-list.jsp?productName=소파&productID=2">소파</a></li>
        <li><a href="../product-list/product-list.jsp?productName=서랍%2F수납장&productID=3">서랍/수납장</a></li> <%--%2F = /--%>
        <li><a href="../product-list/product-list.jsp?productName=책상&productID=4">책상</a></li>
        <li><a href="../product-list/product-list.jsp?productName=침대&productID=5">침대</a></li>
        <li><a href="../product-list/product-list.jsp?productName=장롱&productID=6">장롱</a></li>
    </ul>
    <!-- menu-name -->
    <div class="menu-name">
        <p> 주문/결제</p>
    </div>
</header>
<%-- ----------------------------- main -------------------------------- --%>
<!-- 배송/주문자 정보 창-->
<section class="order">
    <%
        HashMap<String, String> customerInfo = customerDAO.getCustomerInfo(user_email); // 판매자 정보 가져오기
    %>
    <!--배송정보-->
    <div class="address">
        <div>
            <h3>배송지</h3>
        </div>
        <hr>
        <div>
            <p>주소 : <%= customerInfo.get("roadAddress") + ", " + customerInfo.get("detailAddress") + ", " + customerInfo.get("extraAddress") %></p> <!--주소 입력-->
        </div>
        <select name="message">
            <option value="">배송 메세지를 선택하세요.</option>
            <h3>배 송 지</h3>

            <option value="">부재시 문 앞에 놓아주세요.</option>
            <option value="">배송 전에 미리 연락주세요.</option>
            <option value="">부재 시 경비실에 맡겨 주세요.</option>
            <option value="">부재 시 전화 남겨주시거나 문자 주세요.</option>
        </select>
    </div>
    <!--주문자 정보-->
    <div class="order-person">
        <div>
            <h3>주 문 자</h3>
        </div>
        <div>
            <p>이름 : <%= user_name %></p>
            <p>아이디 : <%= user_email %></p>
            <p>휴대전화 : <%= customerInfo.get("phone") %></p>
        </div>
    </div>
</section>

  <!--주문 상품 정보-->
  <section>
  <%
      String[] selectedItems = request.getParameterValues("selectedItems");
      int total_cost = 0;
      ArrayList<Integer> quan_list = new ArrayList<>();
      for (String sidParam : selectedItems) {
  %>
      <%
          String seller_uid = basketDAO.getUidBySid(sidParam);
          HashMap<String, String> sellerInfo = sellerDAO.getSellerInfo(seller_uid); // 판매자 정보 가져오기
      %>
      <%
          int product_pid = historyDAO.getPidBySid(sidParam);
          int product_quan = historyDAO.getQuanBySid(sidParam);
          ProductDTO pdto = productDAO.printProductDetail(product_pid); // 물품 정보 가져오기
      %>
    <div class="order-products">
      <div class="order-product-info">
        <span class="order-img"><img src="<%= pdto.getPimage() %>"></span>
        <div>
          <br>
          <h3>판 매 자 정 보</h3>
          <p>판매자명 : <%= sellerInfo.get("name") %> </p>
          <p>회사 : <%= sellerInfo.get("company") %> </p>
          <br>
          <br>
          <h3>주 문 상 품</h3>
          <span class="order-info">
              <p> <%= pdto.getProduct_name() %> </p>
              <p><span> <%= NumberFormat.getInstance().format(pdto.getCost()) %>원 </span> | <span> <%= NumberFormat.getInstance().format(product_quan) %>개</span></p>
              <%
                  total_cost += pdto.getCost() * product_quan;
                  quan_list.add(product_quan);
              %>
          </span>
        </div>
      </div>
    </div>
<%
    }
%>
  </section>
  <!--결제정보 전체 창-->


<section class="pay">
    <div class="pay-info">
      <div>
        <h3>결 제 금 액</h3>
      </div>
      <div>
        <p>총 상품 금액 : <%= NumberFormat.getInstance().format(total_cost) %>원</p>
        <p>배송비 : 3,000원</p>
      </div>
      <div>
        <h3>최종 결제 금액 : <%= NumberFormat.getInstance().format(total_cost + 3000) %>원 </h3>
      </div>
    </div>

    <form id="hidden_info" action="order-payment-process.jsp">
        <%
            Date date = new Date();
            SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            String strdate = simpleDate.format(date);
        %>
            <div id="undisplay">
        <% for (String item : selectedItems) { %>
                <input  type="checkbox" name="orderItems" checked value="<%= item %>">
        <% } %>
            </div>

        <input type="hidden" name="strdate" value="<%=strdate%>">
    </form>
    <!--결제 버튼-->
    <div class="pay-button">
        <button form="hidden_info" id="payment-submit" type="submit">결 제 하 기</button>
    </div>
</section>
<footer>
</footer>
</body>
</html>