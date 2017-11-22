<%@ page import="com.sun.beans.decoder.ValueObject" %>
<%@ page import="ojeksoap.controller.UsersImplService" %>
<%@ page import="ojeksoap.controller.Users" %>
<%@ page import="javax.net.ssl.HttpsURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.DataOutputStream" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="jdk.nashorn.internal.parser.JSONParser" %><%--
  Created by IntelliJ IDEA.
  User: Trevin Matthew R
  Date: 11/3/2017
  Time: 11:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SIGN UP PAGE</title>
    <link rel="stylesheet" type="text/css" href="css/frontpage_style.css">

</head>
<body>

    <div class="table_align">
        <table>
            <tr height=150>
                <td align="center" colspan="2"><div class="headerline"><span class="header">SIGN UP</span></div>
            </tr>
            <form name = "loginForm"  method='POST' id ="registerForm" onSubmit=" return validateForm()">
            <%-- action untuk register validation --%>
                <input type="hidden" name="registerButtonHidden" id="register-button">
                <tr>
                    <td class="fillin">Your Name
                    <td><input type="text" name="name">
                </tr>
                <tr>
                    <td class="fillin">Username
                    <td><input type="text" name="username" size="15">
                </tr>
                <tr>
                    <td class="fillin">Email
                    <td><input type="email" name="email" size = "15">
                </tr>
                <tr>
                    <td class="fillin">Password
                    <td><input type="password" name="password">
                </tr>
                <tr>
                    <td class="fillin">Confirm Password
                    <td><input type="password" name="confirmPassword">
                </tr>
                <tr>
                    <td class="fillin">Phone Number
                    <td><input type="text" name="phone">
                </tr>
                <tr>
                    <td colspan="2"><input id="isDriver" type="checkbox" name="isDriver" value="1">Also sign me up as driver!
                </tr>
                <tr height="100">
                    <td><a href="index.jsp">Already have an account ?</a>
                    <td><input type="submit" value="REGISTER" name="registerButton" >
                </tr>
            </form>
        </table>
    </div>
    <script>
        function AuthenticateError(){
            alert("Authentication Error: Email or Username Has been Used"); // added sample text
        }
    </script>
    <%
        if(request.getParameter("registerButton")!=null) {
            //SEND REQUEST TO IDENTITY SERVICE
            String url = "http://localhost:8001/register";
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Accept-Language","en-US,en,q=0.5");
            String urlParameters = "username="+request.getParameter("username")+"&"+"name="+request.getParameter("name")+"&"+"email="+request.getParameter("email")+"&"+"password="+request.getParameter("password");
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
                String kodeDriver;
                if(request.getParameter("isDriver")==null)
                    kodeDriver = "0";
                else
                    kodeDriver = "1";
                users.createUser(request.getParameter("username"),request.getParameter("name"),request.getParameter("phone"),kodeDriver,"default.jpg");
                responseString.deleteCharAt(0);
                responseString.deleteCharAt(responseString.length()-1);
                String[] responseList = responseString.toString().split("\\,");
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
                    Cookie cookieAccessToken = new Cookie("access_token",accessToken.toString());
                    Cookie cookieIsDriver = new Cookie("isDriver", kodeDriver);
                    response.addCookie(cookieUsername);
                    response.addCookie(cookieAccessToken);
                    response.addCookie(cookieIsDriver);
                    if(kodeDriver.equals("1")) {
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
                    AuthenticateError();
                </script>
                <%
            }
        }
    %>
    <script>

        function validateForm(){
            if(document.forms["loginForm"]["name"].value == ""){
                alert("Your name must not be empty !");
                return false;
            }
            else
            if(document.forms["loginForm"]["username"].value == ""){
                alert("Username must not be empty !");
                return false;
            }
            else
            if(document.forms["loginForm"]["username"].value.length > 20){
                alert("Username length must not exceed 20 characters !");
                return false;
            }
            else
            if(document.forms["loginForm"]["username"].value == ""){
                alert("Email must not be empty !");
                return false;
            }
            else
            if(document.forms["loginForm"]["password"].value ==""){
                alert("Password must not be empty !");
                return false;
            }
            else
            if(document.forms["loginForm"]["password"].value == ""){
                alert("Please confirm your password !");
                return false;
            }
            if(document.forms["loginForm"]["password"].value != document.forms["loginForm"]["password"].value){
                alert("Your password doesn't match !");
                return false;
            }
            else
            if(document.forms["loginForm"]["phone"].value == ""){
                alert("Phone number must not be empty !");
                return false;
            }
            else
            if(document.forms["loginForm"]["phone"].value.length<9 || document.forms["loginForm"]["phone"].value.length>12){
                alert("Phone number digit must be between 9-12 !");
                return false;
            }
            else
            if(validateEmail(document.forms["loginForm"]["email"].value) == false){
                alert("Your email address is unrecognizable !");
                return false;
            }
        }
        function validateEmail(email){
            var re = /\S+@\S+\.\S+/;
            return re.test(email);
        }
    </script>

</body>
</html>
