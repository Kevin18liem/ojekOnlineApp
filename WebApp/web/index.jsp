<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.DataOutputStream" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="ojeksoap.controller.UsersImplService" %>
<%@ page import="ojeksoap.controller.Users" %>
<%@ page import="java.net.URLEncoder" %><%--
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
                    <td align="center" class="fillin">Username
                    <td><input type="text" name="username">
                </tr>
                <tr>
                    <td align="center" class="fillin">Password
                    <td><input type="password" name="password">
                </tr>
                <tr height=100>
                    <td align="center"><a href="signUp.jsp">Don't have an account ?</a>
                    <td align="center"><input type="submit" value="GO!" name="loginButton">
                </tr>
            </form>
        </table>
    </div>

    <%
        if(request.getParameter("loginButton")!=null) {
            //SEND REQUEST TO IDENTITY SERVICE
            String url = "http://localhost:8001/login";
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Accept-Language","en-US,en,q=0.5");
            String userAgent = request.getHeader("User-Agent");
            String urlParameters = "username="+request.getParameter("username")+"&"+"password="+request.getParameter("password")+"&"+"useragent="+userAgent;
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(urlParameters);
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();
            if(responseCode != 401) {
                BufferedReader in = new BufferedReader (
                        new InputStreamReader(con.getInputStream()));
                String inputLine;
                StringBuffer responseString = new StringBuffer();
                while((inputLine = in.readLine()) != null) {
                    responseString.append(inputLine);
                }
                in.close();

                //SEND REQUEST TO ojekService
                UsersImplService userService = new UsersImplService();
                Users users = userService.getUsersImplPort();
                String result = users.getUserByUsername(request.getParameter("username"));

                String[] profile = result.split("%");

                responseString.deleteCharAt(0);
                responseString.deleteCharAt(responseString.length()-1);
                System.out.println(responseString.toString());
                String[] responseList = responseString.toString().split("\\?");
                if(responseList.length>1) {
                    StringBuffer username = new StringBuffer(responseList[0].split("\\:")[1]);
                    username.deleteCharAt(0);
                    username.deleteCharAt(username.length()-1);
                    StringBuffer accessToken = new StringBuffer(responseList[1].split("\\:")[1]);
                    accessToken.deleteCharAt(0);
                    accessToken.deleteCharAt(accessToken.length()-1);
                    StringBuffer expiryDate = new StringBuffer(responseList[2].replace("\"expiry_date\":",""));
                    expiryDate.deleteCharAt(0);
                    expiryDate.deleteCharAt(expiryDate.length()-1);
                    out.println(username.toString());
                    out.println(accessToken.toString());
                    out.println(expiryDate.toString());
                    Cookie cookieUsername = new Cookie("username", username.toString());
                    Cookie cookieExpiryDate = new Cookie("expiry_time",expiryDate.toString());
                    Cookie cookieAccessToken = new Cookie("access_token",URLEncoder.encode(accessToken.toString(), "UTF-8"));
                    Cookie cookieIsDriver = new Cookie("isDriver", profile[3]);
                    response.addCookie(cookieUsername);
                    response.addCookie(cookieAccessToken);
                    response.addCookie(cookieIsDriver);

                    if(profile[3].equals("1")){
                        response.sendRedirect("profile.jsp");
                    } else {
                        response.sendRedirect("order_1.jsp");
                    }

                } else {
                    out.println("Authentication Error");
                }
            } else {
        %>
        <script>
            alert("Authentication Error: Email or Password is Not Valid");
        </script>
        <%
                }
            }
        %>
</body>
</html>
