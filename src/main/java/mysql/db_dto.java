package mysql;

// DTO(Data Transfer Object): JSP와 MYSQL이 서로 데이터 전달하기 위한 단위
// 멤버변수는 private
// getter(), setter() 메소드 생성

public class db_dto {

    private String userID;
    private String userPassword;

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }
}