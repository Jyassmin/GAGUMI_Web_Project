package mysql;
import java.util.ArrayList;
import java.sql.*;
import java.util.HashMap;
import java.util.List;

import static java.lang.System.out;


// DAO(Data Access Object): 데이터베이스에 직접 접근하여 데이터 처리를 하는 클래스
// form에서 입력받은 데이터를 받아, sql문을 만들어 실행하고, 결과를 반환

public class db_dao {
    Connection conn = db_util.getConnection();

    /*login : 입력받은 id, pw가 user테이블에 있는지 확인. 있다면 1. 없다면 0 반환*/
    public int login(String userEmail, String userPassword) {
        String SQL = "SELECT count(*) AS total FROM user where email=? AND pw=?";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, userEmail);
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
    public int product_add(String currentUser, int category2, String p_name, int stock, int cost, String desc, String p_iamge, String size) {
        int uid = getUidByEmail(currentUser);
        String SQL = "INSERT INTO product (uid, ca2id, name, stock, cost, `desc`, pimage, size) values (?,?,?,?,?,?,?,?);";
        if
        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setInt(1, uid);
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


        String SQL = "SELECT * FROM product WHERE uid = 1";

        List<db_dto> productList = new ArrayList<>();

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                db_dto product = new db_dto();
                product.setProductNumber(rs.getInt("pid"));
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

    // "000님 환영합니다"를 위해 세션(email)을 주면 name 반환해주는 함수.
    public int getNameByEmail(String userEmail) {

        String SQL = "SELECT name from user where email=?";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, userEmail);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int result_name = rs.getInt(1);
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
        return -1;
    }

    // 현재 로그인한 유저의 session Email을 활용하여 UID 가져오는 함수
    public int getUidByEmail(String userEmail) {

        String SQL = "SELECT uid from user where email=?";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, userEmail);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int result_uid = rs.getInt(1);
            rs.close();

            return result_uid; // name 반환

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

    // 고객정보 수정 시 업데이트 하는 함수
    public int sellerUpdateInfo(String name, String pw, String phone, String company, String post_code, String full_address){
        // 권한에 맞춰서 다르게 작성 - role(0 고객, 1 판매자)
        //(판매자) UPDATE user SET name = ?, pw = ?, phone = ?, company = ?, address = ? WHERE role = 1 AND UID = ?;
        //(고객 ) UPDATE user SET name = ?, pw =?, phone =?, gender = ?, birthday =?, address =? WHERE role = 0 AND UID = ?;
        //판매자
        String SQL = "UPDATE user SET name = ?, pw = ?, phone = ?, company = ?, address = ?, zipcode = ? WHERE role = 1 AND UID = ?;";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, name);
            pstmt.setString(2, pw);
            pstmt.setString(3, phone);
            pstmt.setString(4, company);
            pstmt.setString(5, full_address);
            pstmt.setString(6, post_code);
            //pstmt.setString(6, full_address);
            pstmt.setInt(7, 10);

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


    //카테고리 숫자를 문자로 바꾸어주는 함수
    public String getCategoryText(int category) {
        String[] categoryArray = {
                "스툴",
                "화장대 의자",
                "소파 - 소",
                "소파 - 중",
                "소파 - 대",
                "서랍",
                "수납장",
                "책상",
                "식탁",
                "침대",
                "장롱"
        };

        if (category >= 1 && category <= categoryArray.length) {
            return categoryArray[category - 1];
        } else {
            return "Unknown";
        }
    }
    //pid기준으로 상품 삭제해주는 함수
    public int deleteProduct(int pid) {
        out.println("함수들어옴");
        String SQL = "DELETE FROM product WHERE pid = ? ";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, pid);

            int result = pstmt.executeUpdate(); // 1은 삭제 성공, 0은 삭제 실패

            pstmt.close(); // Statement 닫기

            return result;

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            try {
                if (conn != null && !conn.isClosed())
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return -1;

    // 정보 수정 시 판매자의 개인정보 가져오는 함수
    public HashMap<String, String> getSellerInfo(String email){
        String SQL = "select email, name, pw, phone, company, address, zipcode from user where uid = ?;";

        HashMap<String, String> sellerInfo = new HashMap<>();
        ResultSet rs = null;
        try {
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            pstmt.setInt(1, 10); // 판매자 ID를 설정하세요
            rs = pstmt.executeQuery();

            if (rs.next()) {
                sellerInfo.put("email", rs.getString("email"));
                sellerInfo.put("name", rs.getString("name"));
                sellerInfo.put("pw", rs.getString("pw"));
                sellerInfo.put("phone", rs.getString("phone"));
                sellerInfo.put("company", rs.getString("company"));
                String fullAddress = rs.getString("address");
                String[] addressParts = fullAddress.split(","); // 쉼표로 구분된 부분 분리
                sellerInfo.put("roadAddress", addressParts[0]); // 첫 번째 부분 저장
                sellerInfo.put("jibunAddress", addressParts[1]); // 두 번째 부분 저장
                sellerInfo.put("detailAddress", addressParts[2]); // 세 번째 부분 저장
                sellerInfo.put("extraAddress", addressParts[3]); // 네 번째 부분 저장
                sellerInfo.put("postCode", rs.getString("zipcode"));
            }
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

        return sellerInfo;

    }
}

// 참고) 전체 출력 코드
//        while (rs.next())
//        {
//            out.println("count = " + rs.getInt(1));