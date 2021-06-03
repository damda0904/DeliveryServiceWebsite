<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>


<html>
<head>
    <title>1711428이지수</title>
    <header>
        <center><h1>내 가게 매출 현황 리스트</h1></center>
    </header>
</head>
<body>
<center>
    <fieldset>
        <legend>매출 현황</legend>
        <table border="1">
            <tbody>
                <%
            int rnum = 0;

            //아이디가 없을 경우
            if (request.getParameter("rid") == "") {
                PrintWriter script = response.getWriter();
                script.println("<script>alert('아이디를 다시 입력해 주세요.');history.back()</script>");
            }
            //비밀번호가 없을 경우
            else if (request.getParameter("passwd") == "") {
                PrintWriter script = response.getWriter();
                script.println("<script>alert('비밀번호를 다시 입력해 주세요.');history.back()</script>");
            }
            else {
                Connection conn = null;
                Statement str = null;
                ResultSet info = null;
                ResultSet rs = null;

                int total = 0;
                int records = 0;
                String name = null;
                int count = 0;
                int price = 0;


                String rid = request.getParameter("rid");
                String passwd = request.getParameter("passwd");

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
                } catch (SQLException e) {
                    System.out.println("DB  서버 접속을 실패하였습니다.");
                }

                //3단계 : id 검색해보기
                try {
                    str = conn.createStatement();
                    String query = "select rnum from restaurant where id = \"" + rid + "\"";
                    info = str.executeQuery(query);


                    while (info.next()) {
                        rnum = Integer.parseInt(info.getString("rnum"));
                    }

                    //아무것도 검색되지 않을 경우
                    if (rnum == 0) {
                        PrintWriter script = response.getWriter();
                        script.println("<script>alert('id가 맞지 않습니다.');history.back()</script>");
                    }

                    //비밀번호가 틀릴 경우
                    else if (!passwd.equals("1234")) {
                        PrintWriter script = response.getWriter();
                        script.println("<script>alert('비밀번호를 확인해주십시오.');history.back()</script>");
                    }

                    info.close();
                } catch (Exception e) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>alert('검색에 실패했습니다.');history.back()</script>");
                }

                //4단계 : 매출 리스트 검색 후 출력
                try {
                    rs = str.executeQuery("select * from orders o, food f where o.fnum = f.fnum and o.rnum = " + rnum);

                    out.println("<tr>");
                    out.println("<td>메뉴명</td><td>수량</td><td>결제금액</td>");
                    out.println("</tr>");

                    while (rs.next()) {
                        String onum = rs.getString("o.onum");
                        name = rs.getString("f.name");
                        count = Integer.parseInt(rs.getString("o.count"));
                        price = Integer.parseInt(rs.getString("o.price"));

                        out.println("<tr>");
                        out.println("<td>" + name + "</td><td>" + count + "</td><td>" + price + "</td>");
                        out.println("</tr>");
                        total += price;
                        records++;
                    }
                    out.println("</tbody>");
                    out.println("</table>");

                    out.println("총 주문 개수 : " + records + "<br/>");
                    out.println("총 매출액 : " + total);

                    rs.close();
                    str.close();
                    conn.close();
                } catch (Exception e) {
                    System.out.println("목록을 가져오는데 실패했습니다.");
                    System.out.println(e);
                }
            }
        %>
    </fieldset>
    <br/>
    <a href="index.jsp"><button>뒤로가기</button></a>
</center>
</body>
</html>
