<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 11/3/2017
  Time: 2:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ojeksoap.controller.UsersImplService" %>
<%@ page import="ojeksoap.controller.Users" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>
<html>
<head>
    <title>ORDER</title>
    <link rel="stylesheet" type="text/css" href="css/profile_style.css">
    <script src="js/order.js"></script>
</head>
<body>
<%
    String data = session.getAttribute("order-data").toString();
    String preferredDriver = session.getAttribute("preferredDriver").toString();
    String[] drivers = data.split("\\$");
%>
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
            <div class=current-button>
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
            <div class=button-order>
                <div class=number-box>
                    1
                </div>
                <div class=text-box>
                    Select Destination
                </div>
            </div>
            <div class=current-button-order>
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

        <form method="post">
            <input type="hidden" value="" id="chosen-driver" name="chosenDriver"/>
            <input type="hidden" value="" id="driver-username" name="chosenDriverUsername"/>
        <div class=horizontal-view style="margin-top:20px; border: 2px solid black;border-radius:10px">
            <h2>PREFERRED DRIVERS</h2>
            <%
                boolean preferredDriverFound = false;
                if(!preferredDriver.equals("")){
                    for(String d : drivers){
                        String[] driverDetail = d.split("%");
                        //Name and isDriver
                        if(driverDetail[1].equals(preferredDriver) && Integer.parseInt(driverDetail[3]) == 1){
                            //Get driver rating
                            UsersImplService userService = new UsersImplService();
                            Users users = userService.getUsersImplPort();
                            String result = users.getUserRatingAndVotes(driverDetail[0]);

                            String[] ratings = result.split("%");

                            out.println("<div class='driver'><div class='driver-img' style=\"background-image: url(\'img/"+
                                    driverDetail[2] +"\')\"></div><div class='driver-desc'><div class='driver-name'>"+ driverDetail[1] +
                                    "</div><div class='driver-rating'>"+ratings[1]+" "+ ratings[2]+" votes</div></div>" +
                                    "<input type='submit' name='chooseDriver' class='button-choose-driver' value=" +
                                    "'I CHOOSE YOU!' onclick='return choose("+ratings[0]+",\""+driverDetail[0]+"\");' /></div>");
                            preferredDriverFound = true;
                        }
                    }
                }
                if(!preferredDriverFound){
                    out.println("<div class='shadow-text'>Nothing to display :(</div>");
                }
            %>
        </div>

        <div class=horizontal-view style="margin-top:20px; border: 2px solid black;border-radius:10px">
            <h2>OTHER DRIVERS</h2>
            <%
                if(!data.equals("")) {
                    for(String d : drivers){
                        String[] driverDetail = d.split("%");
                        //Name and isDriver
                        if(!driverDetail[1].equals(preferredDriver) && Integer.parseInt(driverDetail[3]) == 1){
                            //Get driver rating
                            UsersImplService userService = new UsersImplService();
                            Users users = userService.getUsersImplPort();
                            String result = users.getUserRatingAndVotes(driverDetail[0]);

                            String[] ratings = result.split("%");

                            out.println("<div class='driver'><div class='driver-img' style=\"background-image: url(\'img/"+
                                    driverDetail[2] +"\')\"></div><div class='driver-desc'><div class='driver-name'>"+ driverDetail[1] +
                                    "</div><div class='driver-rating'>"+ratings[1]+" "+ ratings[2]+" votes</div></div>" +
                                    "<input type='submit' name='chooseDriver' class='button-choose-driver' value=" +
                                    "'I CHOOSE YOU!' onclick='return choose("+ratings[0]+",\""+driverDetail[0]+"\""+",\""+username+"\");' /></div>");
                        }
                    }
                } else {
                    out.println("<div class='shadow-text'>Nothing to display :(</div>");
                }

            %>
        </div>
        </form>
    </div>

    <%
        if(request.getParameter("chooseDriver")!=null){
            session.setAttribute("chosenDriver",request.getParameter("chosenDriver"));
            session.setAttribute("chosenDriverUsername",request.getParameter("chosenDriverUsername"));
            response.sendRedirect("order_4.jsp");
        }
    %>
</body>
</html>
