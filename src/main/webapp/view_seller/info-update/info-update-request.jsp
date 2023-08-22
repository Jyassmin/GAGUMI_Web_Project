<%@ page import="mysql.db_dao" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: elane
  Date: 2023-08-15
  Time: PM 5:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>정보 수정 디비에 반영하기</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String currentUser = (String) session.getAttribute("memberEmail");

    String modify_name = request.getParameter("modify_name"); // 이름
    String modify_pw = request.getParameter("modify_pw"); // 비밀번호
    String modify_phone = request.getParameter("modify_phone"); // 전화번호
    String modify_company = request.getParameter("modify_company"); // 회사명
    String post_code  = request.getParameter("user_postcode"); // 우편 번호
    String road_address = request.getParameter("user_roadAddress"); // 도로명 주소
    String jibun_address = request.getParameter("user_jibunAddress"); // 지번 주소
    String detail_address = request.getParameter("user_detailAddress"); // 상세 주소
    String extra_address = request.getParameter("user_extraAddress"); // 참고항목
    String full_address = road_address + "," + jibun_address + "," + detail_address + "," + extra_address;

    db_dao userDao = new db_dao();
    int update_data = userDao.sellerUpdateInfo(currentUser, modify_name, modify_pw, modify_phone, modify_company, post_code, full_address);
    PrintWriter script = response.getWriter();
    if(update_data > 0){
        // 데이터 삽입 성공
        script.println("<script>");
        script.println("alert('정보 수정 성공')");
        script.println("location.href='../seller-home/seller-home.jsp';");
        script.println("</script>");
        return;
    }else {
        // 데이터 삽입 실패
        script.println("<script>");
        script.println("alert('정보 수정 실패')");
        script.println("window.history.back();");
        script.println("</script>");
    }
    script.close();
%>
</body>
</html>
