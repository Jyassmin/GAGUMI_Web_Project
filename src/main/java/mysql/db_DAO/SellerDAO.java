package mysql.db_DAO;

import mysql.db_DTO.ProductDTO;
import mysql.db_util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class SellerDAO {
    LoginDAO loginDAO = new LoginDAO();
    //판매자 기준으로 로그인 후 고객주문목록 조회하는 함수
    public ArrayList<HashMap<String, String>> print_orderList(String email) {
        Connection conn = db_util.getConnection();
        int uid = loginDAO.getUidByEmail(email);
        String c_list = getHistoryUid(uid); // 해당 판매자의 물품을 구매한 고객의 리스트
        String SQL = "select h.oid, u.email, h.pname, h.cost, h.quantity, h.cost*h.quantity, u.name, u.phone, u.address, h.datetime " +
                "from history h join user u on h.uid = u.uid" +
                "    join product p on h.pid = p.pid " +
                "where h.uid in (" + c_list + ") and p.uid = ? ORDER BY h.datetime DESC;";
        try {
            ArrayList<HashMap<String, String>> history_list = new ArrayList<>();

            ResultSet rs = null;
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement ptsmt = conn.prepareStatement(SQL);

            //System.out.println(c_list);
            ptsmt.setInt(1, uid);

            rs = ptsmt.executeQuery();

            while (rs.next()) {
                HashMap<String, String> hashmap_dummy = new HashMap<>();
                hashmap_dummy.put("hid", rs.getString(1));
                hashmap_dummy.put("email", rs.getString(2));
                hashmap_dummy.put("pname", rs.getString(3));
                hashmap_dummy.put("cost", rs.getString(4));
                hashmap_dummy.put("quantity", rs.getString(5));
                hashmap_dummy.put("total_cost", rs.getString(6));
                hashmap_dummy.put("name", rs.getString(7));
                hashmap_dummy.put("phone", rs.getString(8));
                hashmap_dummy.put("address", rs.getString(9));
                hashmap_dummy.put("datetime", rs.getString(10));
                history_list.add(hashmap_dummy);
            }

            return history_list;

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


    // 총매출 출력 함수
    public int[] printTotalCost(String currentEmail){
        Connection conn = db_util.getConnection();
        int uid = loginDAO.getUidByEmail(currentEmail); // 현재 로그인한 판매자 email -> uid로 변경
        String pidList = getProductPid(uid); // 현재 판매자가 등록한 상품 구매한 고객 uid 가져오기

        String sql = "SELECT SUM(h.quantity*h.cost), SUM(h.quantity) FROM history h WHERE h.pid IN (" + pidList +");";
        try {
            int[] total_list = new int[2];
            ResultSet rs = null;
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement ptsmt = conn.prepareStatement(sql);
            rs = ptsmt.executeQuery();

            rs.next();
            total_list[0] = rs.getInt(1);
            total_list[1] = rs.getInt(2);
            rs.close();

            return total_list;

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
    // 판매자가 등록한 제품 pid 가져오는 함수
    public String getProductPid(int uid){
        Connection conn = db_util.getConnection();
        String sql = "select pid from product where uid = ?;";
        try {
            StringBuffer sb = new StringBuffer();
            ResultSet rs = null;
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement ptsmt = conn.prepareStatement(sql);
            ptsmt.setInt(1, uid);
            rs = ptsmt.executeQuery();

            while(rs.next()){
                sb.append(rs.getString(1));
                sb.append(", ");
            }
            sb.append("null");
            rs.close();
            String pidList = sb.toString();
            return pidList;

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

    // 제품 하나 당 총 매출 계산하는 함수
    public List<ProductDTO> printOneProductTotalCost(String currentEmail){
        Connection conn = db_util.getConnection();
        int uid = loginDAO.getUidByEmail(currentEmail); // 현재 로그인한 판매자 email -> uid로 변경

        String sql = "SELECT p.name, SUM(h.quantity*h.cost) AS 'TOTAL', SUM(h.quantity) " +
                "FROM product p LEFT JOIN history h ON p.pid = h.pid " +
                "WHERE p.uid = ? GROUP BY p.name ORDER BY TOTAL DESC;";
        try {
            // 데이터베이스 연결 및 쿼리 실행
            ResultSet rs = null;
            PreparedStatement ptsmt = conn.prepareStatement(sql);
            ptsmt.setInt(1, uid);
            rs = ptsmt.executeQuery();
            List<ProductDTO> detail = new ArrayList<>(); //각 제품의 총 매출 정보를 담을 리스트
            String product_name = ""; // 제품 명
            int quan = 0, cost = 0; // 주문 수량, 제품 금액

            while(rs.next()){
                product_name = rs.getString(1);
                cost = rs.getInt(2);
                quan = rs.getInt(3);
                ProductDTO pdto = new ProductDTO(product_name, quan, cost);
                detail.add(pdto);
            }

            rs.close();

            return detail;

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

    // 판매자가 등록한 상품 중에서 상품코드(pid)를 기준으로 상품 정보를 조회하는 함수
    public List<ProductDTO> ProductByPid(String email, int targetPid) {
        Connection conn = db_util.getConnection();
        int uid = loginDAO.getUidByEmail(email);
        String SQL = "SELECT * FROM product WHERE uid = ? AND pid = ?;";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, uid);
            pstmt.setInt(2, targetPid); // targetPid로 받은 상품코드(pid)를 사용

            ResultSet rs = pstmt.executeQuery();
            List<ProductDTO> productList = new ArrayList<>(); // 여러 상품 정보를 담을 리스트 생성

            while (rs.next()) {
                int pid = rs.getInt("pid");
                String name = rs.getString("name");
                int cost = rs.getInt("cost");
                int stock = rs.getInt("stock");
                String desc = rs.getString("desc");
                String pimage = rs.getString("pimage");

                ProductDTO product = new ProductDTO(pid, name, cost, stock, desc, pimage);
                productList.add(product); // 리스트에 상품 정보 추가
            }

            return productList;

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
        return null;
    }

    //고객 주문 목록 출력 해주는 함수, 판매자 기준 조회
    public String getHistoryUid(int current_uid) {
        Connection conn = db_util.getConnection();

        String SQL = "select h.uid from history h join product p on h.pid = p.pid where p.uid = ?";
        try {
            StringBuffer sb = new StringBuffer();
            ResultSet rs = null;
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement ptsmt = conn.prepareStatement(SQL);

            ptsmt.setInt(1, current_uid); // 판매자 ID를 설정하세요
            rs = ptsmt.executeQuery();

            while (rs.next()) {
                sb.append( rs.getString(1));
                sb.append(", ");
            }
            sb.append("null");
            String c_list = sb.toString();
            return c_list;

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

    // 정보 수정 시 판매자의 개인정보 가져오는 함수
    public HashMap<String, String> getSellerInfo(String currentUser) {
        Connection conn = db_util.getConnection();
        int sellerUID = Integer.parseInt(currentUser);
        //System.out.println("currentUId = " + sellerUID);
        String SQL = "select email, name, pw, phone, company, address, zipcode from user where role = 1 AND uid = ?;";

        try {

            HashMap<String, String> sellerInfo = new HashMap<>();
            ResultSet rs = null;
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement ptsmt = conn.prepareStatement(SQL);

            ptsmt.setInt(1, sellerUID); // 판매자 ID를 설정하세요
            rs = ptsmt.executeQuery();

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
            return sellerInfo;

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

    // 판매자 정보 수정 시 업데이트 하는 함수
    public int sellerUpdateInfo(String currentUser, String name, String pw, String phone, String company, String post_code, String full_address){
        Connection conn = db_util.getConnection();
        int currentUID = loginDAO.getUidByEmail(currentUser);
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
}
