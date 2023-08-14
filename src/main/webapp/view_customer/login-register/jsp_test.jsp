<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%

    String url = "jdbc:mysql://localhost:3306/gagumi_db"; // db선택
    String userName = "root"; // email
    String password = "12341234"; // pw
    Connection conn = null;
    Statement sm = null;


//    1_execute -> 테이블 생성, 수정, 삭제 등 데이터베이스 관리 명령어 사용
//    2_executeUpdate -> 레코드 삽입, 수정, 삭제 등 데이터 조작 명령어 사용
//    3_executeQuery -> 레코드 조회, 테이블 조회 등 조회 명령어 사용

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, userName, password); // db 연결 매니저
        sm = conn.createStatement();

        ResultSet resultSet = sm.executeQuery("select * from user"); // sql문 실행하여 결과 저장
        resultSet.next();
        String name = resultSet.getString("name"); // name 컬럼 가져오기
        out.println(name);

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

