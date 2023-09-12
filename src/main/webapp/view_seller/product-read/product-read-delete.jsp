<%@ page import="mysql.db_DAO.ProductDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 삭제할 상품의 pid를 파라미터에서 가져옴
    String pidParam = request.getParameter("pid");
    int pid = Integer.parseInt(pidParam);

    // DAO 인스턴스 생성
    ProductDAO productDAO = new ProductDAO();

    // 상품 삭제 처리
    int result = productDAO.deleteProduct(pid);

    if (result > 0) {
        // 삭제 성공 시 메시지 출력
%>
<script>
    alert("상품이 삭제되었습니다.");
    location.href = "product-read.jsp"; // 삭제 후 제품 목록 페이지로 이동
</script>
<%
} else {
    // 삭제 실패 시 메시지 출력
%>
<script>
    alert("상품 삭제에 실패하였습니다.");
    history.back(); // 이전 페이지로 돌아가기
</script>
<%
    }
%>
