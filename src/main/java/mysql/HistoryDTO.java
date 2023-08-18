package mysql;

// 결제 정보 테이블 속성
public class HistoryDTO {
    /*변수---------------------------------------------------*/
    private int hid; // 결제 정보 코드 (PK)
    private int uid; // 주문한 고객 코드 (FK)
    private int pid; // 제품 코드 (FK)
    private int orderNumber; // 주문 번호
    private int quantity; // 장바구니에 담은 수량
    private String pname; // 제품 이름
    private int cost; // 제품 1개 가격
    private String datetime; // 결제 날짜
    /*생성자---------------------------------------------------*/

    // 기본 생성자
    public HistoryDTO() {
    }

    /*getter---------------------------------------------------*/

    public int getHid() {
        return hid;
    }

    public int getUid() {
        return uid;
    }

    public int getPid() {
        return pid;
    }

    public int getOrderNumber() {
        return orderNumber;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getPname() {
        return pname;
    }

    public int getCost() {
        return cost;
    }

    public String getDatetime() {
        return datetime;
    }
}
