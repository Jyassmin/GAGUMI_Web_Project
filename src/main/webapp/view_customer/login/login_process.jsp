<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mysql.db_dao"%>
<%@ page import="java.io.PrintWriter"%>
<%
    // 사용자가 보낸 데이터를 한글을 사용할 수 있는 형식으로 변환
    request.setCharacterEncoding("UTF-8");

    // 이전 페이지에서 데이터 가져오기(null체크)
    String page_role = request.getParameter("page_role"); // 0(cutomer) 또는 1(seller) 페이지에서 온건지 확인
    System.out.println(page_role);
    String user_email = null; // test
    String user_pw = null; // 12341234
    if (request.getParameter("input_id") != null) {
        user_email = request.getParameter("input_id");
    }
    if (request.getParameter("input_pw") != null) {
        user_pw = request.getParameter("input_pw");
    }
    if (user_email == null || user_pw == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('아이디 또는 비밀번호를 입력해주세요.')");
        script.println("</script>");
        script.close();
        return;
    }

    // 쿼리 실행
    db_dao userDao = new db_dao();
    int check_account = userDao.login(page_role, user_email, user_pw); // 로그인 실패 0, 성공 1

    // 결과 처리
    PrintWriter script;
    script = response.getWriter();
    script.println("<script>");
    if (check_account == 1) {
        session.setAttribute("memberEmail", user_email); // 세션생성
        session.setAttribute("memberPw", user_pw);
        script.println("alert('로그인에 성공했습니다.')");
        if (page_role.equals("0")) { // Customer
            script.println("location.href='../home/home.jsp';");
        } else { // Seller
            script.println("location.href='../../view_seller/seller-home/seller-home.html';");
        }

    } else {
        script.println("alert('아이디 또는 비밀번호가 일치하지 않습니다.')");
        script.println("location.href='./login.html';");
    }
    script.println("</script>");
    script.close();
    return;
%>