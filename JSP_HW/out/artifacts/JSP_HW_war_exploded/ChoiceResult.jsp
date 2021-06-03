<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>1711428이지수</title>
    <header>
        <center>
            <h1>선택 결과</h1>
            <hr/>
        </center>
    </header>
</head>
<body>
<center>
        <%
    Connection conn = null;
    Statement str = null;

    String onum = request.getParameter("onum");
    String dnum = request.getParameter("dnum");

    //1단계 JDBC Driver 로딩하기
    try {
        Class.forName("com.mysql.jdbc.Driver");
        System.out.println("");
        System.out.println("MySQL JDBC Driver 로딩을 성공하였습니다.");
    } catch (ClassNotFoundException e) {
        System.out.println("");
        System.out.println("MySQL JDBC Driver 로딩을 실패하였습니다.");
        System.out.println(e);
    }


    //2단계 DB 서버 접속하기
    try {
        String URL = "jdbc:mysql://localhost:3305/homework?serverTimezone=UTC";
        conn = DriverManager.getConnection(URL, "root", "123456");
        System.out.println("DB 서버 접속을 성공하였습니다.");
    } catch (Exception e) {
        System.out.println("DB  서버 접속을 실패하였습니다.");
    }

    //3단계 : 배달원 지정하기
    try {
        str = conn.createStatement();

        String query = "update orders set dnum = " + dnum + " where onum = " + onum;

        int rs = str.executeUpdate(query);

        if (rs > 0) {
            out.println("<h2>주문 선택이 완료되었습니다.</h2>");
        } else {
            System.out.println("주문 선택에 실패했습니다.");
            return;
        }

        str.close();
        conn.close();
    } catch (Exception e) {
        System.out.println("업데이트에 실패했습니다.");
        System.out.println(e);
    }
    %>
    <br/>
    <a href="DeliveryMenu.jsp">
        <button>뒤로가기</button>
    </a>
    <center>

</body>
</html>
