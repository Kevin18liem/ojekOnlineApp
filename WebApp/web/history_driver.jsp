<%@ page import="ojeksoap.controller.History" %>
<%@ page import="ojeksoap.controller.HistoryImplService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 11/3/2017
  Time: 3:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>HISTORY</title>
    <link rel="stylesheet" type="text/css" href="css/profile_style.css">
    <script src="js/history.js"></script>
</head>
<body>
<%
    /* *** Session Management *** */
    Cookie[] cookies = request.getCookies();
    String username = "";
    String access_token = "";
    String expiry_time = "";
    String isDriver = "";
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
        if(c.getName().equals("isDriver")){
            isDriver  = c.getValue();
        }
    }
    if(username.equals("")){
        response.sendRedirect("index.jsp");
    }
    int i=0;
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
                    Hi, <b>
                    <%= username %>
                </b> !
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
            <% if(isDriver.equals("1")){%>
            <a href="http://localhost:8000/lookOrder.jsp">
                <div class=button>
                    ORDER
                </div>
            </a>
            <% }else{ %>
            <a href="http://localhost:8000/order_1.jsp">
                <div class=button>
                    ORDER
                </div>
            </a>
            <% } %>
            <a href="http://localhost:8000/history.jsp">
                <div class=current-button>
                    HISTORY
                </div>
            </a>
            <a href="http://localhost:8000/profile.jsp">
                <div class="button">
                    MY PROFILE
                </div>
            </a>
        </div>

        <div class=horizontal-view style="display: inline-block;width: 90%">
            <h1>TRANSACTION HISTORY</h1>
        </div>

        <div class=horizontal-view style="text-align: center;margin-top: 10px">
            <a href="http://localhost:8000/history.jsp">
                <div class="button-history">
                    MY PREVIOUS ORDER
                </div>
            </a>
            <a href="http://localhost:8000/history_driver.jsp">
                <div class="current-button-history">
                    DRIVER HISTORY
                </div>
            </a>
        </div>
        <form method="post" action="/hidedriverhistory">
              <input type="hidden" value="" id="historyDriverIdTransaction" name="historyDriverIdTransaction"/>
            <div class=horizontal-view style="margin-top: 80px ">
                <%
                    HistoryImplService historyImplService = new HistoryImplService();
                    History history = historyImplService.getHistoryImplPort();
                    String resultDriverHistoryOrder = history.getDriverHistoryByUsername(access_token,username);
                    if(resultDriverHistoryOrder.equals("")) {
                        out.println("<div class=horizontal-view style=\\\"text-align:center\\\">\n" +
                                "                                <div class=text-box style=\\\"text-align: center; margin: 20px\\\">\n" +
                                "                                    <div class=shadow-text>Nothing to display :<</div>\n" +
                                "                                </div>\n" +
                                "                           </div>");
                    } else {
                        String[] listHistoryDriverOrder = resultDriverHistoryOrder.split("\\$");
                        for (String counter : listHistoryDriverOrder) {
                            String[] fieldHistoryDriverOrder = counter.split("\\%");
                            if(!fieldHistoryDriverOrder[9].equals("1")) {
                                SimpleDateFormat dateOrderFormat = new SimpleDateFormat("yyyy-MM-dd");
                                SimpleDateFormat outputOrderFormat = new SimpleDateFormat("E, M  d YYYY");
                                Date dateOrder = null;
                                try {
                                    dateOrder = dateOrderFormat.parse(fieldHistoryDriverOrder[6]);
                                    String newDateString = outputOrderFormat.format(dateOrder);
                                    out.println("<div class=driver>" +
                                        "<div class='driver-img' style=\"background-image: url(\'img/"+fieldHistoryDriverOrder[7]+"\')\"></div>"+
                                            "      <div class=driver-history>" +
                                            "          <div class=horizontal-view>" +
                                            "               <div class=two-row-block style=\"width:70%\">" +
                                            "                    <div class=date>" + newDateString + "</div>" +
                                            "                    <div class=driver-name-history>" + fieldHistoryDriverOrder[1] + "</div>" +
                                            "               </div>" +
                                            "<input type='hidden' name='idPreviousOrderTransaction' value="+fieldHistoryDriverOrder[0]+" />"+
                                            "          <input type = 'submit' name='chooseHiddenDriver' class='hide-button' value=" + "'HIDE' onclick='return chooseHistoryOrderDriver("+fieldHistoryDriverOrder[0]+");'/>"+
                                            "          </div>" +
                                            "          <div class=loc-history>\n" + fieldHistoryDriverOrder[2] + " - " + fieldHistoryDriverOrder[3] + "</div>\n" +
                                            "          <div class=driver-rating-history>\n" +
                                            "                Gave<font color=orange> " + fieldHistoryDriverOrder[4] + " </font>stars on this order <br>\n" +
                                            "                and left a comment:\n" +
                                            "          </div>\n" +
                                            "          <div class=horizontal-view style=\\\"margin-left: 20px\\\">\n" +
                                            "              <div class=driver-comment>\n" + fieldHistoryDriverOrder[5] + "</div>\n" +
                                            "          </div>\n" +
                                            "       </div>\n" +
                                            "</div> <br><br>");
                                } catch (ParseException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                %>
            </div>
        </form>
    </div>
</body>
</html>
