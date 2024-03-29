<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>고객 로그인</title>
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
            <li><a href="./login_customer.jsp">로그인</a></li>
            <li><a href="../register/register_customer.jsp">회원가입</a></li>
        </ul>

        <!--  logo   -->
        <div class="logo">
            <a href="../../index.jsp"><img src="../../images/logo.png"></a>
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
                <a id="select_customer_in_customer" href="./login_customer.jsp">고 객</a>
                <a id="select_seller_in_customer" href="./login_seller.jsp">판 매 자</a>
            </div>

             <!--   정보입력 & 제출     -->
            <form class="input" id="login_form" action="login_process.jsp" method="post">
                <input type="hidden" name="page_role" value="0"> <!--customer로그인이기에 role값을 지정-->
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

    </footer>
</body>
</html>
