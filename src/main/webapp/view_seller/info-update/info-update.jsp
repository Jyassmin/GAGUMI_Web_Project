<%@ page import="mysql.db_dao" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--공통 css style-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--product-create 스타일-->
    <link rel="stylesheet" href="info-update.css">
    <meta charset="UTF-8">
    <title>개인 정보 수정</title>
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
        <a href="../seller-home/seller-home.html"> <img src="../../images/logo.png"></a>
    </div>
    <h1>개인 정보 수정</h1>
</header>
<main>
    <%
        String currentUser = (String) session.getAttribute("memberEmail");
        db_dao userDao = new db_dao();
        HashMap<String, String> sellerInfo = userDao.getSellerInfo(currentUser); // 판매자 정보 가져오기
    %>
    <section id="passwordCheck">
        <h4>비밀번호 확인</h4>
        <input type="password" id="passwordInput" placeholder="비밀번호">
        <button id="checkPasswordButton">확인</button>
    </section>

    <section id="updateInfo">
        <h4>정보 수정</h4>
        <form id="updateForm" action="info-update-request.jsp" method="post">
            <div>
                <p><span>이메일</span> <input disabled name="email" type="text"  value="<%= sellerInfo.get("email") %>"></p>
                <p><span>이름</span> <input name="modify_name" type="text"  value="<%= sellerInfo.get("name") %>"></p>
                <p id="changePassword"><input id="changePasswordButton" type="button" onclick="togglePasswordChangeFields()" value="비밀번호 변경하기"></p>
                <p><input disabled id="current_pw" name="current_pw" type="text"  value="<%= sellerInfo.get("pw")%>"></p>
                <p id="modifyPassword"><span>변경할 비밀번호</span><br> <input id="modify_pw" name="modify_pw" type="password" value="<%= sellerInfo.get("pw")%>"></p>
                <p id="modifyPasswordCheck"><span>변경된 비밀번호 확인</span> <input type="password" id="pw_check" value="<%= sellerInfo.get("pw")%>"></p>
                <p><span id="passwordError" style="color: red;"></span><br></p>
            </div>
            <div>
                <p><span>전화번호</span> <input name="modify_phone" type="text" value="<%= sellerInfo.get("phone") %>"></p>
                <p><span>회사명</span> <input name="modify_company" type="text" value="<%= sellerInfo.get("company") %>"></p>
                <p>주소</p>
                <%--우편 번호를 통해서 주소 입력 받기--%>
                <p><input type="button" onclick="userDaumPostcode()" value="우편번호 찾기"></p>
                <p id="address">
                   <span>
                       <input type="text" id="user_postcode" name="user_postcode" placeholder="우편번호" value="<%= sellerInfo.get("postCode") %>">
                       <input type="text" id="user_roadAddress" name="user_roadAddress" placeholder="도로명주소" oninput="changeFontSize(this.value)" value="<%= sellerInfo.get("roadAddress") %>">
                       <input type="text" id="user_jibunAddress" name="user_jibunAddress" placeholder="지번주소" oninput="changeFontSize(this.value)" value="<%= sellerInfo.get("jibunAddress") %>">
                       <span id="guide" style="color:#999;display:none"></span>
                       <input type="text" id="user_detailAddress" name="user_detailAddress" placeholder="상세주소" oninput="changeFontSize(this.value)" value="<%= sellerInfo.get("detailAddress") %>">
                       <input type="text" id="user_extraAddress" name="user_extraAddress" placeholder="참고항목" oninput="changeFontSize(this.value)" value="<%= sellerInfo.get("extraAddress") %>">
                   </span>

                </p>
            </div>
        </form>
        <div id="button">
            <button type="submit" form="updateForm" id="modify_button">정보 수정</button>
        </div>
    </section>

    <script src="../../jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="info-update.js"></script>

</main>
<footer>

</footer>
</body>
</html>