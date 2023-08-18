package mysql;

// 제품 정보 테이블 columns
public class ProductDTO {
    /*변수---------------------------------------------------*/
    private int pid; // 제품 코드 (PK)
    private int ca2id; // 카테고리 (소분류)
    private int seller_uid; // 판매자 uid
    private String product_name; // 제품이름
    private int stock; // 재고
    private int cost; // 가격
    private String desc; // 제품 설명
    private String pimage; // 제품 이미지
    private String size; // 제품 사이즈

    /*생성자---------------------------------------------------*/

    // 기본 생성자
    public ProductDTO() {
    }

    // 판매자 조회시 고객이 주문한 주문목록 출력을 위한 (제품명, 제품가격)을 담은 생성자
    public ProductDTO(String product_name, int cost) {
        this.product_name = product_name;
        this.cost = cost;
    }

    // 카테고리 별 상품 목록 출력을 위한 (이미지, 제품명, 제품 가격)을 담은 생성자
    public ProductDTO(String product_name, int cost, String pimage) {
        this.product_name = product_name;
        this.cost = cost;
        this.pimage = pimage;
    }
    //판매자의 등록 상품 조회를 위한 (제품 코드, 이미지, 제품명, 카테고리, 가격, 재고)을 담은 생성자
    public ProductDTO(int pid, int ca2id, String product_name, int stock, int cost, String pimage) {
        this.pid = pid;
        this.ca2id = ca2id;
        this.product_name = product_name;
        this.stock = stock;
        this.cost = cost;
        this.pimage = pimage;
    }

    /*getter---------------------------------------------------*/

    public int getPid() {
        return pid;
    }

    public int getCa2id() {
        return ca2id;
    }

    public int getSeller_uid() {
        return seller_uid;
    }

    public String getProduct_name() {
        return product_name;
    }

    public int getStock() {
        return stock;
    }

    public int getCost() {
        return cost;
    }

    public String getDesc() {
        return desc;
    }

    public String getPimage() {
        return pimage;
    }

    public String getSize() {
        return size;
    }
}
