<%@ page import="mysql.db_dao" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: elane
  Date: 2023-08-16
  Time: PM 8:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--공통 css style-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--product-create 스타일-->
    <link rel="stylesheet" href="customer-info.css?after">
    <meta charset="UTF-8">
    <title>개인 정보 수정</title>
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
        <a href="../home/home.jsp"><img src="../../images/logo.png"></a>
    </div>
    <h1>개인 정보 수정</h1>
</header>
<main>
    <%
        String currentUser = (String) session.getAttribute("memberEmail");
        db_dao userDao = new db_dao();
        HashMap<String, String> customerInfo = userDao.getSellerInfo(currentUser); // 판매자 정보 가져오기
    %>
    <section id="passwordCheck">
        <h4>비밀번호 확인</h4>
        <input type="password" id="passwordInput" placeholder="비밀번호">
        <button id="checkPasswordButton">확인</button>
    </section>
    <div class="wrap">
        <!-- left-menu-->
        <ul class="left-menu">
            <li><a href="#" id="customer-info">정보수정</a></li>
            <li><a href="#">주문내역</a></li>
            <li><a href="#">장바구니</a></li>
        </ul>
    <section id="updateInfo">
        <h4>정보 수정</h4>
        <form id="updateForm" action="customer-info-update-request.jsp" method="post">
            <div>
                <p><span>이메일</span> <input disabled name="email" type="text"  value="<%= customerInfo.get("email") %>"></p>
                <p><span>이름</span> <input name="modify_name" type="text"  value="<%= customerInfo.get("name") %>"></p>
                <p id="changePassword"><input id="changePasswordButton" type="button" onclick="togglePasswordChangeFields()" value="비밀번호 변경하기"></p>
                <p><input disabled id="current_pw" name="current_pw" type="text"  value="<%= customerInfo.get("pw")%>"></p>
                <p id="modifyPassword"><span>변경할 비밀번호</span><br> <input id="modify_pw" name="modify_pw" type="password" value="<%= customerInfo.get("pw")%>"></p>
                <p id="modifyPasswordCheck"><span>변경된 비밀번호 확인</span> <input type="password" id="pw_check" value="<%= customerInfo.get("pw")%>"></p>
                <p><span id="passwordError" style="color: red;"></span><br></p>
            </div>
            <div>
                <p><span>전화번호</span> <input type="text"></p>
                <p><span>생년월일</span> <input type="text"></p>
                <p><span>성별</span> <input type="text"></p>
                <%--우편 번호를 통해서 주소 입력 받기--%>
                <p><input type="button" onclick="userDaumPostcode()" value="우편번호 찾기"></p>
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
            <a href="#" id="update_button">정보 수정</a>
        </div>
    </section>
    </div>
    <script src="../../jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <%--<script src="customer-info.js"></script>--%>
    <script src="../../view_seller/info-update/info-update.js"></script>
</main>
<footer>

</footer>
</body>
</html>