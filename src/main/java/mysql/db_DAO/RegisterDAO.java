package mysql.db_DAO;

import mysql.db_util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterDAO {

    // 회원가입 함수
    public int regiser(String page_role, String user_name, String user_email, String user_pw, String user_phone
            , String user_birthday, String user_gender, String user_company, String full_address ,String user_postcode) {
        Connection conn = db_util.getConnection();

        try {
            String SQL;
            PreparedStatement pstmt;

            SQL = "INSERT INTO user (role, name, email, pw, phone, gender, birthday, company, address, zipcode) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, page_role);
            pstmt.setString(2, user_name);
            pstmt.setString(3, user_email);
            pstmt.setString(4, user_pw);
            pstmt.setString(5, user_phone);
            pstmt.setString(6, user_gender);
            pstmt.setString(7, user_birthday);
            pstmt.setString(8, user_company);
            pstmt.setString(9, full_address);
            pstmt.setString(10, user_postcode);

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
