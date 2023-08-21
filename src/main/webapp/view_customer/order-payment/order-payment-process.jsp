<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mysql.db_dao" %>
<%@ page import="java.util.ArrayList" %>
<%
    db_dao order_dao = new db_dao();
    String user_email = (String) session.getAttribute("memberEmail"); // 로그인 되어 있으면 email 가져옴
    int user_uid = order_dao.getUidByEmail(user_email);

    String[] selectedItems = request.getParameterValues("selectedItems");
    String[] quan_list = request.getParameterValues("quan_list");
    String strdate = request.getParameter("strdate");

    //1. 결제한 수량만큼 물품 재고 감소



    //2. history 테이블에 결제 물건 삽입
    order_dao.insertHistory(user_uid, selectedItems, strdate);



    //3. 장바구니에서 결제한 제품 삭제







%>