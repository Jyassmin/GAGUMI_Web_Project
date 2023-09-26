package mysql.db_DAO;

import mysql.db_DTO.ProductDTO;
import mysql.db_util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class HistoryDAO {
    LoginDAO loginDAO = new LoginDAO();
    ProductDAO productDAO = new ProductDAO();

    public int getPidBySid(String sid) {
        Connection conn = db_util.getConnection();
        String SQL = "SELECT pid from shoppingcart where sid=?";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, sid);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int result_pid = rs.getInt(1);
            rs.close();

            return result_pid; // name 반환

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

    public int getQuanBySid(String sid) {
        Connection conn = db_util.getConnection();
        String SQL = "SELECT quantity from shoppingcart where sid=?";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, sid);
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            int result_quan = rs.getInt(1);
            rs.close();

            return result_quan; // name 반환

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

    // 장바구니 구매 후 구매목록에 담기 함수
    public int insertHistory(int uid, String[] selectedItems, String strdate) {
        Connection conn = db_util.getConnection();
        int cnt = 0;
        String sql = "INSERT INTO history (uid, pid, oid, quantity, pname, cost, datetime, pimage, uid_seller) VALUES (?,?,?,?,?,?,?,?,?)";
        try {
            int new_oid = getLastOid() + 1;
            for (String item_sid : selectedItems) {
                int product_pid = getPidBySid(item_sid);
                int uid_seller = getUidByPid(product_pid);
                int product_quan = getQuanBySid(item_sid);
                ProductDTO pdto = productDAO.printProductDetail(product_pid); // 물품 정보 가져오기


                // 데이터베이스 연결 및 쿼리 실행
                PreparedStatement ptsmt = conn.prepareStatement(sql);
                ptsmt.setInt(1, uid);
                ptsmt.setInt(2, product_pid);
                ptsmt.setInt(3, new_oid);
                ptsmt.setInt(4, product_quan);
                ptsmt.setString(5, pdto.getProduct_name());
                ptsmt.setInt(6, pdto.getCost());
                ptsmt.setString(7, strdate);
                ptsmt.setString(8, pdto.getPimage());
                ptsmt.setInt(9, uid_seller);
                cnt += ptsmt.executeUpdate();
            }
            return cnt;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null && !conn.isClosed())
                    conn.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return -1;
    }

    public int getLastOid() {
        Connection conn = db_util.getConnection();
        String sql =  "SELECT MAX(oid) FROM history";
        try {
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement ptsmt = conn.prepareStatement(sql);
            ResultSet rs = ptsmt.executeQuery();
            rs.next();
            int lastOid = rs.getInt(1);
            rs.close();

            return lastOid;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null && !conn.isClosed())
                    conn.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return -1;
    }

    // 고객의 email을 받아 주문 목록 출력
    // 주문번호별 주문내역 모음(Arraylist) > 주문번호가 같은 제품들 정보(Arraylist) > 제품 정보(Hasmap)
    public ArrayList<ArrayList<HashMap<String, String>>> order_history_dao(String email) {
        Connection conn = db_util.getConnection();
        int uid = loginDAO.getUidByEmail(email); // 고객의 uid
        String SQL = "select h.oid, h.datetime, h.pname, h.cost, h.quantity, u.name, u.phone, h.pimage " +
                "from history h join user u on h.uid_seller = u.uid " +
                "where h.uid = ? order by h.oid Desc , h.pname ASC;";

        try {
            ArrayList<ArrayList<HashMap<String, String>>> oder_list_all = new ArrayList<>(); // 아래 주문정보 리스트를 저장(oid별로)
            ArrayList<HashMap<String, String>> order_list_dummy = null;
            HashMap<String, String> hashmap_dummy;
            ResultSet rs = null;
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement pstmt1 = conn.prepareStatement(SQL);

            //pstmt1.setString(1, c_list);
            pstmt1.setInt(1, uid);

            rs = pstmt1.executeQuery();

            String check_oid = "";
            while (rs.next()) {
                if (!check_oid.equals(rs.getString(1))) { // oid가 달라지면 Arraylist 새로 만들기(oid가 같은 해쉬만 담기위해
                    if (order_list_dummy != null) { // 처음에는 null이기 때문에 null이 아니면 담도록한다.
                        oder_list_all.add(order_list_dummy);
                    }
                    order_list_dummy = new ArrayList<>(); // 같은 oid끼리 제품별 주문정보 해쉬를 저장하기 위해 초기화
                    check_oid = rs.getString(1); // oid를 저장하여 다음 row의 oid랑 다른지 확인할 수 있도록 함
                }
                hashmap_dummy = new HashMap<>(); // 초기화
                hashmap_dummy.put("oid", rs.getString(1));
                hashmap_dummy.put("datetime", rs.getString(2));
                hashmap_dummy.put("pname", rs.getString(3)); // 제품명
                hashmap_dummy.put("cost", rs.getString(4));
                hashmap_dummy.put("quantity", rs.getString(5));
                hashmap_dummy.put("name", rs.getString(6)); // 판매자명
                hashmap_dummy.put("phone", rs.getString(7));
                hashmap_dummy.put("pimage", rs.getString(8));
                order_list_dummy.add(hashmap_dummy);
                //System.out.println("name " + rs.getString(7)); // 확인
            }
            if (order_list_dummy != null) { // 마지막 반복문에서는 rs.next로 그냥 끝나기 때문에 마지막 더미를 추가해주고 끝낸다.(결과가 비어있을 수 있으니 null 체크)
                oder_list_all.add(order_list_dummy);
            }
            return oder_list_all;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 제품으로부터 판매자 id를 get. (history table에 저장하기 위함)
    public int getUidByPid(int product_pid) {
        Connection conn = db_util.getConnection();
        String sql =  "SELECT uid FROM product WHERE pid=?";
        try {
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement ptsmt = conn.prepareStatement(sql);
            ptsmt.setInt(1, product_pid);
            ResultSet rs = ptsmt.executeQuery();
            rs.next();
            int uid_seller = rs.getInt(1);
            rs.close();

            return uid_seller;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null && !conn.isClosed())
                    conn.close();
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return -1;
    }
}
