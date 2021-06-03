<%--
  Created by IntelliJ IDEA.
  User: wbspq
  Date: 2021-05-29
  Time: 오전 3:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>1711428 이지수</title>
    <center>
        <h1>배달원 로그인 페이지</h1>
        <hr/>
    </center>
</head>
<body>
<fieldset>
    <legend>로그인 관리</legend>
    <center>
        <form name="Login" action="chooseOrder.jsp" method="post">
            <table border="1">
                <tbody>
                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" name="did" size="20"/>
                    </td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td>
                        <input type="password" name="passwd" size="20"/>
                    </td>
                </tr>
                </tbody>
            </table>
            <br/>
            <table>
                <tbody>
                <tr>
                    <input type="submit" value="로그인"/>
                </tr>
                </tbody>
            </table>
        </form>
        <a href="index.jsp">
            <button>뒤로가기</button>
        </a>
    </center>
</fieldset>
</body>
</html>
