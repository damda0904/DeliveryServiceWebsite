<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>1711428이지수</title>
    <header>
        <h1>배달할 주문을 선택하세요</h1>
    </header>
</head>
<body>
<center>
    <fieldset>
        <legend>주문 리스트 선택하기</legend>
        <table border="1">
            <form method="get" action="ChoiceResult.jsp">
                <%
                    int dnum = 0;
                    String location = null;

                    String did = request.getParameter("did");
                    String passwd = request.getParameter("passwd");


                    //아이디를 입력하지 않았을 경우
                    if (request.getParameter("did") == "") {
                        PrintWriter script = response.getWriter();
                        script.println("<script>alert('아이디를 다시 입력해 주세요.');history.back()</script>");
                    }
                    //비밀번호를 입력하지 않았을 경우
                    else if (request.getParameter("passwd") == "") {
                        PrintWriter script = response.getWriter();
                        script.println("<script>alert('비밀번호를 다시 입력해 주세요.');history.back()</script>");
                    } else {
                        Connection conn = null;
                        Statement str = null;
                        ResultSet info = null;
                        ResultSet rs = null;


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


                        //3단계 : id 검색해보기
                        try {
                            str = conn.createStatement();
                            String query = "select dnum, location from deliveryman where id = \"" + did + "\"";
                            info = str.executeQuery(query);


                            while (info.next()) {
                                dnum = Integer.parseInt(info.getString("dnum"));
                                location = info.getString("location");
                            }

                            //아무것도 검색되지 않을 경우
                            if (dnum == 0) {
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


                        //4단계 : 리스트 검색 및 출력
                        try {
                            str = conn.createStatement();

                            String query = "select o.onum, r.name, f.name, o.price, o.count " +
                                    "from orders o, restaurant r, food f " +
                                    "where o.rnum = r.rnum " +
                                    "and o.fnum = f.fnum " +
                                    "and o.dnum = 1 " +
                                    "and o.location = \"" + location + "\"";

                            rs = str.executeQuery(query);
                            out.println("<tr>");
                            out.println("<td>주문번호</td>");
                            out.println("<td>가게명</td>");
                            out.println("<td>메뉴명</td>");
                            out.println("<td>주문 수량</td>");
                            out.println("<td>결제금액</td>");
                            out.println("</tr>");

                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getString("o.onum") + "</td>");
                                out.println("<td>" + rs.getString("r.name") + "</td>");
                                out.println("<td>" + rs.getString("f.name") + "</td>");
                                out.println("<td>" + rs.getString("o.count") + "</td>");
                                out.println("<td>" + rs.getString("o.price") + "</td>");
                                out.println("<td><input type=\'radio\' name=\"onum\" value=\'" + rs.getString("o.onum") + "\'/></td>");
                                out.println("</tr>");
                            }

                            rs.close();
                            str.close();
                            conn.close();
                        } catch (Exception e) {
                            System.out.println("주문 리스트를 가져오지 못했습니다.");
                            System.out.println(e);
                        }
                    }
                %>
                <h3><%=dnum%></h3><br/>
                <text>위 번호를 다시 입력하세요</text>
                <br/>
                <input type="text" name="dnum"/>
                <input type="submit" value="선택하기"/>
                <br/><br/>
            </form>
        </table>
    </fieldset>
</center>
</body>
</html>
