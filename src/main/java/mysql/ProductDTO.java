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

    // 판매자 총매출 출력을 위한 (제품명, 가격, 수량)을 담은 생성자 - 약간 꼼수
    public ProductDTO(String product_name, int stock, int cost) {
        this.product_name = product_name;
        this.stock = stock;
        this.cost = cost;
    }

    // 카테고리 별 상품 목록 출력을 위한 (이미지, 제품명, 제품 가격)을 담은 생성자

    public ProductDTO(int pid, String product_name, int cost, String pimage) {
        this.pid = pid;
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
    //판매자의 등록된 상품 수정 시 기존에 등록된 제품의 정보를 조회하기 위한(제품코드, 상품이름, 상품가격, 상품수량, 상품설명, 상품이미지)을 담은 생성자
    public ProductDTO(int pid, String product_name, int cost, int stock, String desc, String pimage) {
        this.pid = pid;
        this.product_name = product_name;
        this.cost = cost;
        this.stock = stock;
        this.desc = desc;
        this.pimage = pimage;
    }

    // 제품 디테일 출력하는 생성자(제품 코드, 제품명, 가격, 재고, 설명, 이미지, 사이즈)
    public ProductDTO(int pid, String product_name, int cost, int stock, String desc, String pimage, String size) {
        this.pid = pid;
        this.product_name = product_name;
        this.cost = cost;
        this.stock = stock;
        this.desc = desc;
        this.pimage = pimage;
        this.size = size;
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
