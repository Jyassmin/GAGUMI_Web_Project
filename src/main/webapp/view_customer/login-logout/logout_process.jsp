<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter"%>
<%
    // 사용자가 보낸 데이터를 한글을 사용할 수 있는 형식으로 변환
    request.setCharacterEncoding("UTF-8");

    // 세선으로 이메일 가져오기.
    String user_email = (String) session.getAttribute("memberEmail");

    // 세션 완전 삭제
    session.removeAttribute("memberEmail");
    //session.invalidate();

    // 로그 아웃 됐다고 alert & index 페이지로 이동
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('로그아웃이 성공적으로 완료되었습니다.')");
    script.println("location.href='../../index.jsp';");
    script.println("</script>");
    script.close();

    return;
%>