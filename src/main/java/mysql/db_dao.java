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
            PreparedStatement ptsmt = conn.prepareStatement(SQL);

            ptsmt.setInt(1, currentUID); // 판매자 ID를 설정하세요
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

    //판매자 기준으로 로그인 후 고객주문목록 조회하는 함수
    public ArrayList<HashMap<String, String>> print_orderList(String email) {
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


    // 고객의 email을 받아 주문 목록 출력
    // 주문번호별 주문내역 모음(Arraylist) > 주문번호가 같은 제품들 정보(Arraylist) > 제품 정보(Hasmap)
    public ArrayList<ArrayList<HashMap<String, String>>> order_history_dao(String email) {
        Connection conn = db_util.getConnection();
        int uid = getUidByEmail(email); // 고객의 uid
        String SQL = "select h.oid, h.datetime, h.pname, h.cost, h.quantity, u.name, u.phone, p.pimage " +
                    "from product p join history h on p.pid = h.pid " +
                    "join user u on p.uid = u.uid " +
                    "where h.uid = ? order by h.oid ASC, h.pname ASC;";

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
                hashmap_dummy.put("pname", rs.getString(3));
                hashmap_dummy.put("cost", rs.getString(4));
                hashmap_dummy.put("quantity", rs.getString(5));
                hashmap_dummy.put("name", rs.getString(6));
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

    // 판매자가 등록한 상품 중에서 상품코드(pid)를 기준으로 상품 정보를 조회하는 함수
    public List<ProductDTO> ProductByPid(String email, int targetPid) {
        Connection conn = db_util.getConnection();
        int uid = getUidByEmail(email);
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

    //등록상품수정 디비에 적용하는 함수
    public int productUpdateInfo(String currentUser, String modifyName, int modifyCost, int  modifyStock, String modifyDesc, String modifyPimage, int targetPid) {
        Connection conn = db_util.getConnection();
        int currentUID = getUidByEmail(currentUser);
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
    
    // 총매출 출력 함수
    public int[] printTotalCost(String currentEmail){
        Connection conn = db_util.getConnection();
        int uid = getUidByEmail(currentEmail); // 현재 로그인한 판매자 email -> uid로 변경
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

    // 제품 하나 당 총 매출 계산하는 함수
    public List<ProductDTO> printOneProductTotalCost(String currentEmail){
        Connection conn = db_util.getConnection();
        int uid = getUidByEmail(currentEmail); // 현재 로그인한 판매자 email -> uid로 변경

        String sql = "SELECT p.name, SUM(h.quantity*h.cost) AS 'TOTAL', SUM(h.quantity) " +
                    "FROM product p LEFT JOIN history h ON p.pid = h.hid " +
                    "WHERE p.uid = ? GROUP BY p.name ORDER BY TOTAL;";
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

    // 장바구니 담기 함수
    public int insertShoppingCart(String currentUser, int pid, int quantity) {
        Connection conn = db_util.getConnection();
        int uid = getUidByEmail(currentUser);
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
            int uid = getUidByEmail(currentUser);
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
    //sid기준으로 상품 삭제해주는 함수
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


    // sid 기준으로 상품 재고 감소 시키기 위한 정보 가져오기
    public List<String[]> getInfoBySid(String[] sid){
        Connection conn = db_util.getConnection();
        String sql = "SELECT pid, quantity FROM shoppingcart WHERE sid =?;";
        List<String[]> info = new ArrayList<>();
        try {
            // 데이터베이스 연결 및 쿼리 실행
            ResultSet rs = null;
            PreparedStatement ptsmt = conn.prepareStatement(sql);
            for(int i=0; i<sid.length; i++){
                String[] quanAndPid = new String[2];
                ptsmt.setString(1, sid[i]);
                rs = ptsmt.executeQuery();
                rs.next();
                quanAndPid[0] = rs.getString("pid");
                quanAndPid[1] = rs.getString("quantity");
                info.add(quanAndPid);
                rs.close();
            }

            return info;

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
    public int modifyQuantity(String[] sid){
        Connection conn = db_util.getConnection();
        List<String[]> info = new ArrayList<>();
        info = getInfoBySid(sid);
        int result = 0;
        String sql = "UPDATE product SET stock = (stock - ?) WHERE pid = ?;";
        try {
            // 데이터베이스 연결 및 쿼리 실행
            PreparedStatement ptsmt = conn.prepareStatement(sql);
            for(int i=0; i<info.size(); i++){
                ptsmt.setString(1, info.get(i)[1]);
                ptsmt.setString(2, info.get(i)[0]);

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

    public int deleteByBuy(String[] sid){
        int result = 0;
        for(int i=0; i<sid.length; i++){
            int oneSid = Integer.parseInt(sid[i]);
            result += deleteShoppingCart(oneSid);
        }
        return result;
    }
  
    // 장바구니 담기 함수
    public int insertHistory(int uid, String[] selectedItems, String strdate) {
    
       for (String item_sid : selectedItems) {
           int product_pid = getPidBySid(item_sid);
           int product_quan = getQuanBySid(item_sid);
           ProductDTO pdto = printProductDetail(product_pid); // 물품 정보 가져오기
    
    
           Connection conn = db_util.getConnection();
           String sql = "INSERT INTO history (uid, pid, oid, quantity, pname, cost, datetime) VALUES (?, 1, 1, 2, '우아한 식탁의자', 200000, '2023-08-01 10:15:00')";
           try {
               // 데이터베이스 연결 및 쿼리 실행
               PreparedStatement ptsmt = conn.prepareStatement(sql);
               ptsmt.setInt(1, uid);
               ptsmt.setInt(2, product_pid);
               ptsmt.setInt(3, 1);
               ptsmt.setInt(4, product_quan);
               ptsmt.setString(5, pdto.getProduct_name());
               ptsmt.setInt(6, pdto.getCost());
               ptsmt.setString(7, strdate);
    
               return ptsmt.executeUpdate();
    
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
    public int insertHistory(int uid, String[] selectedItems, String strdate) {
        Connection conn = db_util.getConnection();
        int cnt = 0;
        String sql = "INSERT INTO history (uid, pid, oid, quantity, pname, cost, datetime) VALUES (?,?,?,?,?,?,?)";
        try {
            for (String item_sid : selectedItems) {
                int product_pid = getPidBySid(item_sid);
                int product_quan = getQuanBySid(item_sid);
                ProductDTO pdto = printProductDetail(product_pid); // 물품 정보 가져오기

                // 데이터베이스 연결 및 쿼리 실행
                PreparedStatement ptsmt = conn.prepareStatement(sql);
                ptsmt.setInt(1, uid);
                ptsmt.setInt(2, product_pid);
                ptsmt.setInt(3, 1);
                ptsmt.setInt(4, getLastOid() + 1);
                ptsmt.setString(5, pdto.getProduct_name());
                ptsmt.setInt(6, pdto.getCost());
                ptsmt.setString(7, strdate);
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
        String sql =  "SELECT oid FROM history ORDER BY datetime DESC LIMIT 1";
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
}
