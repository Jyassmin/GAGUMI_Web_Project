<%@ page import="mysql.db_dao" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: elane
  Date: 2023-08-20
  Time: PM 3:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>장바구니 담기</title>
</head>
<body>
<%
    String currentUser = (String) session.getAttribute("memberEmail");
    int pid = Integer.parseInt(request.getParameter("pid"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    db_dao shop_dao = new db_dao();
    int success = shop_dao.insertShoppingCart(currentUser, pid, quantity);
    PrintWriter script = response.getWriter();
    if(success > 0){
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

</body>
</html>
