<%@ page import="ojeksoap.controller.LocationImplService" %>
<%@ page import="ojeksoap.controller.Location" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 11/3/2017
  Time: 4:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>EDIT LOCATION</title>
    <link rel="stylesheet" type="text/css" href="css/edit_preferred_location_style.css">
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
        LocationImplService locationImplService = new LocationImplService();
        Location location = locationImplService.getLocationImplPort();
        String editResult = "nul;";
        String addResult = "nul;";
        String deleteResult = "nul;";
        String resultLocation = "nul;";
    %>
    <div class=layout>
        <h1>EDIT PREFERRED LOCATIONS</h1>

        <table>
            <tr>
                <th width="7%">No</th>
                <th width="78%">Location</th>
                <th width="15%" colspan="2">Actions</th>
            </tr>
            <%
                resultLocation = location.getPreferredLocation(access_token, username);
                if (!resultLocation.equals("FORBIDDEN ACCESS")) {
                    String[] arrayResultlocation = resultLocation.split("\\%");

                    int i = 1;
                    while (i <= arrayResultlocation.length) {
                        out.println("<tr>" +
                                "<td>" + i + "</td>" +
                                "<td id=\"edit-location-" + i + "\">" + arrayResultlocation[i-1] + "</td>" +
                                "<td style=\"border-right : 0; border-bottom : 1; text-align : center;\">" +
                                "<button onclick=\"editLocations(" + i + ", '" + arrayResultlocation[i-1] + "')\" class=\"pencil\" style=\"background-color: Transparent; border: none; font-size: 25px;\"> &#9998; </button>" +
                                "</td>" +
                                "<td style=\"border-left : 0; border-bottom : 1; text-align : center;\">" +
                                "<form name=\"deleteForm\" action=\"\" method=\"post\">" +
                                "<input type=\"hidden\" name=\"location\" value=\"" + arrayResultlocation[i-1] + "\">" +
                                "<input type=\"submit\" name=\"next-page-delete\" value=\"&#10006;\" class= \"x_mark\" style=\"background-color: Transparent; border: none; font-size: 25px;\">" +
                                "</form>" +
                                "</td>" +
                                "</tr>");
                        i++;
                    }
                }

                if(request.getParameter("next-page-delete") != null) {
                    String newLocation = request.getParameter("location");
                    deleteResult = location.deletePreferredLocation(access_token, username ,newLocation);
                    if (!deleteResult.equals("FORBIDDEN ACCESS")) {
                        response.sendRedirect("editLocation.jsp");
                    }
                }
            %>
        </table>

        <div class=add_new_location>
            <h2 style="margin-top: 60px;">ADD NEW LOCATION:</h2>

                <form name="locationForm" action="" method="post" onsubmit="return validateForm()">
                    <input class="text_box" type= "text" name="location" size="42%">
                    <input class="add_button" type="submit" name="next-page-add" value="ADD">
                </form>

                <%
                    if(request.getParameter("next-page-add") != null) {
                        String newLocation = request.getParameter("location");
                        addResult = location.addPreferredLocation(access_token, username, newLocation);
                        if (!addResult.equals("FORBIDDEN ACCESS")) {
                            response.sendRedirect("editLocation.jsp");
                        }
                    }
                %>
        </div>

        <a href="http://localhost:8000/profile.jsp">
            <button class="back_button" type="submit">BACK</button>
        </a>
    </div>

    <script>
        function validateForm() {
            if(document.forms["locationForm"]["location"].value == "") {
                alert("preferred location must not be empty !");
                return false;
            }
        }

        function editLocations(i , oldLocations) {
            document.getElementById("edit-location-" + i).innerHTML =
                "<form name=\"editForm\" action=\"\" method=\"post\">" +
                "<input type=\"hidden\" name=\"oldLocation\" value=\"" + oldLocations + "\">" +
                "<input type=\"text\" name=\"newLocation\" placeholder=\"Edit : Input New Locations\" size = \"30\">" +
                "<input type=\"submit\" name=\"next-page-edit\">" +
                "</form>";
        }
    </script>

    <%
        if(request.getParameter("next-page-edit") != null) {
            String oldLocation = request.getParameter("oldLocation");
            String newLocation = request.getParameter("newLocation");
            editResult = location.editPreferredLocation(access_token, username,oldLocation,newLocation);
            if (!editResult.equals("FORBIDDEN ACCESS")) {
                response.sendRedirect("editLocation.jsp");
            }
        }

        if(editResult.equals("FORBIDEEN ACCESS") || resultLocation.equals("FORBIDDEN ACCESS") ||
                deleteResult.equals("FORBIDDEN ACCESS") || addResult.equals("FORBIDDEN ACCESS")){
            response.sendRedirect("index.jsp");
        }
    %>

</body>
</html>
