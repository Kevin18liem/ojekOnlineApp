<%--
  Created by IntelliJ IDEA.
  User: Kezia Suhendra
  Date: 11/21/17
  Time: 2:15 PM
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
                        xhttp.open("POST", "http://localhost:8001/logout", true);
                        xhttp.setRequestHeader("content-type","application/x-www-form-urlencoded");
                        var nameEQ = "access_token" + "=";
                        var ca = document.cookie.split(';');
                        for(var i=0;i < ca.length;i++) {
                            var c = ca[i];
                            while (c.charAt(0)==' ') c = c.substring(1,c.length);
                            if (c.indexOf(nameEQ) == 0)
                                var token = c.substring(nameEQ.length,c.length);
                        }
                        var params = "token="+token;
                        xhttp.send(params);
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
            <div class=current-button>
                ORDER
            </div>
        </a>
        <a href="history.jsp">
            <div class=button>
                HISTORY
            </div>
        </a>
        <a href="profile.jsp">
            <div class="button">
                MY PROFILE

            </div>
        </a>
    </div>

    <div class=horizontal-view style="display: inline-block;width: 90%">
        <h1>LOOKING FOR AN ORDER</h1>
    </div>

    <div class=horizontal-view style="text-align:center;margin-top: 40px">
        <h3><font color="#32cd32">Got an Order!</font></h3>
        <h4>namayangorder</h4>
    </div>

    <div class="horizontal-view" style="text-align: center;width: 100%;margin-top: 60px">
        <div class="chat-box">
            <div class="talk-bubble-you" style="margin-left: 67%; text-align: left">Sudah dimana?</div>
            <div class="talk-bubble-you" style="margin-left: 67%; text-align: left">Sudah dimana?</div>
            <div class="talk-bubble-me" style="margin-right: 60%; text-align: left">Di gerbang depan.</div>
            <div class="talk-bubble-me" style="margin-right: 60%; text-align: left">Di gerbang depan.</div>
            <div class="talk-bubble-you" style="margin-left: 67%; text-align: left">Sudah dimana?</div>
            <div class="talk-bubble-me" style="margin-right: 60%; text-align: left">Di gerbang depan.</div>
            <div class="talk-bubble-you" style="margin-left: 67%; text-align: left">Sudah dimana?</div>
            <div class="talk-bubble-me" style="margin-right: 60%; text-align: left">Di gerbang depan.</div>
        </div>
        <div class="input-box">
            <div class=horizontal-view style="display: inline-block;width: 100%;margin: 6px">
                <input type="text" placeholder="Type Your Message Here" size="50" style="border-color: transparent; border: none; font-size: medium">
                <input type="submit" value="KIRIM" name="next-page" class="button-send" style="margin-left: 15px">
            </div>
        </div>
    </div>

</div>

</body>
</html>

