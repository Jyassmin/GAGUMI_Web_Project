package mysql;

import java.sql.*;

public class jdbc_connect {
    public static void main(String[] args) throws SQLException {
        String url = "jdbc:mysql://localhost:3306/gagumi_db"; // db선택
        String userName = "root"; // user
        String password = "12341234"; // pw

        Connection connection = DriverManager.getConnection(url, userName, password); // db 연결 매니저
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery("select * from customer"); // sql문 실행하여 결과 저장

        resultSet.next();
        String name = resultSet.getString("name"); // name 컬럼 가져오기
        System.out.println(name);

        resultSet.close();
        statement.close();
        connection.close();
    }
}
