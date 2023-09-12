<%@ page import="java.io.PrintWriter" %>
<%@ page import="mysql.db_DAO.CustomerDAO" %><%--
  Created by IntelliJ IDEA.
  User: elane
  Date: 2023-08-17
  Time: PM 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>개인 정보 수정  디비에 반영하기</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String currentUser = (String) session.getAttribute("memberEmail");

    String modify_name = request.getParameter("modify_name"); // 이름
    String modify_pw = request.getParameter("modify_pw"); // 비밀번호
    String modify_phone = request.getParameter("modify_phone"); // 전화번호
    String modify_birthday = request.getParameter("modify_birthday"); // 생년월일
    String modify_sex = request.getParameter("modify_sex"); // 성별
    String post_code  = request.getParameter("user_postcode"); // 우편 번호
    String road_address = request.getParameter("user_roadAddress"); // 도로명 주소
    String jibun_address = request.getParameter("user_jibunAddress"); // 지번 주소
    String detail_address = request.getParameter("user_detailAddress"); // 상세 주소
    String extra_address = request.getParameter("user_extraAddress"); // 참고항목
    String full_address = road_address + "," + jibun_address + "," + detail_address + "," + extra_address;

    CustomerDAO customerDAO = new CustomerDAO();
    int update_data = customerDAO.customerUpdateInfo(currentUser, modify_name, modify_pw, modify_phone, modify_birthday, modify_sex, post_code, full_address);

    if(update_data > 0){
        // 데이터 삽입 성공
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('정보 수정 성공')");
        script.println("location.href='../seller-home/seller-home.html';");
        script.println("</script>");
        script.close();
        return;
    }else {
        // 데이터 삽입 실패
        out.println("데이터 삽입 실패");
        out.println(update_data);
    }
%>

</body>
</html>
