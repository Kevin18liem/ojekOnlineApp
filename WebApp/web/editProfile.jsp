<%@ page import="ojeksoap.controller.UsersImplService" %>
<%@ page import="ojeksoap.controller.Users" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 11/3/2017
  Time: 3:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>EDIT PROFILE</title>
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

    UsersImplService usersImplService = new UsersImplService();
    Users users = usersImplService.getUsersImplPort();
    String results = users.getUserByUsername(username);
    String[] profile = results.split("%");

%>
    <div class=layout>
        <div class=horizontal-view>
            <h1>EDIT PROFILE INFORMATION</h1>
        </div>

        <form action="/edit" method="post" enctype="multipart/form-data">
            <%-- action untuk validasi edit profile--%>
            <div class=horizontal-view>
                <%--<div class=driver-img style="background-image: url('<?php echo $picture ?>')">
                </div>--%>
                <%-- gambar profile picture --%>
                <div class="horizontal-view file-uploader">
                    <h4>Update profile picture</h4>
                    <img class="driver-img" src="<%= "img/" + profile[4]  %>" />
                    <h4>
                        <input type="file" id="image" value="<%= profile[4] %>" name="image" />
                        <input type="hidden" id="path-name" value="<%= application.getRealPath("/") %>" name="path-name"/>
                        <input type="hidden" id="old-image-name" value="<%= profile[4] %>" name="old-image-name"/>
                    </h4>
                </div>
            </div>

            <div class="edit-form">
                <div class="edit-form-input">
                    <label class="edit-form-label">Your Name</label>
                    <input type="text" name="name" id="name"  value=<% out.println("\""+ profile[1] + "\""); %> />
                </div>
                <div class="edit-form-input">
                    <label class="edit-form-label">Phone</label>
                    <input type="text" name="phone" id="phone" value=<% out.println("\""+ profile[2] + "\""); %>/>
                </div>
                <div class="edit-form-input">
                    <label class="edit-form-label">Change to driver</label>
                    <label class="switch">
                        <input type="checkbox" <% if(profile[3].equals("1")){out.println("checked");} %> name="is-driver" id="is-driver"/>
                        <span class="slider"></span>
                    </label>
                </div>
            </div>

            <div class="horizontal-view">
                <div class=horizontal-view style="text-align:left;margin-top: 20px">
                    <div class="back-button">
                        <a href="http://localhost:8000/profile.jsp">
                            <div class="button" style="background-color: #cb0b01;border-radius: 10px;">BACK</div>
                        </a>
                    </div>
                    <div class="submit-button">
                        <input class="button" type="submit" style="background-color: yellowgreen;border-radius: 10px;" value = "SAVE" name="edit-profile">
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
