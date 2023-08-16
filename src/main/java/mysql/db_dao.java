package mysql;
import java.util.ArrayList;
import java.sql.*;
import java.util.List;

import static java.lang.System.out;


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
  
    // 일단 uid가 1인 사람이 등록한 상품내역을 가져오는 함수
    public List<db_dto> print_product(String email ) {

        String SQL = "SELECT * FROM product WHERE uid = ?";
        List<db_dto> productList = new ArrayList<>();

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                db_dto product = new db_dto();
                product.setOrderNumber(rs.getInt("uid"));
                product.setImage(rs.getString("pimage"));
                product.setProductName(rs.getString("name"));
                product.setProductCategory(rs.getInt("ca2id"));
                product.setProductPrice(rs.getInt("cost"));
                product.setProductQuantity(rs.getInt("stock"));
                product.setProductDescription(rs.getString("desc"));
                product.setSize(rs.getString("size"));
                productList.add(product);
            }

            rs.close();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // ... (연결 해제 등의 처리)
        }

        return productList;
    }


    public String getNameByUid(String userId) {

        String SQL = "SELECT name from user where email=?";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            String result_name = rs.getString(1);
            rs.close();

            return result_name; // name 반환

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
        return null;
    }

    // 고객정보 수정 시 업데이트 하는 함수
    public int sellerUpdateInfo(String name, String pw, String phone, String company, String post_code, String full_address){
        // 권한에 맞춰서 다르게 작성 - role(0 고객, 1 판매자)
        //(판매자) UPDATE user SET name = ?, pw = ?, phone = ?, company = ?, address = ? WHERE role = 1 AND UID = ?;
        //(고객 ) UPDATE user SET name = ?, pw =?, phone =?, gender = ?, birthday =?, address =? WHERE role = 0 AND UID = ?;
        //판매자
        String SQL = "UPDATE user SET name = ?, pw = ?, phone = ?, company = ?, address = ? WHERE role = 1 AND UID = ?;";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, name);
            pstmt.setString(2, pw);
            pstmt.setString(3, phone);
            pstmt.setString(4, company);
            pstmt.setString(5, full_address);
            //pstmt.setString(6, full_address);
            pstmt.setInt(6, 10);

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