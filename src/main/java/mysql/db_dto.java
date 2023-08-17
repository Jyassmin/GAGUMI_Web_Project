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

    //판매자가 등록한 상품의 전체 조회 변수 , 함수
    //상품pid
    private int productNumber;
    //이미지
    private String image;
    //상품명
    private String productName;
    //상품카테고리
    private int productCategory;
    //상품가격
    private int productPrice;
    //상품
    private int productQuantity;

    public db_dto() {
    }
    public db_dto(int productNumber, String image, String productName, int productCategory,
                  int productPrice, int productQuantity) {
        this.productNumber = productNumber;
        this.image = image;
        this.productName = productName;
        this.productCategory = productCategory;
        this.productPrice = productPrice;
        this.productQuantity = productQuantity;
    }
    public int getProductNumber() {
        return productNumber;
    }
    public String getImage() {
        return image;
    }
    public String getProductName() {
        return productName;
    }
    public int getProductCategory() {
        return productCategory;
    }
    public int getProductPrice() {
        return productPrice;
    }
    public int getProductQuantity() {
        return productQuantity;
    }



    //고객이 주문한 상품의 전체 조회 변수 , 함수
    //주문코드
    private int orderCode;
    //주문한 고객 이름
    private String orderName;
    //주문한수량
    private int orderQuantity;
    //주문총액
    private int totalPrice;
    //결제날짜
    private String dateTime;
    //주문한 고객전화번호
    private String orderPhone;

    public int getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(int orderCode) {
        this.orderCode = orderCode;
    }

    public String getOrderName() {
        return orderName;
    }

    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    public int getOrderQuantity() {
        return orderQuantity;
    }

    public void setOrderQuantity(int orderQuantity) {
        this.orderQuantity = orderQuantity;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getDateTime() {
        return dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    public String getOrderPhone() {
        return orderPhone;
    }

    public void setOrderPhone(String orderPhone) {
        this.orderPhone = orderPhone;
    }

    public String getOrderAdress() {
        return orderAdress;
    }

    public void setOrderAdress(String orderAdress) {
        this.orderAdress = orderAdress;
    }

    //주문한 고객주소
    private String orderAdress;


}


