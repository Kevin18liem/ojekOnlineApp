<%@ page import="ojeksoap.controller.HistoryImplService" %>
<%@ page import="ojeksoap.controller.History" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.sun.corba.se.impl.orbutil.ObjectUtility" %><%--
  Created by IntelliJ IDEA.
  User: Trevin Matthew R
  Date: 11/3/2017
  Time: 3:21 PM
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
    int i=0;

    HistoryImplService historyImplService = new HistoryImplService();
    History history = historyImplService.getHistoryImplPort();
    String resultPreviousOrder = history.getPreviousOrderByUsername(access_token,username);
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
                    </a>
                </div>
            </div>
        </div>

        <div class=horizontal-view style="text-align: center">
            <a href="http://localhost:8000/order_1.jsp">
                <div class=button>
                    ORDER
                </div>
            </a>
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
                <div class="current-button-history">
                    MY PREVIOUS ORDER
                </div>
            </a>
            <a href="http://localhost:8000/history_driver.jsp">
                <div class="button-history">
                    DRIVER HISTORY
                </div>
            </a>
        </div>
        <form method="post" action="/hidehistory">
            <input type="hidden" value="" id="history-driver-idtransaction" name="chosenHistoryDriveridTransaction"/>
            <div class=horizontal-view style="margin-top: 80px">
               <%
                   out.println(resultPreviousOrder);
                   if(resultPreviousOrder.equals("")) {
                       out.println("<div class=horizontal-view style=\\\"text-align:center\\\">\n" +
                                   "                                <div class=text-box style=\\\"text-align: center; margin: 20px\\\">\n" +
                                   "                                    <div class=shadow-text>Nothing to display :<</div>\n" +
                                   "                                </div>\n" +
                                   "                           </div>");
                   } else {
                       String[] listPreviousOrder = resultPreviousOrder.split("\\$");
                       for (String counter : listPreviousOrder) {
                           String[] fieldPreviousOrder = counter.split("\\%");
                           out.println(fieldPreviousOrder[0]);
                             if(!fieldPreviousOrder[8].equals("1")) {
                                 SimpleDateFormat dateOrderFormat = new SimpleDateFormat("yyyy-MM-dd");
                                 SimpleDateFormat outputOrderFormat = new SimpleDateFormat("E, M  d YYYY");
                                 Date dateOrder = null;
                                 try {
                                     dateOrder = dateOrderFormat.parse(fieldPreviousOrder[6]);
                                     String newDateString = outputOrderFormat.format(dateOrder);

                                     out.println("<div class=driver>\n" +
                                             "     <div class='driver-img' style=\"background-image: url(\'img/"+fieldPreviousOrder[7]+"\')\"></div>"+
                                             "        <div class=driver-history>" +
                                             "           <div class=horizontal-view>" +
                                             "                <div class=two-row-block style=\"width:70%\">" +
                                             "                    <div class=date>" + newDateString + "</div>" +
                                             "                    <div class=driver-name-history>" + fieldPreviousOrder[1] + "</div>" +
                                             "                </div>" +
                                             "<input type='hidden' name='idPreviousOrderTransaction' value="+fieldPreviousOrder[0]+" />"+
                                             "           <input type = 'submit' name='chooseHiddenDriver' onclick = 'return chooseHistoryDriver(" + fieldPreviousOrder[0] + ");' class='hide-button' value=" + "'HIDE'>" +
                                             "           </div>" +
                                             "           <div class=loc-history>" + fieldPreviousOrder[2] + " - " + fieldPreviousOrder[3] +  "</div>\n" +
                                             "           <div class=driver-rating-history>\n" +
                                             "                                    You rated: <font color=orange> ");
                                     i = 0;
                                     while (i < Integer.parseInt(fieldPreviousOrder[4])) {
                                         out.print("&#9734");
                                         i = i + 1;
                                     }
                                     if (i == 0) {
                                         out.print("-");
                                     }
                                     out.println("                             </font> <br>" +
                                             "                                    You commented:" +
                                             "                                </div>" +
                                             "                                <div class=horizontal-view style=\\\"margin-left: 20px\\\">" +
                                             "                                    <div class=driver-comment>\n" + fieldPreviousOrder[5] + "</div>" +
                                             "                                </div></div></div> <br><br>");
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
