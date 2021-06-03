<%--
  Created by IntelliJ IDEA.
  User: wbspq
  Date: 2021-05-26
  Time: 오후 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"  language="java" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>

<jsp:useBean id="sch" scope="request" class="keyosk.search" />

<jsp:setProperty name="sch" property="orderLocation" param="location"/>

<html>
<head>

    <title>1711428 이지수</title>
    <header>
        <center>
            <h1>배달 주문 키오스크</h1>
            <hr/>
        </center>
    </header>
</head>
<body>
    <fieldset>
        <legend>키오스크</legend>
        <center>
            <%
                Connection conn = null;
                Statement str = null;
                ResultSet rs = null;

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
            %>
                <form method="get" action="OrderPage.jsp">
                    <text>지역 : </text>
                    <input type="location" name="location" size="30" value=<%=sch.getOrderLocation()%>/>
                    <input type="submit" value = "검색"/>

                </form>
                <fieldset>
                    <legend>전체 메뉴</legend>
                    <form method="get" action="OrderResult.jsp">
                        <table border="1">
                            <tr>
                                <th>메뉴</th>
                                <th>가격</th>
                                <th>선택</th>
                            </tr>


                            <%
                                String query = null;
                                String loc = sch.getOrderLocation();

                                //검색어가 없는 경우
                                if(loc == "")
                                    query = "select * from food f";
                                //검색어가 있는 경우
                                else
                                    query = "select * from restaurant r, food f where r.rnum = f.rnum and r.place ='" + loc + "'";


                                //3단계 : 메뉴 검색
                                try {
                                    str = conn.createStatement();
                                    rs = str.executeQuery(query);
                                    System.out.println("테이블의 전체 데이터를 성공적으로 검색하였습니다.");
                                } catch (SQLException e){
                                    System.out.println("테이블의 전체 데이터 검색을 실패하였습니다.");
                                }

                                try {
                                    //검색 결과가 없을 경우
                                    if(!(rs.next())){
                            %>
                            <tr><td colspan=7> 검색한 데이터가 없습니다.</td> </tr>
                            <%
                                    }
                                    else {
                                        do {
                                            out.println("<td>" + rs.getString("f.name") + "</td>");
                                            out.println("<td>" + rs.getString("price") + "원</td>");
                                            out.println("<td><input type=\'radio\' name=\"fnum\" value=\'" + rs.getString("fnum") + "\'/></td>");
                                            out.println("<tr>");
                                        } while(rs.next());
                                    }
                                    rs.close();
                                    str.close();
                                    conn.close();
                                } catch(SQLException e) {
                                    System.out.println(e);
                                }
                            %>
                        </table>
                        <text>수량 : </text>
                        <input type='text' name="count"/>
                        <input type="submit" value="주문하기"/>
                    </form>
                    <a href="index.jsp"><button>뒤로가기</button></a>
                </fieldset>

        </center>
    </fieldset>
</body>
</html>
