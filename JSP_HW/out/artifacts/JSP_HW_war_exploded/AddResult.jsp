<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>1711428 이지수</title>
    <header>
        <center>
            <h1>삽입 결과</h1>
            <hr/>
        </center>
    </header>
</head>
<body>
<%
    Connection conn = null;
    Statement str = null;
    ResultSet info = null;
    int rs = 0;

    String name = request.getParameter("fname");
    String price = request.getParameter("price");
    String rname = request.getParameter("rname");

    int rnum = 0;

    //1단계
    try {
        Class.forName("com.mysql.jdbc.Driver");
        System.out.println("");
    } catch (Exception e) {
        System.out.println("MySQL JDBC Driver 로딩을 실패하였습니다.");
        System.out.println("");
        System.out.println(e);
    }

    //2단계
    try{
        String URL = "jdbc:mysql://localhost:3305/homework?serverTimezone=UTC";
        conn = DriverManager.getConnection(URL, "root", "123456");
    } catch(Exception e) {
        System.out.println("DB 서버 접속을 실패하였습니다.");
        System.out.println("");
        System.out.println(e);
    }

    //3단계 : 식당 정보 가져오기
    try{
        str = conn.createStatement();
        info = str.executeQuery("select rnum from restaurant where name = \""+ rname +"\"");

        while(info.next()) {
            rnum = Integer.parseInt(info.getString("rnum"));
        }

        if(rnum == 0) {
            out.println("rnum을 가져오지 못했습니다.");
        }
    } catch(Exception e){
        System.out.println("식당 정보를 검색할 수 없습니다.");
        System.out.println(e);
    }


    //4단계 : 메뉴 추가
    try{
        String value = "\"" + name + "\", " + price + ", " + rnum;

        rs = str.executeUpdate("insert into food(name, price, rnum) values (" + value +")");

        if(rs > 0) {
            out.println("<center><h3>메뉴를 성공적으로 추가했습니다.</h3></center>");

            str.close();
            conn.close();
        } else {
            out.println("<h3>메뉴 추가에 실패했습니다.</h3>");
        }
    } catch(Exception e) {
        System.out.println("insert에 실패했습니다.");
        System.out.println(e);
    }
%>
<center>
    <a href="index.jsp"><button>뒤로가기</button></a>
</center>
</body>
</html>
