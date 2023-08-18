package mysql;

// 장바구니 테이블 속성
public class ShoppingCartDTO {
    /*변수---------------------------------------------------*/
    private int sid; // 장바구니 코드 (PK)
    private int uid; // 고객 코드 (FK)
    private int pid; // 제품 코드 (FK)
    private int quantitiy; // 고객이 담은 제품 수량

    /*생성자---------------------------------------------------*/

    // 기본 생성자
    public ShoppingCartDTO() {
    }


    /*getter---------------------------------------------------*/
    public int getSid() {
        return sid;
    }

    public int getUid() {
        return uid;
    }

    public int getPid() {
        return pid;
    }

    public int getQuantitiy() {
        return quantitiy;
    }
}
