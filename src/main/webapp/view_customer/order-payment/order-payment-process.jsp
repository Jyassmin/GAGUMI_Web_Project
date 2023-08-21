<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mysql.db_dao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%
    db_dao order_dao = new db_dao();
    String user_email = (String) session.getAttribute("memberEmail"); // 로그인 되어 있으면 email 가져옴
    int user_uid = order_dao.getUidByEmail(user_email);

    String[] selectedItems = request.getParameterValues("selectedItems");
    String[] quan_list = request.getParameterValues("quan_list");
    String strdate = request.getParameter("strdate");

    //1. 결제한 수량만큼 물품 재고 감소
    int modifyQuantitiy = order_dao.modifyQuantity(selectedItems); // 0이면 실패 0 이상이면 성공

    //2. history 테이블에 결제 물건 삽입
    int insertHistory = order_dao.insertHistory(user_uid, selectedItems, strdate);

    //3. 장바구니에서 결제한 제품 삭제
    int deleteBasket = order_dao.deleteByBuy(selectedItems);


    PrintWriter script = response.getWriter();
    if(modifyQuantitiy > 0 && insertHistory > 0 && deleteBasket >0){
        script.println("<script>");
        script.println("alert('장바구니 담기 성공')");
        script.println("location.href='../../index.jsp';");
        script.println("</script>");

    }else {
        script.println("<script>");
        script.println("alert('장바구니 담기 실패')");
        script.println("window.history.back();");
        script.println("</script>");
    }
    script.close();



%>