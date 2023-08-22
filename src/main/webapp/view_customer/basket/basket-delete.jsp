<%@ page import="mysql.db_dao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String[] selectedItems = request.getParameterValues("selectedItems");
    db_dao userDao = new db_dao();
    int successfulDeletions = 0;

    if (selectedItems != null) {
        for (String sidParam : selectedItems) {
            int sid = 0;

            try {
                sid = Integer.parseInt(sidParam);
                int result = userDao.deleteShoppingCart(sid);

                if (result > 0) {
                    successfulDeletions++;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
    }

    if (successfulDeletions > 0) {
%>
<script>
    alert("선택한 상품이 삭제되었습니다.");
    location.href = "basket.jsp"; // 삭제 후 장바구니 페이지로 이동
</script>
<%
} else {
%>
<script>
    alert("상품 삭제에 실패하였습니다.");
    history.back(); // 이전 페이지로 돌아가기
</script>
<%
    }
%>
