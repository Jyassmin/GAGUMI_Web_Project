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

    String sql = "SELECT count(*) FROM user";
    // where email='uid' AND pw=upw
    sql += "where email='" + uid + "' AND pw=" + upw;


    String url = "jdbc:mysql://localhost:3306/gagumi_db"; // db선택
    String userName = "root"; // email
    String password = "12341234"; // pw
    Connection conn = null;
    Statement sm = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, userName, password); // db 연결 매니저
        Statement sm = conn.createStatement();

        // 총 레코드 개수 가져오기
        int count = sm.executeUpdate(sql);
        count.next();
        int totalCount = count.getInt("total");
        if(totalCount == 1) {
            out.println("로그인 되었습니다.");
        } else {
            out.println("아이디 또는 비밀번호가 일치하지 않습니다.");
        }

    } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();

    } catch (ClassNotFoundException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();

    }finally {
        try {
            if(conn != null&& !conn.isClosed())
                conn.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

//    ResultSet resultCnt = statement.executeQuery(sql);
//    resultCnt.next();
//    int totalCount = resultCnt.getInt("total");
//    resultCnt.close();
//
//    System.out.println(resultCnt);

%>

