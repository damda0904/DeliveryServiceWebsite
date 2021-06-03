<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>1711428 이지수</title>
    <header><center><h1>성공적으로 삭제하였습니다.</h1><hr/></center></header>
</head>
<body>
    <%
        String onum = request.getParameter("onum");


        //주문번호를 입력하지 않았을 경우
        if (request.getParameter("onum") == "") {
            PrintWriter script = response.getWriter();
            script.println("<script>alert('주문번호를 다시 입력해 주세요.');history.back()</script>");
        }
        else {
            Connection conn = null;
            Statement str = null;
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
                System.out.println(e);
            }


            //3단계 : 주문번호 검색해보기
            try {
                str = conn.createStatement();
                String query = "select onum from orders where onum = \"" + onum + "\"";
                rs = str.executeQuery(query);

                boolean check = false;

                while (rs.next()) {
                    check = true;
                }

                //아무것도 검색되지 않을 경우
                if (check == false) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>alert('2. 주문이 존재하지 않습니다.');history.back()</script>");
                }

                rs.close();
            } catch (Exception e) {
                System.out.println("검색에 실패했습니다.");
                System.out.println("");
                System.out.println(e);
            }


            //4단계 : 레코드 삭제
            try {
                str.executeUpdate("delete from orders where onum = " + onum);
            } catch (Exception e) {
                System.out.println("레코드를 삭제할 수 없습니다.");
                System.out.println("");
                System.out.println(e);
            }
        }
    %>
    <a href="index.jsp"><button>뒤로가기</button></a>
</body>
</html>
