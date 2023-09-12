package mysql.db_DAO;

import mysql.db_util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PayDAO {
    HistoryDAO historyDAO = new HistoryDAO();
    // 제품 수량 수정 함수
    public int modifyQuantity(String[] sid_array){
        Connection conn = db_util.getConnection();
        int result = 0;
        String sql = "UPDATE product SET stock = (stock - ?) WHERE pid = ?;";
        try {
            for (String sid : sid_array) {
                int product_quan = historyDAO.getQuanBySid(sid);
                int product_pid = historyDAO.getPidBySid(sid);

                PreparedStatement ptsmt = conn.prepareStatement(sql);
                ptsmt.setInt(1, product_quan);
                ptsmt.setInt(2, product_pid);

                result += ptsmt.executeUpdate();
            }
            return result;

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
