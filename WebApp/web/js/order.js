function choose(idDriver, username, customerName){
    document.getElementById('chosen-driver').value = idDriver;
    document.getElementById('driver-username').value = username;
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if(this.readyState == 4 && this.status == 200){
            var text = xhttp.responseText;
            document.cookie = "userDriver="+username;
        }
    };
    xhttp.open("POST", "http://localhost:3000/notifyDriver", true);
    xhttp.setRequestHeader("content-type","application/x-www-form-urlencoded");
    var params = "name="+username+"&token="+customerName;
    xhttp.send(params);
}