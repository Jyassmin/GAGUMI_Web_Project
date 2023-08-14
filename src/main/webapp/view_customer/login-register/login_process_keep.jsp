<%--
  Created by IntelliJ IDEA.
  User: kyle
  Date: 2023/08/13
  Time: 4:19 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String uid = request.getParameter("input_id"); // test
    String upw = request.getParameter("input_pw"); // 1234
    String sql = "SELECT count(*) AS total FROM user where email=? AND pw=?";

    String url = "jdbc:mysql://localhost:3306/gagumi_db"; // db선택
    String userName = "root"; // email
    String password = "12341234"; // pw
    Connection conn = null;
    Statement sm = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, userName, password); // db 연결 매니저
        sm = conn.createStatement();
        out.println("연결 완료");

        // 결과 가져오기
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, uid);
        pstmt.setString(2, upw);

        // 1_execute -> 테이블 생성, 수정, 삭제 등 데이터베이스 관리 명령어 사용(table)
        // 2_executeUpdate -> 레코드 삽입, 수정, 삭제 등 데이터 조작 명령어 사용(CRUD)
        // 3_executeQuery -> 레코드 조회, 테이블 조회 등 조회 명령어 사용(Select)
        ResultSet rs = pstmt.executeQuery();
        rs.next();
        int totalCount = rs.getInt(1);
        rs.close();

        // 참고) 전체 출력 코드
//        while (rs.next())
//        {
//            out.println("count = " + rs.getInt(1));
//        }

        // 계정 확인
        if (totalCount == 1) {
            out.println("로그인 되었습니다.");
        } else {
            out.println("아이디 또는 비밀번호가 일치하지 않습니다.");
        }

    } catch (SQLException | ClassNotFoundException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    } finally {
        try {
            if(conn != null&& !conn.isClosed())
                conn.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
%>

