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
    //상품수량
    private int stock;
    public db_dto(int productNumber, String image, String productName, int productCategory,
                  int productPrice, int stock) {
        this.productNumber = productNumber;
        this.image = image;
        this.productName = productName;
        this.productCategory = productCategory;
        this.productPrice = productPrice;
        this.stock = stock;
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
    public int getStock(){return stock;}


    //고객이 주문한 상품의 전체 조회 변수 , 생성자
    //주문코드
    private int orderCode;
    //주문한수량
    private int orderQuantity;
    //주문총액
    private int totalPrice;
    //주문한 고객 이름
    private String orderName;
    //주문한 고객 전화번호
    private String orderPhone;
    //결제날짜
    private String dateTime;
    //주문한 고객주소
    private String orderAddress;

    public db_dto(int orderCode, String userID, String productName, int productPrice, int orderQuantity, int totalPrice,
                  String orderName, String orderPhone,  String orderAddress,
                   String dateTime ) {
        this.orderCode = orderCode;
        this.userID = userID;
        this.productName = productName;
        this.productPrice = productPrice;
        this.orderQuantity = orderQuantity;
        this.totalPrice = totalPrice;
        this.orderName = orderName;
        this.orderPhone = orderPhone;
        this.orderAddress = orderAddress;
        this.dateTime = dateTime;

    }

    public int getOrderCode() {
        return orderCode;
    }
    public int getOrderQuantity() {
        return orderQuantity;
    }
    public int getTotalPrice() {
        return totalPrice;
    }
    public String getOrderName() {
        return orderName;
    }
    public String getOrderPhone() {
        return orderPhone;
    }
    public String getOrderAddress() {
        return orderAddress;
    }
    public String getDateTime() {
        return dateTime;
    }

}


