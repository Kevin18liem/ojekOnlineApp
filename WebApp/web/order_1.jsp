<%@ page import="ojeksoap.controller.OrderImplService" %>
<%@ page import="ojeksoap.controller.Order" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 11/3/2017
  Time: 2:25 PM
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
            <h1>MAKE AN ORDER</h1>
        </div>

        <div class=horizontal-view style="text-align: center;font-size: 60px;margin: 10px">
            <div class=current-button-order>
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
            <div class=button-order>
                <div class=number-box>
                    4
                </div>
                <div class=text-box>
                    Complete your order
                </div>
            </div>
        </div>
        <form method="get" name="orderForm" onsubmit="return validateForm()">
            <%-- action untuk order validation --%>
            <div style="text-align:center;margin-top:20px;">
                <div style="display:inline-block;text-align:left;margin-right:20px;">
                    <h4>Picking point</h4>           <br>
                    <h4>Destination</h4>        <br>
                    <h4>Preferred Driver</h4>   <br>
                </div>
                <div style="text-align:left;display:inline-block">
                    <h4><input type="hidden" name="id" value="<?php echo $userid ?>"></h4>
                    <h4><input type="text" name="from" size="50" placeholder="pickup"></h4>    <br>
                    <h4><input type="text" name="to" size="50" placeholder="destination"></h4>    <br>
                    <h4><input type="text" name="prefDriver" size="50" placeholder="(optional)"></h4>    <br>

                </div>
            </div>

            <div class=horizontal-view style="text-align:center;margin-top: 20px">
                <input type="submit" value="NEXT" name="next-page" class="button-next">
            </div>
        </form>

    </div>

    <script>
        function validateForm() {
            if(document.forms["orderForm"]["from"].value == "") {
                alert("Picking point must not be empty !");
                return false;
            } else
            if(document.forms["orderForm"]["to"].value == "") {
                alert("Destination must not be empty !");
                return false;
            }
        }
    </script>

    <%
        String pickup = request.getParameter("from");
        String destination = request.getParameter("to");
        String preferredDriver = request.getParameter("prefDriver");

        if(request.getParameter("next-page")!=null){
            // Get the Service
            OrderImplService orderImplService = new OrderImplService();
            Order order = orderImplService.getOrderImplPort();
            String result = order.searchDriver(pickup, destination, preferredDriver);
            out.println(result);
            session.setAttribute("order-data",result);
            session.setAttribute("pickup",pickup);
            session.setAttribute("destination",destination);
            session.setAttribute("preferredDriver",preferredDriver);
            response.sendRedirect("order_2.jsp");
        }
    %>
</body>
</html>
