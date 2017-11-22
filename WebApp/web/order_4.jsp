<%@ page import="ojeksoap.controller.OrderImplService" %>
<%@ page import="ojeksoap.controller.Order" %>
<%@ page import="ojeksoap.controller.UsersImplService" %>
<%@ page import="ojeksoap.controller.Users" %>
<%--
  Created by IntelliJ IDEA.
  User: Kezia Suhendra
  Date: 11/21/17
  Time: 1:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ORDER</title>
    <link rel="stylesheet" type="text/css" href="css/profile_style.css">
</head>
<body>
<%
    /* *** Session Management *** */
    Cookie[] cookies = request.getCookies();
    String username = "";
    String access_token = "";
    String expiry_time = "";
    for(Cookie c : cookies){
        if(c.getName().equals("username")){
            username = c.getValue();
        }
        if(c.getName().equals("access_token")){
            access_token = c.getValue();
        }
        if(c.getName().equals("expiry_time")){
            expiry_time = c.getValue();
        }
    }
    if(username.equals("")){
        response.sendRedirect("index.jsp");
    }
%>

<div class=layout>
    <div class=horizontal-view>
        <div class=two-row-block>
            <div class=title>
                &#128008 KAT-JEK
            </div>
            <div class=subtitle>
                BRUM BRUM BRUM LETS GOOOO!!!!
            </div>
        </div>
        <div class=two-row-block style="bottom: 15px">
            <div class=username>
                Hi, <b><%= username %></b>!
            </div>

            <div class=logout>
                <a href="#" id="logout">Logout</a>
                <script>
                    /* *** Logout Management *** */
                    document.getElementById("logout").onclick = function() {
                        var xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function () {
                            if(this.readyState == 4 && this.status == 200){
                                var text = xhttp.responseText;
                                window.location = "index.jsp";
                            }
                        };
                        xhttp.open("GET", "http://localhost:8001/logout/<%= access_token %>", true);
                        xhttp.send();
                        document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
                        document.cookie = "access_token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
                        document.cookie = "expiry_date=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
                    };
                </script>
            </div>

        </div>
    </div>

    <div class=horizontal-view style="text-align: center">
        <a href="order_1.jsp">
            <div class=button>
                ORDER
            </div>
        </a>
        <a href="history.jsp">
            <div class=button>
                HISTORY
            </div>
        </a>
        <a href="profile.jsp">
            <div class="current-button">
                MY PROFILE

            </div>
        </a>
    </div>

    <div class=horizontal-view style="display: inline-block;width: 90%">
        <h1>MAKE AN ORDER</h1>
    </div>

    <div class=horizontal-view style="text-align: center;font-size: 60px;margin: 10px">
        <div class=button-order>
            <div class=number-box>
                1
            </div>
            <div class=text-box>
                Select Destination
            </div>
        </div>
        <div class=button-order>
            <div class=number-box>
                2
            </div>
            <div class=text-box>
                Select a Driver
            </div>
        </div>
        <div class=current-button-order>
            <div class=number-box>
                3
            </div>
            <div class=text-box>
                Chat driver
            </div>
        </div>
        <div class=button-order>
            <div class=number-box>
                4
            </div>
            <div class=text-box>
                Complete your order
            </div>
        </div>
    </div>

    <div class="horizontal-view" style="text-align: center;width: 100%;margin-top: 50px">
        <div class="chat-box">

        </div>
        <div class="input-box">
            <div class=horizontal-view style="display: inline-block;width: 100%;margin: 6px">
                <input type="text" placeholder="Aa" size="75">
                <input type="submit" value="KIRIM" name="next-page" class="button-send" style="margin-left: 15px">
            </div>
        </div>
    </div>

    <div class=horizontal-view style="text-align:center;margin-top: 50px">
        <input type="submit" value="CLOSE" name="cancel-order" class="button-cancel">
    </div>
</div>
</body>
</html>

