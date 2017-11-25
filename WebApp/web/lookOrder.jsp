<%@ page import="ojeksoap.controller.Location" %>
<%@ page import="ojeksoap.controller.LocationImplService" %><%--
  Created by IntelliJ IDEA.
  User: Kezia Suhendra
  Date: 11/21/17
  Time: 1:55 PM
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

    <div class=horizontal-view style="text-align:center;margin-top: 170px">
        <input type="submit" value="FIND ORDER" name="cancel-order" class="button-find" onclick="generateFCMToken()">
    </div>
</div>
<script src="https://www.gstatic.com/firebasejs/4.2.0/firebase.js"></script>
<script src="https://www.gstatic.com/firebasejs/4.2.0/firebase-messaging.js"></script>
<script>
    var config = {
        apiKey: "AIzaSyBqH78U1Zw2t7iXKZ3yX5U40ZtQnS98r44",
        authDomain: "mavericks-d5625.firebaseapp.com",
        databaseURL: "https://mavericks-d5625.firebaseio.com",
        projectId: "mavericks-d5625",
        storageBucket: "mavericks-d5625.appspot.com",
        messagingSenderId: "577101336097"
    };
    firebase.initializeApp(config);

    const messaging = firebase.messaging();
//     [START refresh_token]

//     Callback fired if Instance ID token is updated.
//        messaging.onTokenRefresh(function() {
//            messaging.getToken()
//                .then(function(refreshedToken) {
//                    console.log('Token refreshed.');
//                    // Indicate that the new Instance ID token has not yet been sent to the
//                    // app server.
//    //                setTokenSentToServer(false);
//                    // Send Instance ID token to app server.
//    //                sendTokenToServer(refreshedToken);
//                    // [START_EXCLUDE]
//                    // Display new Instance ID token and clear UI of all previous messages.
//                    resetUI();
//                    // [END_EXCLUDE]
//                })
//                .catch(function(err) {
//                    console.log('Unable to retrieve refreshed token ', err);
//    //                showToken('Unable to retrieve refreshed token ', err);
//                });
//        });

    function generateFCMToken() {
        // REQUEST PERMISSION
        console.log('Requesting permission...');
        // [START request_permission]
        messaging.requestPermission()
            .then(function() {
                console.log('Notification permission granted.');
                // TODO(developer): Retrieve an Instance ID token for use with FCM.
                // [START_EXCLUDE]
                // In many cases once an app has been granted notification permission, it
                // should update its UI reflecting this.
//                resetUI();
                messaging.getToken()
                    .then(function(currentToken) {
                        if (currentToken) {
                            //SEND DRIVER STATUS ONLINE TO CHAT SERVICE
                            <%
                                LocationImplService locationImplService = new LocationImplService();
                                Location location = locationImplService.getLocationImplPort();
                                String result = location.getPreferredLocation(access_token, username);
                                if (result.equals("FORBIDDEN ACCESS")) {
                                    result = "";
                                }
                                String[] userLocation = result.split("%");
                            %>


                            var listLocation = new Array();
                            <%
                                for(int i=0;i<userLocation.length;i++) {
                            %>
                                listLocation[<%=i%>] = '<%=userLocation[i]%>';
                            <%}%>
                            //                    updateUIForPushEnabled(currentToken);
//                            console.log(listLocationJson);
                            console.log('Instance ID token available.',currentToken);
                            var http = new XMLHttpRequest();
                            var url = "http://localhost:3000/changeDriverStatus";
                            var params = "name=<%=username%>";
                            params +="&token=+"+currentToken;
                            var j;
                            for(j = 0; j<listLocation.length; j++){
                                params += "&location[" + j + "]=" + listLocation[j] + "&";
                            }
                            params += "&status=online";
                            http.open("POST", url, true);
                            //Send the proper header information along with the request
                            http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                            http.onreadystatechange = function() {//Call a function when the state changes.
                                if(http.readyState == 4 && http.status == 200) {
//                                    alert(http.responseText);
                                }
                            };
                            http.send(params);
                            // END
                        } else {
                            // Show permission request.
                            console.log('No Instance ID token available. Request permission to generate one.');
                            // Show permission UI.
                            //                    updateUIForPushPermissionRequired();
                            //                    setTokenSentToServer(false);
                        }
                    })
                    .catch(function(err) {
                        console.log('An error occurred while retrieving token. ', err);
//                            showToken('Error retrieving Instance ID token. ', err);
//                            setTokenSentToServer(false);
                    });
                // [END_EXCLUDE]
            })
            .catch(function(err) {
                console.log('Unable to get permission to notify.', err);
            });
        // END REQUEST PERMISSION
//
//        //RECEIVE MESSAGE
//        messaging.onMessage(function(payload) {
//            console.log("message received :",payload);
//            console.log(payload.data.score);
//        });
//        // END RECEIVE MESSAGE
    }
</script>
</body>
</html>
