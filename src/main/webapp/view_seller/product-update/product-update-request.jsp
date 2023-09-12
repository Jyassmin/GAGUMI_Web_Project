<%@ page import="java.io.PrintWriter" %>
<%@ page import="mysql.db_DAO.ProductDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: a0109
  Date: 2023-08-18
  Time: PM 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품 정보 수정 디비에 반영하기</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String currentUser = (String) session.getAttribute("memberEmail");

    String modify_name = request.getParameter("modify_name"); // 상품이름
    int modify_cost = Integer.parseInt(request.getParameter("modify_cost")); // 상품가격
    int modify_stock = Integer.parseInt(request.getParameter("modify_stock")); // 상품수량
    String modify_desc = request.getParameter("modify_desc"); // 상품설명
    String modify_pimage = request.getParameter("modify_pimage"); // 상품이미지
    String oldImg = request.getParameter("old_img"); // 상품 변경 전 이미지
    String imgPath = oldImg;
    if(modify_pimage != ""){
        imgPath = "../../images/" + modify_pimage;
    }

    ProductDAO productDAO = new ProductDAO();

    // <product-update.jsp>에서 가져온 상품 코드(pid)를 사용하여 상품 정보를 업데이트합니다.
    String pidParam = request.getParameter("pid");
    int targetPid = 0;
    if (pidParam != null && !pidParam.isEmpty()) {
        targetPid = Integer.parseInt(pidParam);
    }

    // 상품 정보 업데이트 시도
    int update_data = productDAO.productUpdateInfo(currentUser, modify_name, modify_cost, modify_stock, modify_desc, imgPath, targetPid);

    if(update_data > 0){
        // 데이터 업데이트 성공
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('상품 수정을 성공하였습니다.')");
        script.println("location.href='../product-read/product-read.jsp';");
        script.println("</script>");
        script.close();
    } else {
        // 데이터 업데이트 실패
        out.println("데이터 삽입 실패.");
        out.println(update_data);
    }
%>
</body>
</html>