<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>1711428 이지수</title>
    <header>
        <center>
            <h1>추가할 메뉴 정보를 입력하세요</h1>
            <hr/>
        </center>
    </header>
</head>
<body>
<%
    String rid = request.getParameter("rid");
    String passwd = request.getParameter("passwd");


    //아이디를 입력하지 않았을 경우
    if (request.getParameter("rid") == "") {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('아이디를 다시 입력해 주세요.');history.back()</script>");
    }
    //비밀번호를 입력하지 않았을 경우
    else if (request.getParameter("passwd") == "") {
        PrintWriter script = response.getWriter();
        script.println("<script>alert('비밀번호를 다시 입력해 주세요.');history.back()</script>");
    }
    else {
        Connection conn = null;
        Statement str = null;
        ResultSet info = null;
        ResultSet rs = null;

        int rnum = 0;

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
            System.out.println(e);
            PrintWriter script = response.getWriter();
            script.println("<script>alert('검색에 실패했습니다.');history.back()</script>");
        }
    }
%>
    <center>
        <form method="get" action="AddResult.jsp">
            <text>메뉴명 : </text>
            <input type="text" name="fname"/><br/>
            <text>가격 : </text>
            <input type="text" name="price"/><br/>
            <text>식당 이름 : </text>
            <input type="text" name="rname"/><br/>
            <br/><br/>
            <input type="submit" value="추가하기"/>

        </form>
    </center>
</body>
</html>
