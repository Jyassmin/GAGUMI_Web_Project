<%@ page import="mysql.db_dao" %>
<%@ page import="java.io.PrintWriter" %>
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

    db_dao userDao = new db_dao();
    int update_data = userDao.productUpdateInfo(currentUser, modify_name, modify_cost, modify_stock, modify_desc, modify_pimage);

    if(update_data > 0){
        //데이터 삽입 성공
        // 업데이트 성공
        out.println("정보 수정 성공: " + update_data + "개의 행이 업데이트되었습니다.");
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('정보 수정 성공')");
        script.println("location.href='../seller-home/seller-home.jsp';");
        script.println("</script>");
        script.close();
        return;
    }else {
        // 데이터 삽입 실패
        out.println("데이터 삽입 실패");
// 업데이트 실패
        out.println("정보 수정 실패: 행이 업데이트되지 않았습니다.");
        out.println(update_data);
    }
%>
  </body>
</html>
