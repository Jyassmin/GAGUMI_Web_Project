package mysql;

// 고객, 판매자 정보를 가지고 있는 테이블 속성
public class UserDTO {
    /*변수---------------------------------------------------*/
    private int uid; // 고객, 판매자 코드 (PK)
    private int role; // 고객 / 판매자 권한 구분 코드
    private String name; // 고객 이름 / 판매자 이름
    private String email; // 로그인 아이디로 사용되는 이메일
    private String pw; // 비밀번호
    private String phone; // 전화번호
    private int gender; // 고객 성별
    private String birthday; // 고객 생년원일
    private String company; // 판매자 회사이름
    private String address; // 주소
    private String zipcode; // 우편번호

    /*생성자---------------------------------------------------*/

    // 기본 생성자
    public UserDTO() {
    }

    /*getter---------------------------------------------------*/

    public int getUid() {
        return uid;
    }

    public int getRole() {
        return role;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPw() {
        return pw;
    }

    public String getPhone() {
        return phone;
    }

    public int getGender() {
        return gender;
    }

    public String getBirthday() {
        return birthday;
    }

    public String getCompany() {
        return company;
    }

    public String getAddress() {
        return address;
    }

    public String getZipcode() {
        return zipcode;
    }
}
