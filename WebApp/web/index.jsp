<%--
  Created by IntelliJ IDEA.
  User: Trevin Matthew R
  Date: 11/3/2017
  Time: 11:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>LOGIN PAGE</title>
    <link rel="stylesheet" type="text/css" href="css/frontpage_style.css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://malsup.github.com/jquery.form.js"></script>
</head>
<body>
    <div class="table_align">
        <table>
            <tr height=150>
                <td align="center" colspan="2"><div class="headerline"><span class="header">LOGIN</span></div>
            </tr>

            <form method='POST' id="loginForm" name="signinForm"> <%-- action untuk login validation --%>
                <tr>
                    <td align="center" class="fillin">Email
                    <td><input type="email" name="email">
                </tr>
                <tr>
                    <td align="center" class="fillin">Password
                    <td><input type="password" name="password">
                </tr>
                <tr height=100>
                    <td align="center"><a href="signUp.jsp">Don't have an account ?</a>
                    <td align="center"><input type="submit" value="GO!">
                </tr>
            </form>
        </table>
    </div>

    <script>
        $('#loginForm').ajaxForm( {
            url :'http://localhost:8001/login',
            type:'POST',
            data:'postData',
            success: function(response) {
                if(response!=null) {
                    console.log(response);
                    document.cookie = "username=" + response.username;
                    document.cookie = "expiry_date=" + response.expiry_date;
                    document.cookie = "access_token=" + response.access_token;
                    $(location).attr('href','http://localhost:8000/profile.jsp');
                }
            },
            error: function(response) {
              alert("Authentication Error: Email or Password is Not Valid");
            }
        });
    </script>
</body>
</html>
