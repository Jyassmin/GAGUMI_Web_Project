package mysql;

// 장바구니 테이블 속성
public class ShoppingCartDTO {
    /*변수---------------------------------------------------*/
    private int sid; // 장바구니 코드 (PK)
    private int uid; // 고객 코드 (FK)
    private int pid; // 제품 코드 (FK)
    private int quantitiy; // 고객이 담은 제품 수량
    private String product_name; // 제품이름
    private int cost; // 가격
    private String pimage; // 제품 이미지

    /*생성자---------------------------------------------------*/

    // 기본 생성자
    public ShoppingCartDTO() {
    }
    //고객 장바구니 출력을 위한 (이미지 / 제품명 / 주문 수량 / 금액)을 담은 생성자
    public ShoppingCartDTO(String pimage, String product_name, int quantitiy, int cost) {
        this.pimage = pimage;
        this.product_name = product_name;
        this.quantitiy = quantitiy;
        this.cost = cost;
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

    public String getProduct_name() {return product_name;}

    public int getCost() {return cost;}

    public String getPimage() {return pimage;}

    public int getTotalCost() {return quantitiy * cost;}
}
