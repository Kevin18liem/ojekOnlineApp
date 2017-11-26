<%@ page import="ojeksoap.controller.OrderImplService" %>
<%@ page import="ojeksoap.controller.Order" %>
<%@ page import="ojeksoap.controller.UsersImplService" %>
<%@ page import="ojeksoap.controller.Users" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 11/3/2017
  Time: 2:47 PM
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
            <div class=button-order>
                <div class=number-box>
                    3
                </div>
                <div class=text-box>
                    Chat driver
                </div>
            </div>
            <div class=current-button-order>
                <div class=number-box>
                    4
                </div>
                <div class=text-box>
                    Complete your order
                </div>
            </div>
        </div>

        <form name="completeForm" method="get" action="" onsubmit="return validateForm()">
            <%-- action untuk complete order --%>
            <div class=horizontal-view style="margin-top:20px">
                <h2>HOW WAS IT?</h2>
                <div class=horizontal-view style="text-align:center">
                    <div class=horizontal-view style="text-align: center">

                        <%
                            UsersImplService usersImplService = new UsersImplService();
                            Users users = usersImplService.getUsersImplPort();
                            String result = users.getUserByUsername(session.getAttribute("chosenDriverUsername").toString());
                            String[] userProfile = result.split("%");
                            out.print("<div class='profile-img' style=\"background-image: url(\'img/"+userProfile[4]+"\')\"></div>");
                            out.print("<div class='driver-name'>"+userProfile[0]+"</div>");
                            out.print("<div class='driver-name'>"+userProfile[1]+"</div>");
                        %>

                        <h1>
                            <font color=orange id="star1" onClick="rate(1)">&#9734</font>
                            <font color=orange id="star2" onClick="rate(2)">&#9734</font>
                            <font color=orange id="star3" onClick="rate(3)">&#9734</font>
                            <font color=orange id="star4" onClick="rate(4)">&#9734</font>
                            <font color=orange id="star5" onClick="rate(5)">&#9734</font>
                        </h1>

                        <script>
                            function rate(idx) {
                                document.getElementById("star1").innerHTML = "&#9734";
                                document.getElementById("star2").innerHTML = "&#9734";
                                document.getElementById("star3").innerHTML = "&#9734";
                                document.getElementById("star4").innerHTML = "&#9734";
                                document.getElementById("star5").innerHTML = "&#9734";
                                switch (idx) {
                                    case 1:
                                        document.getElementById("star1").innerHTML = "&#9733";
                                        document.getElementById("rating").value = 1;
                                        break;
                                    case 2:
                                        document.getElementById("star1").innerHTML = "&#9733";
                                        document.getElementById("star2").innerHTML = "&#9733";
                                        document.getElementById("rating").value = 2;
                                        break;
                                    case 3:
                                        document.getElementById("star1").innerHTML = "&#9733";
                                        document.getElementById("star2").innerHTML = "&#9733";
                                        document.getElementById("star3").innerHTML = "&#9733";
                                        document.getElementById("rating").value = 3;
                                        break;
                                    case 4:
                                        document.getElementById("star1").innerHTML = "&#9733";
                                        document.getElementById("star2").innerHTML = "&#9733";
                                        document.getElementById("star3").innerHTML = "&#9733";
                                        document.getElementById("star4").innerHTML = "&#9733";
                                        document.getElementById("rating").value = 4;
                                        break;
                                    case 5:
                                        document.getElementById("star1").innerHTML = "&#9733";
                                        document.getElementById("star2").innerHTML = "&#9733";
                                        document.getElementById("star3").innerHTML = "&#9733";
                                        document.getElementById("star4").innerHTML = "&#9733";
                                        document.getElementById("star5").innerHTML = "&#9733";
                                        document.getElementById("rating").value = 5;
                                        break;
                                    default:
                                        break;
                                }
                            }
                        </script>

                        <h4><input type="hidden" id="rating" name="rating" value = 0></h4>
                        <h4><textarea name="comment" cols="100" rows="5" placeHolder="Your comment..."></textarea></h4>

                    </div>
                </div>
                <div class=horizontal-view>
                    <div class=horizontal-view style="text-align:right">
                        <input type="submit" class="button-next" value="COMPLETE ORDER" name="create-order">
                    </div>
                </div>
            </div>
        </form>

    </div>

    <script>
        function validateForm() {
            if(document.forms["completeForm"]["comment"].value == "") {
                alert("comment must not be empty !");
                return false;
            }
        }
    </script>

    <%
        if(request.getParameter("create-order")!=null){
            OrderImplService orderImplService = new OrderImplService();
            Order order = orderImplService.getOrderImplPort();
            int driver = Integer.parseInt(session.getAttribute("chosenDriver").toString());
            String pickup = session.getAttribute("pickup").toString();
            String destination = session.getAttribute("destination").toString();
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            result = users.getUserByUsername(username);
            userProfile = result.split("%");

            int getId = Integer.parseInt(userProfile[5]);
            String res = order.createOrder(access_token, getId,driver,pickup,destination,rating,comment);
            //Check if the order is created, if not, then the session has expired and redirect to login
            if(res.equals("not found") || res.equals("expired")){
                response.sendRedirect("profile.jsp");
            } else {
                response.sendRedirect("order_1.jsp");
            }
        }
    %>
</body>
</html>
