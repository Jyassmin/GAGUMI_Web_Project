<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>판매자 로그인</title>
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="login.css">
</head>
<body>
    <%
        // 회원가입하고 login으로 왔을 때 email을 자동으로 입력하게.
        // 쿼리 매개변수에서 값을 가져와서 표시(만약 home에서 왔다면 아래 값이 null이다.)
        String user_email = request.getParameter("user_email"); // 자동으로 가져올 유저 ID
        if (user_email == null) { // Home에서 왔으면 공백 문자열로
            user_email = "";
        }
    %>
    <header>
        <!-- top-menu -->
        <ul class="top-menu">
            <li><a href="#">게시판</a></li>
            <li><a href="../login/login_customer.jsp">로그인</a></li>
            <li><a href="../register/register_customer.jsp">회원가입</a></li>
        </ul>

        <!--  logo   -->
        <div class="logo">
            <img src="../../images/logo.png">
        </div>
        <!-- menu-name -->
        <div class="menu-name">
            <p>로 그 인</p>
        </div>
    </header>

    <main>
        <!--  login  -->
        <section class="login">
            <!--    고객, 판매자 선택    -->
            <div class="login-top">
                <a id="select_customer_in_seller" href="./login_customer.jsp">고 객</a>
                <a id="select_seller_in_seller" href="login_seller.jsp">판 매 자</a>
            </div>

            <!--   정보입력 & 제출     -->
            <form class="input" id="login_form" action="login_process.jsp" method="post">
                <input type="hidden" name="page_role" value="1"><!--seller로그인이기에 role값을 지정-->
                <input required type="text" placeholder="아이디" class="info-value" name="input_id" value=<%= user_email %>>
                <input required type="password" placeholder="비밀번호" class="info-value" name="input_pw">
            </form>
            <div class="login-box-submit" id="button_login">
                <button type="submit" form="login_form" id="id_submit">로 그 인</button>
            </div>
        </section>
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
        <p class = "">@COPYRIGHT GAGUMI ALL RIGHTS RESERVED.</p>
    </footer>
</body>
</html>
