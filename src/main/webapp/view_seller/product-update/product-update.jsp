<%@ page import="mysql.db_dao" %>
<%@ page import="mysql.ProductDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 수정</title>
    <link rel="stylesheet" href="../../base-style.css">
    <link rel="stylesheet" href="product-update.css">
</head>
<body>
<!-- 헤더 영역 -->
<header>
    <!-- 로그인 정보 메뉴 -->
    <ul class="top-menu">
        <li><a href="#">로그아웃</a></li>
        <li><a href="#">정보수정</a></li>
    </ul>
    <!-- 로고 -->
    <div class="logo">
        <a href="../seller-home/seller-home.jsp"><img src="../../images/logo.png" alt="로고"></a>
    </div>
    <h1>제품 수정</h1>
</header>

<%
    // DAO 인스턴스 생성
    db_dao userDao = new db_dao();
    String currentUser = (String) session.getAttribute("memberEmail");
    // 상품 코드(pid) 가져오기
    String pidParam = request.getParameter("pid");
    int targetPid = 0;

    // 파라미터가 존재하면 정수로 변환하여 저장
    if (pidParam != null && !pidParam.isEmpty()) {
        targetPid = Integer.parseInt(pidParam);
    }

    // 상품 정보 조회
    List<ProductDTO> productList = userDao.ProductByPid(currentUser, targetPid);

    ProductDTO product = null;
    // productList가 비어있지 않으면 첫 번째 상품 정보 가져오기
    if (!productList.isEmpty()) {
        product = productList.get(0);
    }
%>
<!-- 상품 정보 수정 폼 -->
<section class="product-add">
<form action="product-update-request.jsp" method="post">
    <!-- 상품 데이터 입력 영역 -->
    <%--<div class="product-data">--%>
    <%--    <p>제품코드 : <span class="product-code"><%=product.getPid() %></span></p>--%>
    <%--    <p>상품이름 : <input class="product-element" type="text" value="<%= product.getProduct_name() %>"></p>--%>
    <%--    <p>상품가격 : <input class="product-element" type="text" value="<%= product.getCost() %>"></p>--%>
    <%--    <p>상품수량 : <input class="product-element" type="number" value="<%= product.getStock() %>"></p>--%>
    <%--    <p id="desc">상품설명 :--%>
    <%--        <textarea class="product-element" minlength="10" placeholder="최소 10글자 이상 작성해주세요."><%= product.getDesc() %></textarea>--%>
    <%--    </p>--%>
    <%--    <p>상품이미지 : <input class="product-element" type="file" accept="image/*"></p>--%>
    <%--</div>--%>
    <%--<!-- 상품 수정 버튼 -->--%>
    <%--<div class="add-button">--%>
    <%--    <a id="add-button" href="#">상품수정</a>--%>
    <%--</div>--%>
    <!--상품 데이터 입력 영역 form 태그로 변경-->
    <div class="product-data">
        <input type="hidden" name="pid" value="<%= product.getPid() %>">
        <p>상품이름 : <input class="product-element" type="text" name="modify_name" value="<%= product.getProduct_name() %>"></p>
        <p>상품가격 : <input class="product-element" type="text" name="modify_cost" value="<%= product.getCost() %>"></p>
        <p>상품수량 : <input class="product-element" type="number" name="modify_stock" value="<%= product.getStock() %>"></p>
        <p>상품설명 : <textarea class="product-element" name="modify_desc" minlength="10" placeholder="최소 10글자 이상 작성해주세요."><%= product.getDesc() %></textarea></p>
        <p>상품이미지 : <input class="product-element" type="file" name="modify_pimage" accept="image/*"></p>
    </div>
    <!-- 상품 수정 버튼 -->
    <div class="add-button">
        <button type="submit">상품수정</button>
    </div>
</form>
</section>
<!-- 상품 수정 버튼 클릭 시 alert창 띄우기 -->
<script src="../../jquery.min.js"></script>
<script src="product-update.js"></script>
</body>
</html>
