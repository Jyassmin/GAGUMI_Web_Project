<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="mysql.db_DAO.*" %>
<%
    LoginDAO loginDAO = new LoginDAO();
    HistoryDAO historyDAO = new HistoryDAO();
    PayDAO payDAO = new PayDAO();
    BasketDAO basketDAO = new BasketDAO();

    String user_email = (String) session.getAttribute("memberEmail"); // 로그인 되어 있으면 email 가져옴
    int user_uid = loginDAO.getUidByEmail(user_email);

    String[] selectedItems = request.getParameterValues("orderItems");
    //if (selectedItems != null) {
    //    for (String item : selectedItems) {
    //        System.out.println("Selected Item: " + item);
    //    }
    //} else {
    //    System.out.println("No items selected.");
    //}

    String strdate = request.getParameter("strdate");
    System.out.println("날짜 출력 : " + strdate);



    //1. 결제한 수량만큼 물품 재고 감소
    int modifyQuantitiy = payDAO.modifyQuantity(selectedItems); // 0이면 실패 0 이상이면 성공
    System.out.println("수량 : " + modifyQuantitiy); // 0임.
    //2. history 테이블에 결제 물건 삽입
    int insertHistory = historyDAO.insertHistory(user_uid, selectedItems, strdate);

    //3. 장바구니에서 결제한 제품 삭제
    int deleteBasket = basketDAO.deleteByBuy(selectedItems);


    PrintWriter script = response.getWriter();
    if(modifyQuantitiy > 0 && insertHistory > 0 && deleteBasket >0){
        script.println("<script>");
        script.println("alert('결제를 완료하였습니다.')");
        script.println("location.href='../order-history/order-history.jsp';");
        script.println("</script>");

    }else {
        script.println("<script>");
        script.println("alert('결제에 실패하였습니다.')");
        script.println("window.history.back();");
        script.println("</script>");
    }
    script.close();



%>