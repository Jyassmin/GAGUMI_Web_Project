package mysql;

import java.sql.Connection;
import java.sql.DriverManager;

// db_util : driver로 intellij와 mysql 연결. Connction 반환행
// user_dao와 같이 sql실행하는 모든 파일에서 사용

public class db_util {
    public static Connection getConnection() { //데이터베이스와 연결상태 관리
        try {
            String url = "jdbc:mysql://localhost:3306/gagumi_db"; // db선택
            String userName = "root"; // email
            String password = "12341234"; // pw

            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, userName, password);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

