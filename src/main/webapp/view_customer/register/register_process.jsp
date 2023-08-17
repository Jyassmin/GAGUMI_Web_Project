<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mysql.db_dao"%>
<%@ page import="java.io.PrintWriter"%>
<%
    // 사용자가 보낸 데이터를 한글을 사용할 수 있는 형식으로 변환
    request.setCharacterEncoding("UTF-8");

    // 이전 페이지에서 데이터 가져오기(null체크x. input이 required라 다 들어있음)
    String page_role = request.getParameter("page_role"); // 0(cutomer) 또는 1(seller) 페이지에서 온건지 확인
    String user_name = request.getParameter("user_name");
    String user_email = request.getParameter("user_email");
    String user_pw = request.getParameter("user_pw");
    String user_phone = request.getParameter("user_phone");

    String user_birthday = null; // 고객만
    String user_gender = null; // 고객만
    String user_company = null; // 판매자만
    if (page_role.equals("0")) {
        user_birthday = request.getParameter("user_birthday");
        user_gender = request.getParameter("user_gender");
    } else {
        user_company = request.getParameter("user_company"); // 고객이면 ""로 가져오기 떄문에 그대로 null로 저장
    }

    String user_postcode  = request.getParameter("user_postcode"); // 우편 번호
    String user_roadAddress = request.getParameter("user_roadAddress"); // 도로명 주소
    String user_jibunAddress = request.getParameter("user_jibunAddress"); // 지번 주소
    String detail_address = request.getParameter("user_detailAddress"); // 상세 주소
    String user_extraAddress = request.getParameter("user_extraAddress"); // 참고항목
    String full_address = user_roadAddress + "," + user_jibunAddress + "," + detail_address + "," + user_extraAddress;

    // 쿼리 실행
    // userDao.regiser에 계정 삽입 성공 시 1 리턴 받음.
    db_dao userDao = new db_dao();
    int check_insert = userDao.regiser(page_role, user_name, user_email, user_pw, user_phone
            , user_birthday, user_gender, user_company, full_address, user_postcode);

    // 결과 처리
    PrintWriter script;
    script = response.getWriter();
    script.println("<script>");
    if (check_insert == 1) {
        script.println("alert('회원가입이 완료되었습니다. 로그인하여 이용하실 수 있습니다.')");
        if (page_role.equals("0")) {
            script.println("location.href='../login/login_customer.jsp?register_success=1&user_email=" + user_email + "';");
        } else {
            script.println("location.href='../login/login_seller.jsp?register_success=1&user_email=" + user_email + "';");
        }
    } else {
        script.println("alert('회원가입에 실패했습니다.')"); // 아이디 중복 체크 해야함
        script.println("location.href='./register_customer.jsp';");
    }
    script.println("</script>");
    script.close();
    return;
%>