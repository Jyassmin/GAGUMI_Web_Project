package mysql.db_DAO;

import mysql.db_DTO.ProductDTO;
import mysql.db_util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// DAO(Data Access Object): 데이터베이스에 직접 접근하여 데이터 처리를 하는 클래스
// form에서 입력받은 데이터를 받아, sql문을 만들어 실행하고, 결과를 반환
public class ProductDAO {
    LoginDAO loginDAO = new LoginDAO();
    /*제품 등록 함수*/
    public int product_add(String currentUser, int category2, String p_name, int stock, int cost, String desc, String p_iamge, String size) {
        Connection conn = db_util.getConnection();
        int uid = loginDAO.getUidByEmail(currentUser);
        String SQL = "INSERT INTO product (uid, ca2id, name, stock, cost, `desc`, pimage, size) values (?,?,?,?,?,?,?,?);";

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

    // 판매자가 등록한 상품내역을 가져오는 함수
    public List<ProductDTO> print_product(String email) {
        Connection conn = db_util.getConnection();
        int uid = loginDAO.getUidByEmail(email);
        String SQL = "SELECT * FROM product WHERE uid = ?";

        try {
            List<ProductDTO> productList = new ArrayList<>();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, uid);
            ResultSet rs = pstmt.executeQuery();
            System.out.println(pstmt);
            while (rs.next()) {
                int pid = rs.getInt("pid");
                int ca2id = rs.getInt("ca2id");
                String product_name = rs.getString("name");
                int stock = rs.getInt("stock");
                int cost = rs.getInt("cost");
                String image = rs.getString("pimage");
                ProductDTO product = new ProductDTO(pid, ca2id, product_name, stock, cost, image);
                productList.add(product);
            }
            rs.close();
            return productList;
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

    //pid기준으로 상품 삭제해주는 함수
    public int deleteProduct(int pid) {
        Connection conn = db_util.getConnection();
        //out.println("함수들어옴");
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
    }

    //등록상품수정 디비에 적용하는 함수
    public int productUpdateInfo(String currentUser, String modifyName, int modifyCost, int  modifyStock, String modifyDesc, String modifyPimage, int targetPid) {
        Connection conn = db_util.getConnection();
        int currentUID = loginDAO.getUidByEmail(currentUser);
        //product테이블 pid 기준으로 업데이트 될 값 세팅
        String SQL = "UPDATE product SET name = ?, cost = ?, stock = ?, `desc` = ?, pimage = ? WHERE uid = ? AND pid = ?;";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, modifyName);
            pstmt.setInt(2, modifyCost);
            pstmt.setInt(3, modifyStock);
            pstmt.setString(4, modifyDesc);
            pstmt.setString(5, modifyPimage);
            pstmt.setInt(6, currentUID);
            pstmt.setInt(7, targetPid);

            // 명령어를 수행한 결과
            // 1_execute -> 테이블 생성, 수정, 삭제 등 데이터베이스 관리 명령어 사용(table)
            // 2_executeUpdate -> 레코드 삽입, 수정, 삭제 등 데이터 조작 명령어 사용(CRUD)
            // 3_executeQuery -> 레코드 조회, 테이블 조회 등 조회 명령어 사용(Select)
            return pstmt.executeUpdate(); // 업데이트된 행 수 반환

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
        return -1; // 업데이트 실패 시 반환 값
    }

    // 카테고리별 제품 목록 가져오는 함수
    public List<ProductDTO> getProductList(int bigCategory){
        Connection conn = db_util.getConnection();
        String[] smallCategory = getSmallCategory(bigCategory); // 대분류로 소분류 가져오기
        for (String s : smallCategory){
            System.out.println("smallCategory : " + s);
        }
        List<ProductDTO> category = new ArrayList<>();
        String SQL = "SELECT pid, pimage, name, cost FROM product WHERE ca2id IN (?, ?, ?, ?, ?);";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // ca2id 배열 값들을 SQL 쿼리에 설정
            for (int i = 0; i < 5; i++) {
                pstmt.setString(i + 1, smallCategory[i]);
            }

            ResultSet rs = pstmt.executeQuery();
            // 결과 출력
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String image = rs.getString("pimage");
                String name = rs.getString("name");
                int cost = rs.getInt("cost");
                ProductDTO product = new ProductDTO(pid, name, cost, image);
                category.add(product);
            }
            return category;

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

    // 대분류를 통한 소분류 가져오기
    public String[] getSmallCategory(int bigCategory){
        Connection conn = db_util.getConnection();
        String[] category = new String[5];
        String SQL = "SELECT ca2id FROM category2 WHERE ca1id = ?";
        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setInt(1, bigCategory);

            ResultSet rs = pstmt.executeQuery();
            int cnt = 0;
            while (rs.next()){
                category[cnt++] = rs.getString(1);
            }
            return category;

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

    //카테고리 숫자를 문자로 바꾸어주는 함수
    public String getCategoryText(int category) {
        Connection conn = db_util.getConnection();
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

    // 제품 디테일 출력하는 함수
    public ProductDTO printProductDetail(int pid){
        Connection conn = db_util.getConnection();
        String sql = "SELECT name, stock, cost, `desc`, pimage, size  FROM product WHERE pid = ?;";
        try {
            // 데이터베이스 연결 및 쿼리 실행
            ResultSet rs = null;
            PreparedStatement ptsmt = conn.prepareStatement(sql);
            ptsmt.setInt(1, pid);
            rs = ptsmt.executeQuery();
            ProductDTO pdto = null;
            String product_name = ""; // 제품 명
            int stock = 0, cost = 0; // 재고, 제품 금액
            String desc = "", pimage="", size="" ; //제품 설명, 제품 이미지, 제품 사이즈

            while(rs.next()){
                product_name = rs.getString(1);
                stock = rs.getInt(2);
                cost = rs.getInt(3);
                desc = rs.getString(4);
                pimage = rs.getString(5);
                size = rs.getString(6);
                pdto = new ProductDTO(pid, product_name, cost, stock, desc, pimage, size);
            }

            rs.close();

            return pdto;

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
