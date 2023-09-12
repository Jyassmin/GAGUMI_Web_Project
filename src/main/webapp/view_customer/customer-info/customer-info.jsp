<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="mysql.db_DAO.LoginDAO" %>
<%@ page import="mysql.db_DAO.CustomerDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--공통 css style-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--product-create 스타일-->
    <link rel="stylesheet" href="customer-info.css?after">
    <!-- top-menu 상단 공통 자바스크립트 경로   -->
    <script src="../home/script/home.js"></script>
    <meta charset="UTF-8">
    <title>개인 정보 수정</title>
</head>
<body>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <%--세션에서 UID를 가져와 name을 저장--%>
        <%
            LoginDAO loginDAO = new LoginDAO();
            CustomerDAO customerDAO = new CustomerDAO();
            String user_email = (String) session.getAttribute("memberEmail"); // 로그인 되어 있으면 email 가져옴
            String user_name = "";
            if (user_email != null) {
                user_name = loginDAO.getNameByEmail(user_email);
            }
        %>
        <%--오른쪽 상단의 메뉴들. 세션(로그인)이 있을 때에 따라 보이는게 다르도록 함.--%>
        <% if (user_email != null) { %><li><span id="welcome"><%= user_name %>님 환영합니다</span></li><% } %>
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
    <h1>개인 정보 수정</h1>
</header>
<main>
    <%--개인정보 수정--%>
    <%
        String currentUser = (String) session.getAttribute("memberEmail");
        //System.out.println("Email = " + currentUser);
        HashMap<String, String> customerInfo = customerDAO.getCustomerInfo(currentUser); // 고객 정보 가져오기
    %>
    <p><input disabled id="current_pw" name="current_pw" type="text"  value="<%= customerInfo.get("pw")%>"></p>
    <section id="passwordCheck">
        <h4>비밀번호 확인</h4>
        <input type="password" id="passwordInput" placeholder="비밀번호">
        <button id="checkPasswordButton">확인</button>
    </section>
    <div class="wrap">
        <!-- left-menu-->
        <ul class="left-menu">
            <li><a href="../customer-info/customer-info.jsp" id="customer-info">정보수정</a></li>
            <li><a href="../order-history/order-history.jsp">주문내역</a></li>
            <li><a href="../basket/basket.jsp">장바구니</a></li>
        </ul>
    <section id="updateInfo">
        <h4>정보 수정</h4>
        <form id="updateForm" action="customer-info-request.jsp" method="post">
            <div>
                <p><span>이메일</span> <input disabled name="email" type="text"  value="<%= customerInfo.get("email") %>"></p>
                <p><span>이름</span> <input name="modify_name" type="text"  value="<%= customerInfo.get("name") %>"></p>
                <p id="changePassword"><input id="changePasswordButton" type="button" onclick="togglePasswordChangeFields()" value="비밀번호 변경하기"></p>
                <p id="modifyPassword"><span>변경할 비밀번호</span><br> <input id="modify_pw" name="modify_pw" type="password" value="<%= customerInfo.get("pw")%>"></p>
                <p id="modifyPasswordCheck"><span>변경된 비밀번호 확인</span> <input type="password" id="pw_check" value="<%= customerInfo.get("pw")%>"></p>
                <p><span id="passwordError" style="color: red;"></span><br></p>
            </div>
            <div>
                <p><span>전화번호</span> <input type="text" name="modify_phone" value="<%= customerInfo.get("phone") %>"></p>
                <p><span>생년월일</span> <input type="text" name="modify_birthday" value="<%= customerInfo.get("birthday") %>"></p>
                <div class="info" id="gender">
                    <div>
                        <input type="radio" id="radio_male" name="modify_sex" value="0" <%= customerInfo.get("gender").equals("0") ? "checked" : "" %>>
                        <label for="radio_male">남성</label>
                    </div>
                    <div>
                        <input type="radio" id="radio_female" name="modify_sex" value="1" <%= customerInfo.get("gender").equals("1") ? "checked" : "" %>>
                        <label for="radio_female">여성</label>
                    </div>
                </div>
                <%--<p><span>성별</span> <input type="text" name="modify_sex" value="<%= customerInfo.get("gender") %>"></p>--%>
                <%--우편 번호를 통해서 주소 입력 받기--%>
                <p><input type="button" onclick="userDaumPostcode()" value="우편번호 찾기" id="button_adress"></p>
                <p id="address">
                   <span>
                       <input type="text" id="user_postcode" name="user_postcode" placeholder="우편번호" value="<%= customerInfo.get("postCode") %>">
                       <input type="text" id="user_roadAddress" name="user_roadAddress" placeholder="도로명주소" oninput="changeFontSize(this.value)" value="<%= customerInfo.get("roadAddress") %>">
                       <input type="text" id="user_jibunAddress" name="user_jibunAddress" placeholder="지번주소" oninput="changeFontSize(this.value)" value="<%= customerInfo.get("jibunAddress") %>">
                       <span id="guide" style="color:#999;display:none"></span>
                       <input type="text" id="user_detailAddress" name="user_detailAddress" placeholder="상세주소" oninput="changeFontSize(this.value)" value="<%= customerInfo.get("detailAddress") %>">
                       <input type="text" id="user_extraAddress" name="user_extraAddress" placeholder="참고항목" oninput="changeFontSize(this.value)" value="<%= customerInfo.get("extraAddress") %>">
                   </span>

                </p>
            </div>
        </form>

        <div id="button">
            <button type="submit" form="updateForm" id="modify_button">정보 수정</button>
        </div>
    </section>
    </div>
    <script src="../../jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="customer-info.js"></script>
</main>
<footer>

</footer>
</body>
</html>