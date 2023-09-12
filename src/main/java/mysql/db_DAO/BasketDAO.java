package mysql.db_DAO;

import mysql.db_DTO.ShoppingCartDTO;
import mysql.db_util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BasketDAO {
    LoginDAO loginDAO = new LoginDAO();
    // 장바구니 담기 함수
    public int insertShoppingCart(String currentUser, int pid, int quantity) {
        Connection conn = db_util.getConnection();
        int uid = loginDAO.getUidByEmail(currentUser);
        String sql = "INSERT INTO shoppingcart (uid, pid, quantity) VALUES (?,?,?)";
        try {
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement ptsmt = conn.prepareStatement(sql);
            ptsmt.setInt(1, uid);
            ptsmt.setInt(2, pid);
            ptsmt.setInt(3, quantity);

            return ptsmt.executeUpdate();

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

    //uid기준으로 장바구니 데이터 출력해주는 함수 (이미지 / 제품명 / 주문 수량 / 총 금액)
    public List<ShoppingCartDTO> getShoppingCart(String currentUser) {
        List<ShoppingCartDTO> cartItems = new ArrayList<>();

        try (Connection conn = db_util.getConnection()) {
            int uid = loginDAO.getUidByEmail(currentUser);
            String sql = "SELECT sc.sid, p.pimage, p.name, sc.quantity, p.cost FROM shoppingcart sc JOIN product p ON sc.pid = p.pid WHERE sc.uid = ?";

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, uid);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    // 데이터베이스 결과에서 필요한 정보 추출
                    int sid = rs.getInt("sid");
                    String pimage = rs.getString("pimage");
                    String name = rs.getString("name");
                    int cost = rs.getInt("cost");
                    int quantity = rs.getInt("quantity");
                    // ShoppingCartDTO 객체 생성 및 리스트에 추가
                    ShoppingCartDTO shoppingCart = new ShoppingCartDTO(sid, pimage, name, cost, quantity);
                    cartItems.add(shoppingCart);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItems;
    }

    //sid기준으로 상품 삭제해주는 함수 - 장바구니 목록 삭제
    public int deleteShoppingCart(int sid) {
        Connection conn = db_util.getConnection();
        String SQL = "DELETE FROM shoppingcart WHERE sid = ? ";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, sid);

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
        return 0; //삭제 실패한 경우
    }


    // 구매 후 장바구니 목록에서 삭제
    public int deleteByBuy(String[] sid){
        int result = 0;
        for(int i=0; i<sid.length; i++){
            int oneSid = Integer.parseInt(sid[i]);
            result += deleteShoppingCart(oneSid);
        }
        return result;
    }

    //
    public String getEmailBySid(String sellerEmail) {
        Connection conn = db_util.getConnection();
        String SQL = "select u.email from product p join shoppingcart s on p.pid = s.sid join user u on p.uid = u.uid where s.sid = ?;";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, sellerEmail);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            String result_email = rs.getString(1);
            rs.close();

            return result_email; // name 반환

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
