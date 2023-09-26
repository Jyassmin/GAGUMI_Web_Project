package mysql.db_DAO;

import mysql.db_util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class CustomerDAO {
    LoginDAO loginDAO = new LoginDAO();
    // 고객 정보 수정 디비에 적용하는 함수
    public int customerUpdateInfo(String currentUser, String modifyName, String modifyPw, String modifyPhone, String modifyBirthday, String modifySex, String postCode, String fullAddress) {
        Connection conn = db_util.getConnection();
        int currentUID = loginDAO.getUidByEmail(currentUser);
        // 권한에 맞춰서 다르게 작성 - role(0 고객, 1 판매자)
        //(판매자) UPDATE user SET name = ?, pw = ?, phone = ?, company = ?, address = ? WHERE role = 1 AND UID = ?;
        //(고객 ) UPDATE user SET name = ?, pw =?, phone =?, gender = ?, birthday =?, address =? WHERE role = 0 AND UID = ?;
        //판매자
        String SQL = "UPDATE user SET name = ?, pw =?, phone =?, gender = ?, birthday =?, address =?, zipcode = ? WHERE role = 0 AND UID = ?;";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, modifyName);
            pstmt.setString(2, modifyPw);
            pstmt.setString(3, modifyPhone);
            pstmt.setString(4, modifySex);
            pstmt.setString(5, modifyBirthday);
            pstmt.setString(6, fullAddress);
            pstmt.setString(7, postCode);
            pstmt.setInt(8, currentUID);

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

    // 현재 로그인한 고객 정보 가져오는 함수
    public HashMap<String, String> getCustomerInfo(String currentUser) {
        Connection conn = db_util.getConnection();
        int currentUID = loginDAO.getUidByEmail(currentUser);
        String SQL = "select email, name, pw, phone, gender, birthday, address, zipcode from user where role = 0 AND uid = ?;";

        HashMap<String, String> customerInfo     = new HashMap<>();
        ResultSet rs = null;
        try {
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, currentUID); // 고객 UID
            System.out.println(currentUID);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                customerInfo.put("email", rs.getString("email")); // 이메일
                customerInfo.put("name", rs.getString("name")); // 이름
                customerInfo.put("pw", rs.getString("pw")); // 비밀번호
                customerInfo.put("phone", rs.getString("phone")); // 전화번호
                String gender = String.valueOf((rs.getInt("gender"))); // 성별
                customerInfo.put("gender", gender);
                customerInfo.put("birthday", rs.getString("birthday")); // 생년월일
                String fullAddress = rs.getString("address"); // 주소
                String[] addressParts = fullAddress.split(","); // 쉼표로 구분된 부분 분리
                customerInfo.put("roadAddress", addressParts[0]); // 첫 번째 부분 저장
                customerInfo.put("jibunAddress", addressParts[1]); // 두 번째 부분 저장
                customerInfo.put("detailAddress", addressParts[2]); // 세 번째 부분 저장
                customerInfo.put("extraAddress", addressParts[3]); // 네 번째 부분 저장
                customerInfo.put("postCode", rs.getString("zipcode")); // 우편 번호
            }
            return customerInfo;
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
}
