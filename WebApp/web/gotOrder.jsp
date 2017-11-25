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
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
</head>
<body ng-app = "chatApp" ng-controller="chatController">
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
        <div class="chat-box" schroll-bottom="list">
            <div ng-repeat="item in list">
                <div ng-if="item.sender == driver_name">
                    <div class="talk-bubble-me" style="margin-left: 67%; text-align: left">
                        {{item.message}}
                    </div>
                </div>
                <div ng-if="item.sender == costumer_name">
                    <div class="talk-bubble-you" style="margin-right: 67%; text-align: left">
                        {{item.message}}
                    </div>
                </div>
            </div>
        </div>
        <div class="input-box">
            <div class=horizontal-view style="display: inline-block;width: 100%;margin: 6px">
                <form ng-submit="send()">
                    <input type="text" ng-model="input" placeholder="Type Your Message Here" size="50" style="border-color: transparent; border: none; font-size: medium">
                    <input type="submit" value="KIRIM" name="next-page" class="button-send" style="margin-left: 15px">
                </form>
            </div>
        </div>
    </div>

</div>
<script src="https://www.gstatic.com/firebasejs/4.2.0/firebase.js"></script>
<script src="https://www.gstatic.com/firebasejs/4.2.0/firebase-messaging.js"></script>
<script>
    var app = angular.module('chatApp', []);
        app.controller('chatController', function($scope, $http){
        $scope.driver_name = 'driver';
        $scope.costumer_name = 'costumer';

        var data = {sender:$scope.driver_name, receiver:$scope.costumer_name};
        $http({
            method: 'POST',
            url: 'http://localhost:3000/findCertainChat',
            data: data
        }).then(function successCallback(response) {
            //RECEIVE MESSAGE
            messaging.onMessage(function(payload) {
                console.log("message received :",payload);
                console.log(payload.data.score);
            });
            // END RECEIVE MESSAGE
            $scope.list = response.data;

        }, function errorCallback(response) {
            // called asynchronously if an error occurs
            // or server returns response with an error status.
        });

        $scope.send= function(){
            generateFCMToken();
            messaging.getToken()
                .then(function(currentToken) {
                        if (currentToken) {
                            console.log('Instance ID token available.',currentToken);
                            if($scope.input!=""){
                                var tokenCustomer = "eH1VjRihORg:APA91bF99ZOuk-i0YoOCgOhxFQXjbaBBic0BqvTDG6g1okVHj5AZjlc7clmuXpNnKph07HZM-CAtaLXbPs1IKXYfU87_fuzhx0YT7PaZrNniwWEcHcTnDVk-yuPmQVQjJadct0o6xakn";
                                $scope.list.push({sender:$scope.driver_name, receiver:$scope.costumer_name,message:$scope.input});
                                var temp = {sender:$scope.driver_name, receiver:$scope.costumer_name,message:$scope.input,fcmToken:tokenCustomer};
                                $http({
                                    method: 'POST',
                                    url: 'http://localhost:3000/sendChat',
                                    data: temp
                                }).then(function successCallback(response) {

                                }, function errorCallback(response) {
                                    // called asynchronously if an error occurs
                                    // or server returns response with an error status.
                                });
                                $scope.input="";
                            }
                        } else {
                            console.log('No Instance ID token available. Request permission to generate one.');
                        }
                    })
                    .catch(function(err) {
                        console.log('An error occurred while retrieving token. ', err);
                    });
        }
    });
    app.directive('schrollBottom', function () {
        return {
            scope: {
                schrollBottom: "="
            },
            link: function (scope, $element) {
                scope.$watchCollection('schrollBottom', function (newValue) {
                    if (newValue)
                    {
                        $element[0].scrollTop = $element[0].scrollHeight;
                    }
                });
            }
        }
    });
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
//                messaging.getToken()
//                    .then(function(currentToken) {
//                        if (currentToken) {
//                            console.log('Instance ID token available.',currentToken);
//                            return currentToken;
//                        } else {
//                            console.log('No Instance ID token available. Request permission to generate one.');
//                        }
//                    })
//                    .catch(function(err) {
//                        console.log('An error occurred while retrieving token. ', err);
//                    });

                // [END_EXCLUDE]
            })
            .catch(function(err) {
                console.log('Unable to get permission to notify.', err);
            });
        // END REQUEST PERMISSION
    }


</script>
</body>
</html>

