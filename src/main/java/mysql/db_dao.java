package mysql;

import java.sql.*;


// DAO(Data Access Object): 데이터베이스에 직접 접근하여 데이터 처리를 하는 클래스
// form에서 입력받은 데이터를 받아, sql문을 만들어 실행하고, 결과를 반환

public class db_dao {
    Connection conn = db_util.getConnection();

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

    public int regiser(String userID, String userPassword) {
        String SQL = "";

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

    /*제품 등록 함수*/
    public int product_add(int userID, int category2, String p_name, int stock, int cost, String desc, String p_iamge, String size) {
//
        String SQL = "INSERT INTO product (uid, ca2id, name, stock, cost, `desc`, pimage, size) values (?,?,?,?,?,?,?,?);";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setInt(1, userID);
            pstmt.setInt(2, category2);
            pstmt.setString(3, p_name);
            pstmt.setInt(4, stock);
            pstmt.setInt(5, cost);
            pstmt.setString(6, desc);
            pstmt.setString(7, p_iamge);
            pstmt.setString(8, size);

            // 명령어를 수행한 결과
            // 1_execute -> 테이블 생성, 수정, 삭제 등 데이터베이스 관리 명령어 사용(table)
            // 2_executeUpdate -> 레코드 삽입, 수정, 삭제 등 데이터 조작 명령어 사용(CRUD)
            // 3_executeQuery -> 레코드 조회, 테이블 조회 등 조회 명령어 사용(Select)

            return pstmt.executeUpdate(); // 1은 데이터 삽입 성공, 0은 데이터 삽입 실패

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