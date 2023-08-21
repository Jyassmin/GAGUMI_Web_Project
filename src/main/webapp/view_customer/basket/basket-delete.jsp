<%@ page import="mysql.db_dao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String[] selectedItems = request.getParameterValues("selectedItems");
    System.out.println(selectedItems[0]);
    db_dao userDao = new db_dao();
    int successfulDeletions = 0;

    if (selectedItems != null) {
        for (String sidParam : selectedItems) {
            int sid = 0;

            try {
                System.out.println("123"); // 디버깅 출력
                sid = Integer.parseInt(sidParam);
                System.out.println("Deleted item with siddddddddddd " + sid); // 디버깅 출력
                int result = userDao.deleteShoppingCart(sid);
                System.out.println("Deleted item with sid: " + sid); // 디버깅 출력

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
