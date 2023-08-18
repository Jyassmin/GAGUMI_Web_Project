package mysql;
import java.util.ArrayList;
import java.sql.*;
import java.util.HashMap;
import java.util.List;

import static java.lang.System.out;


// DAO(Data Access Object): 데이터베이스에 직접 접근하여 데이터 처리를 하는 클래스
// form에서 입력받은 데이터를 받아, sql문을 만들어 실행하고, 결과를 반환

public class db_dao {
    //Connection conn = db_util.getConnection();

    /*login : 입력받은 id, pw가 user테이블에 있는지 확인. 있다면 1. 없다면 0 반환*/
    public int login(String page_role, String userEmail, String userPassword) {
        Connection conn = db_util.getConnection();
        String SQL = "SELECT count(*) AS total FROM user where role=? AND email=? AND pw=?";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, page_role);
            pstmt.setString(2, userEmail);
            pstmt.setString(3, userPassword);

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

    /*제품 등록 함수*/
    public int product_add(String currentUser, int category2, String p_name, int stock, int cost, String desc, String p_iamge, String size) {
        Connection conn = db_util.getConnection();
        int uid = getUidByEmail(currentUser);
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
        int uid = getUidByEmail(email);
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

    // "000님 환영합니다"를 위해 세션(email)을 주면 name 반환해주는 함수.
    public String getNameByEmail(String userEmail) {
        Connection conn = db_util.getConnection();
        String SQL = "SELECT name from user where email=?";

        try {
            // 실행 가능 상태의 sql문으로 만듦.
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            // 쿼리문의 ?안에 각각의 데이터를 넣어준다.
            pstmt.setString(1, userEmail);
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

    // 현재 로그인한 유저의 session Email을 활용하여 UID 가져오는 함수
    public int getUidByEmail(String userEmail) {
        Connection conn = db_util.getConnection();
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
    public int sellerUpdateInfo(String currentUser, String name, String pw, String phone, String company, String post_code, String full_address){
        Connection conn = db_util.getConnection();
        int currentUID = getUidByEmail(currentUser);
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
    //pid기준으로 상품 삭제해주는 함수
    public int deleteProduct(int pid) {
        Connection conn = db_util.getConnection();
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
    }
    // 정보 수정 시 판매자의 개인정보 가져오는 함수
    public HashMap<String, String> getSellerInfo(String currentUser) {
        Connection conn = db_util.getConnection();
        int currentUID = getUidByEmail(currentUser);
        //System.out.println("currentUId = " + currentUID);
        String SQL = "select email, name, pw, phone, company, address, zipcode from user where role = 1 AND uid = ?;";

        try {

            HashMap<String, String> sellerInfo = new HashMap<>();
            ResultSet rs = null;
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement pstmt1 = conn.prepareStatement(SQL);

            pstmt1.setInt(1, currentUID); // 판매자 ID를 설정하세요
            rs = pstmt1.executeQuery();

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



    //고객 주문 목록 출력 해주는 함수 다만, 기준 일단 uid=1인 사람 기준으로 가져오기
    public String getHistoryUid(int current_uid) {
        Connection conn = db_util.getConnection();

        String SQL = "select h.uid from history h join product p on h.pid = p.pid where p.uid = ?";
        try {
            StringBuffer sb = new StringBuffer();
            ResultSet rs = null;
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement pstmt1 = conn.prepareStatement(SQL);

            //pstmt1.setInt(1, current_uid); // 판매자 ID를 설정하세요
            pstmt1.setInt(1, 10); // 판매자 ID를 설정하세요
            rs = pstmt1.executeQuery();

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



    //print_orderList
    }public ArrayList<HashMap<String, String>> print_orderList(String email) {
        Connection conn = db_util.getConnection();
        int uid = getUidByEmail(email);
        String c_list = getHistoryUid(uid); // 해당 판매자의 물품을 구매한 고객의 리스트
        String SQL = "select h.hid, u.email, h.pname, h.cost, h.quantity, h.cost*h.quantity, u.name, u.phone, u.address, h.datetime " +
                "from history h join user u on h.uid = u.uid" +
                "    join product p on h.pid = p.pid " +
                "where u.uid in (" + c_list + ") and p.uid = ?;";
        try {
            ArrayList<HashMap<String, String>> history_list = new ArrayList<>();

            ResultSet rs = null;
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement pstmt1 = conn.prepareStatement(SQL);

            //pstmt1.setString(1, c_list);
            System.out.println(c_list);
            pstmt1.setInt(1, uid);

            rs = pstmt1.executeQuery();

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
                System.out.println("name " + rs.getString(7));
            }
                System.out.println(history_list.get(0).get("hid"));
                System.out.println(history_list.get(1).get("hid"));
                System.out.println(history_list.get(2).get("hid"));
                System.out.println(history_list.get(3).get("hid"));
                System.out.println(history_list.get(4).get("hid"));
                System.out.println(history_list.get(5).get("hid"));


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


    // 현재 로그인한 고객 정보 가져오는 함수
    public HashMap<String, String> getCustomerInfo(String currentUser) {
        Connection conn = db_util.getConnection();
        int currentUID = getUidByEmail(currentUser);
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

    // 고객 정보 수정 디비에 적용하는 함수
    public int customerUpdateInfo(String currentUser, String modifyName, String modifyPw, String modifyPhone, String modifyBirthday, String modifySex, String postCode, String fullAddress) {
        Connection conn = db_util.getConnection();
        int currentUID = getUidByEmail(currentUser);
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

    // 카테고리별 제품 목록 가져오는 함수
    public List<ProductDTO> getProductList(int bigCategory){
        Connection conn = db_util.getConnection();
        String[] smallCategory = getSmallCategory(bigCategory); // 대분류로 소분류 가져오기
        for (String s : smallCategory){
            System.out.println("smallCategory : " + s);
        }
        List<ProductDTO> category = new ArrayList<>();
        String SQL = "SELECT pimage, name, cost FROM product WHERE ca2id IN (?, ?, ?, ?, ?);";
        //String SQL = "SELECT pimage, name, cost FROM product WHERE ca2id IN ('1', '2');";

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
                String image = rs.getString("pimage");
                String name = rs.getString("name");
                int cost = rs.getInt("cost");
                ProductDTO product = new ProductDTO(image, cost, name);
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

    // 소분
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
}
