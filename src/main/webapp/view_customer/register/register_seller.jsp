<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>판매자 회원가입</title>
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="register.css">
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8"); // 지렁이 글자를 한국어로!
%>
<header>
    <!-- top-menu -->
    <ul class="top-menu">
        <li><a href="#">게시판</a></li>
        <li><a href="../login-logout/login_customer.jsp">로그인</a></li>
        <li><a href="./register_customer.jsp">회원가입</a></li>
    </ul>

    <!--  logo   -->
    <div class="logo">
        <a href="../../index.jsp"><img src="../../images/logo.png"></a>
    </div>
    <!-- menu-name -->
    <div class="menu-name">
        <p>회 원 가 입</p>
    </div>
</header>

<main>
    <!--  register  -->
    <section class="register">
        <!--    고객, 판매자 선택    -->
        <div class="register-top">
            <a id="select_customer_in_seller" href="./register_customer.jsp">고 객</a>
            <a id="select_seller_in_seller" href="./register_seller.jsp">판 매 자</a>
        </div>
        <!--   정보입력 & 제출     -->
        <form class="register-box-input" id="register_form" action="register_process.jsp" method="get" onsubmit=" return checkPassword();">
            <input type="hidden" name="page_role" value="1"><!--seller로그인이기에 role값을 지정-->
            <div class="input1">
                <div class="info">
                    <p class="info-name">이름</p>
                    <input required class="info-value" type="text" name="user_name" placeholder="ex) 홍길동"><br>
                </div>
                <div class="info">
                    <p class="info-name">이메일</p>
                    <input required class="info-value" type="email" name="user_email" placeholder="ex) example@naver.com"><br>
                </div>
                <div class="info">
                    <p class="info-name">비밀번호</p>
                    <input required class="info-value" type="password" name="user_pw" id="password_js"
                           placeholder="영문, 숫자 조합 8글자 이상"
                           pattern="^(?=.*[a-zA-Z])(?=.*\d).{8,}$"
                           title="영문, 숫자 조합으로 8글자 이상이어야 합니다."><br>
                </div>
                <div class="info">
                    <p class="info-name">비밀번호 확인</p>
                    <input required class="info-value" type="password" id="password_check_js" placeholder="비밀번호를 입력해주세요"><br> <!--비밀번호 체크하는 js아래에 작성-->
                </div>
            </div>
            <!-- 고객에게는 생년월일과 성별을 받고, 판매자에게는 회사명을 받도록. -->
            <div class="input2">
                <div class="info">
                    <p class="info-name">휴대폰번호</p>
                    <input required class="info-value" type="text"  name="user_phone" maxlength="13" id="user_phone_input" placeholder="ex) 010-1234-5678"><br>
                </div>
                <div class="info" id="company_name">
                    <p class="info-name">회사명</p>
                    <input required class="info-value" type="text"  name="user_company" value="" placeholder="ex) (주)가구미"><br>
                </div>
                <div class="info">
                    <p class="info-name">주소</p>
                    <input required id="address_search" type="button" onclick="userDaumPostcode_register()" value="주소 입력하기"><br>
                </div>
                <div id="address_align_center">
                    <input class="address_show" type="text" id="user_postcode" name="user_postcode" placeholder="우편번호" value="">
                    <input class="address_show" type="text" id="user_roadAddress" name="user_roadAddress" placeholder="도로명주소" oninput="changeFontSize(this.value)" value="">
                    <input class="address_show" type="text" id="user_jibunAddress" name="user_jibunAddress" placeholder="지번주소" oninput="changeFontSize(this.value)" value="">
                    <span id="guide" style="color:#999;display:none"></span>
                    <input class="address_show" type="text" id="user_detailAddress" name="user_detailAddress" placeholder="상세주소" oninput="changeFontSize(this.value)" value="">
                    <input class="address_show" type="text" id="user_extraAddress" name="user_extraAddress" placeholder="참고항목" oninput="changeFontSize(this.value)" value="">
                </div>
            </div>
        </form>
        <!--제출-->
        <div class="register-box-submit">
            <button type="submit" form="register_form" id="id_submit">가 입 하 기</button>
        </div>
    </section>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="./register.js"></script> <!-- js추가 -->
</main>

<!--  footer  -->
<div class="gap"></div>
<footer>
    <div class="footer1">
        <div class="project-intro">
            <h4>PROJECT INTRO.</h4>
            <p>This project consists of 3 team members, and the subject is a shopping mall. The period is from August 9 to August 18, 2023 and was developed using JSP, HTML, MYSQL, etc.</p>
        </div>
        <div class="product">
            <h4>PRODUCT</h4>
            <ul>
                <li><a href="../product-list/product-list.jsp?productName=의자&productID=1">의자</a></li>
                <li><a href="../product-list/product-list.jsp?productName=소파&productID=2">소파</a></li>
                <li><a href="../product-list/product-list.jsp?productName=서랍%2F수납장&productID=3">서랍/수납장</a></li> <%--%2F = /--%>
                <li><a href="../product-list/product-list.jsp?productName=책상&productID=4">책상</a></li>
                <li><a href="../product-list/product-list.jsp?productName=침대&productID=5">침대</a></li>
                <li><a href="../product-list/product-list.jsp?productName=장롱&productID=6">장롱</a></li>
            </ul>
        </div>

    </div>
    <p class = "copyright">@COPYRIGHT GAGUMI ALL RIGHTS RESERVED.</p>
</footer>
</body>
</html>
