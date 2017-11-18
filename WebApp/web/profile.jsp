<%@ page import="ojeksoap.controller.UsersImplService" %>
<%@ page import="ojeksoap.controller.Users" %>
<%@ page import="ojeksoap.controller.LocationImplService" %>
<%@ page import="ojeksoap.controller.Location" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PROFILE</title>
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

        <%
            UsersImplService usersImplService = new UsersImplService();
            Users users = usersImplService.getUsersImplPort();
            String result = users.getUserByUsername(username);
            String[] profile = result.split("%");

            if(profile[3].equals("1")){
                profile[3] = "Driver ";
                result = users.getUserRatingAndVotes(username);
                String[] ratings = result.split("%");
                profile[3] += "| " + ratings[1] + " " + ratings[2] + " votes";
            } else {
                profile[3] = "Non - Driver";
            }

            LocationImplService locationImplService = new LocationImplService();
            Location location = locationImplService.getLocationImplPort();
            result = location.getPreferredLocation(access_token, username);
            if (result.equals("FORBIDDEN ACCESS")) {
                result = "";
            }
            String[] userLocation = result.split("%");
        %>

        <div class=horizontal-view style="display: inline-block;width: 90%">
            <h1>MY PROFILE</h1>
        </div>
        <a href="editProfile.jsp">
            <h1 style="display: inline-block; text-align: right; color: orange">&#x270e</h1>
        </a>
        <div class=horizontal-view style="text-align: center;">
            <%--<div class=profile-img style="background-image: url("<%= profile[4] %>")"></div>--%>
            <div class="profile-img" style="background-image: url('<%= "img/" + profile[4]  %>');"></div>
        <div class=horizontal-view style="text-align: center">
            <h3 class="profile-username">@<%= profile[0] %></h3>
            <h3 class="profile-name"><%= profile[1] %></h3>
            <h4 class="profile-driver"><%= profile[3] %></h4>
            <h4 class="profile-phone"><%= profile[2] %></h4>
        </div>

        <%
            if(profile[3].split(" ")[0].equals("Driver")){
                out.println("<div class=horizontal-view style=\"width: 90%; display: inline-block; text-align: left\"><h2>PREFERRED LOCATION</h2></div>" +
                "<a href=\"editLocation.jsp\"><h1 style=\"display: inline-block; text-align: right; color: orange\">&#x270e</h1>" +
                "</a><div class=\"preferred-locations\"><ul>");
                for(String s : userLocation){
                    out.println("<li>" + s + "</li>");
                }
                out.println("</ul></div></div>");
            }
        %>
        <%--<div class=horizontal-view style="width: 90%; display: inline-block; text-align: left"><h2>PREFERRED LOCATION</h2></div>
        <a href="editProfile.jsp">
            <h1 style="display: inline-block; text-align: right; color: orange">&#x270e</h1>
        </a>

        <div class="preferred-locations">
            <ul>
                <%
                    for(String s : userLocation){
                        out.println("<li>" + s + "</li>");
                    }
                %>
            </ul>
        </div>--%>

        </div>
</body>
</html>
