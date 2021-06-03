<%--
  Created by IntelliJ IDEA.
  User: wbspq
  Date: 2021-05-29
  Time: 오전 2:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page language="java" import="java.sql.*"%>


<html>
<head>
    <title>1711428 이지수</title>
</head>
<body>
    <%
        Connection conn = null;
        Statement str = null;
        ResultSet info = null;  //food 정보와 restaurant 정보 가져오기
        ResultSet result = null;
        int rs = 0;    //insert 확인용

        String query1 = null;
        String query2 = null;

        int count = Integer.parseInt(request.getParameter("count"));
        int fnum = Integer.parseInt(request.getParameter("fnum"));

        int totalPrice = 0;

        //1단계 JDBC Driver 로딩하기
        try{
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("");
            System.out.println("MySQL JDBC Driver 로딩을 성공하였습니다.");
        } catch (ClassNotFoundException e){
            System.out.println("");
            System.out.println("MySQL JDBC Driver 로딩을 실패하였습니다.");
            System.out.println(e);
        }

        //2단계 DB 서버 접속하기
        try{
            String URL = "jdbc:mysql://localhost:3305/homework?serverTimezone=UTC";
            conn = DriverManager.getConnection(URL, "root", "123456");
            System.out.println("DB 서버 접속을 성공하였습니다.");
        } catch(SQLException e) {
            System.out.println("DB  서버 접속을 실패하였습니다.");
        }

        query1 = "select * from food f, restaurant r where f.rnum = r.rnum and fnum = " + fnum;


        //필요한 정보 가져오기
        try{
            str = conn.createStatement();
            info = str.executeQuery(query1);
        } catch (SQLException e){
            System.out.println("info 정보를 가져오지 못했습니다.");
            System.out.println(e);
        }

        while(info.next()){
            totalPrice = Integer.parseInt(info.getString("price")) * count;
            String place = info.getString("r.place");
            int rnum = Integer.parseInt(info.getString("r.rnum"));
            query2 = "insert into orders(rnum, count, location, price, fnum) " +
                    "values (" + rnum +", "+ count +", \""+ place +"\", "+ totalPrice +", "+ fnum  +")";
        }

        //삽입
        try{
            rs = str.executeUpdate(query2);

            if(rs>0) {
                System.out.println("성공적으로 데이터가 삽입되었습니다.");
            } else {
                System.out.println("데이터 삽입에 실패했습니다.");
            }
        } catch (SQLException e){
            System.out.println("insert 쿼리를 실패했습니다.");
            System.out.println(e);
        }

        //확인용
        try{
            result = str.executeQuery("select * from orders order by onum DESC limit 1");
        } catch (SQLException e){
            System.out.println("데이터를 가져오지 못했습니다.");
            System.out.println(e);
        }
    %>
    <center>
        <h1>주문이 완료되었습니다!</h1>
        <table border="1">
            <tr>
                <th>주문번호</th>
                <th>메뉴번호</th>
                <th>수량</th>
                <th>금액</th>
            </tr>
            <tr>
                <%
                    while(result.next()){
                        out.println("<td>" + result.getString("onum") + "</td>");
                        out.println("<td>" + result.getString("fnum") + "</td>");
                        out.println("<td>" + result.getString("count") + "</td>");
                        out.println("<td>" + result.getString("price") + "</td>");
                    }
                %>
            </tr>
        </table>
        <br/>
        <a href="index.jsp"><button>돌아가기</button></a>
    </center>
</body>
</html>
