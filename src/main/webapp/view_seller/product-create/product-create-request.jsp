<%@ page import="java.sql.*" %>
<%@ page import="mysql.db_dao" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%--
  Created by IntelliJ IDEA.
  User: elane
  Date: 2023-08-14
  Time: AM 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    String location = "C:\\Users\\elane\\IdeaProjects\\GAGUMI_Web_Project\\src\\main\\webapp\\images\\productImage\\";
    int maxSize = 1024 * 1024 * 5;
    String file = "";
    String oriFile = "";
    MultipartRequest multi = new MultipartRequest(request, location, maxSize, "UTF-8", new DefaultFileRenamePolicy());
    Enumeration files = multi.getFileNames();
    String name = (String) files.nextElement();
    file = multi.getFilesystemName(name);
    oriFile = multi.getOriginalFileName(name);

    //System.out.println("파일 저장 이름 " + file);
    //System.out.println("파일 원본 이름 " + oriFile);
    // POST 방식의 한글처리
    request.setCharacterEncoding("UTF-8");

    String p_name = request.getParameter("product-name");
    String _item = request.getParameter("item");
    String _p_price = request.getParameter("product-price");
    String _p_quan = request.getParameter("product-quan");
    String p_desc = request.getParameter("product-desc");
    String p_size = request.getParameter("product-size");
    String p_img = request.getParameter("product-img");

    int item = Integer.parseInt(_item);
    int p_price = Integer.parseInt(_p_price);
    int p_quan = Integer.parseInt(_p_quan);

    System.out.println("카테고리 선택한 값 int" + item);
    System.out.println("카테고리 선택한 값 String" + _item);
    db_dao userDao = new db_dao();
    String currentUser = (String) session.getAttribute("memberEmail");
    // 1에 현재 로그인한 사용자 id가 들어가야함
    // 이미지 넣고 가져오는 법도 생각해야됨
    int insert_data = userDao.product_add(currentUser, item, p_name, p_quan, p_price, p_desc, p_img, p_size);
    PrintWriter script = response.getWriter();
    if(insert_data > 0){
        // 데이터 삽입 성공
        script.println("<script>");
        script.println("alert('제품 등록 성공')");
        script.println("location.href='../seller-home/seller-index.jsp';");
        script.println("</script>");
    }else {
        // 데이터 삽입 실패
        script.println("<script>");
        script.println("alert('제품 등록 실패')");
        script.println("window.history.back();");
        script.println("</script>");
    }
    script.close();
%>
</body>
</html>
