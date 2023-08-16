<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>order-list</title>
    <!--공통 스타일-->
    <link rel="stylesheet" href="../../base-style.css">
    <!--order-list 스타일-->
    <link rel="stylesheet" href="./order-list.css">

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
        <a href="../seller-home/seller-home.html"><img src="../../images/logo.png"></a>
    </div>
    <h1>고객주문목록</h1>
</header>
<!--   order-list -table     -->
<table class="order-list-table">
    <tr>
        <th></th>
        <th>고객아이디</th>
        <th>주문상품</th>
        <th>상품가격</th>
        <th>상품수량</th>
        <th>총금액</th>
        <th>이름</th>
        <th>전화번호</th>
        <th>주소</th>
    </tr>
    <!-- 여기에 동적으로 추가될 행들이 들어갈 자리  모양 예시-->
    <tr>
        <td>1</td>
        <td>abc@naver.com</td>
        <td>편한의자</td>
        <td>100,000원</td>
        <td>2개</td>
        <td>200,000원</td>
        <td>홍길동</td>
        <td>010-1234-5678</td>
        <td>경기도 달나라 마을</td>
    </tr>
    <tr>
        <td>2</td>
        <td>abc@naver.com</td>
        <td>편한의자</td>
        <td>100,000원</td>
        <td>2개</td>
        <td>200,000원</td>
        <td>홍길동</td>
        <td>010-1234-5678</td>
        <td>경기도 달나라 마을</td>
    </tr>

    <!-- 나머지 행들도 위와 같이 추가 -->
</table>

</body>
</html>