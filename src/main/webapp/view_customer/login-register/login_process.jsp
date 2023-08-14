<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="mysql.db_dto"%>
<%@ page import="mysql.db_dao"%>
<%@ page import="java.io.PrintWriter"%>
<%
    // 사용자가 보낸 데이터를 한글을 사용할 수 있는 형식으로 변환
    request.setCharacterEncoding("UTF-8");

    // 이전 페이지에서 데이터 가져오기(null체크)
    String uid = null;
    String upw = null;
    if (request.getParameter("input_id") != null) {
        uid = request.getParameter("input_id");
    }
    if (request.getParameter("input_pw") != null) {
        upw = request.getParameter("input_pw");
    }
    if (uid == null || upw == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('아이디 또는 비밀번호를 입력해주세요.')");
        script.println("</script>");
        script.close();
        return;
    }

    // 쿼리 실행
    db_dao userDao = new db_dao();
    int check_account = userDao.login(uid, upw); // 로그인 실패 0, 성공 1

//    if (check_account == 1) {
//        out.println("로그인 되었습니다.");
//    } else {
//        out.println("아이디 또는 비밀번호가 일치하지 않습니다.");
//    }

    if (check_account == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인에 성공했습니다.')");
        script.println("location.href='../home/home.html';");
        script.println("</script>");
        script.close();
        return;
    }
//    } else {
//        PrintWriter script = response.getWriter();
//        script.println("<script>");
//        script.println("아이디 또는 비밀번호가 일치하지 않습니다.");
//        script.println("location.href='./login.html';");
//        script.println("</script>");
//        script.close();
//        return;
//    }
%>
