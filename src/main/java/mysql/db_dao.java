package mysql;

import java.sql.*;


// DAO(Data Access Object): 데이터베이스에 직접 접근하여 데이터 처리를 하는 클래스
// form에서 입력받은 데이터를 받아, sql문을 만들어 실행하고, 결과를 반환

public class db_dao {
    Connection conn = db_util.getConnection();

    /*login : 입력받은 id, pw가 user테이블에 있는지 확인. 있다면 1. 없다면 0 반환*/
    public int login(String userID, String userPassword) {
        String SQL = "SELECT count(*) AS total FROM user where email=? AND pw=?";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, userID);
            pstmt.setString(2, userPassword);

            // 명령어를 수행한 결과
            // 1_execute -> 테이블 생성, 수정, 삭제 등 데이터베이스 관리 명령어 사용(table)
            // 2_executeUpdate -> 레코드 삽입, 수정, 삭제 등 데이터 조작 명령어 사용(CRUD)
            // 3_executeQuery -> 레코드 조회, 테이블 조회 등 조회 명령어 사용(Select)
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int totalCount = rs.getInt(1);
            rs.close();

            return totalCount; // 1은 로그인 성공, 0은 로그인 실패

        } catch (SQLException e) {
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
        return -1;
    }

    public int regiser(String user_name, String user_email, String user_pw, String user_phone
            , String user_birthday, String user_gender, String user_company, String user_address) {

        try {
            String SQL;
            PreparedStatement pstmt;

            // 실행 가능 상태의 sql문으로 만듦.
            if (user_company == null) { // 고객일 떄 role 0, 판매자는 1.
                SQL = "INSERT INTO user (name, role, email, pw, phone, gender, birthday, address) " +
                        "VALUES (?, 0, ?, ?, ?, ?, ?, ?)";

                pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, user_name);
                pstmt.setString(2, user_email);
                pstmt.setString(3, user_pw);
                pstmt.setString(4, user_phone);
                pstmt.setString(5, user_gender);
                pstmt.setString(6, user_birthday);
                pstmt.setString(7, user_address);

            } else {
                SQL = "INSERT INTO user (name, role, email, pw, phone, company, address) " +
                        "VALUES (?, 1, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, user_name);
                pstmt.setString(2, user_email);
                pstmt.setString(3, user_pw);
                pstmt.setString(4, user_phone);
                pstmt.setString(5, user_company);
                pstmt.setString(6, user_address);
            }

            // 명령어를 수행한 결과
            // execute -> 테이블 생성, 수정, 삭제 등 데이터베이스 관리 명령어 사용(table)
            // executeUpdate -> 레코드 삽입, 수정, 삭제 등 데이터 조작 명령어 사용(CRUD)
            // executeQuery -> 레코드 조회, 테이블 조회 등 조회 명령어 사용(Select)
            return pstmt.executeUpdate(); // insert된 레코드 수. 1이면 삽입 성공!

        } catch (SQLException e) {
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
        return -1;
    }
}

// 참고) 전체 출력 코드
//        while (rs.next())
//        {
//            out.println("count = " + rs.getInt(1));