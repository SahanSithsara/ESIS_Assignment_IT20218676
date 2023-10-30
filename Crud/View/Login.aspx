<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Crud.View.Login" %>




<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="./styleLogin.css">
    
	<title>Slide Navbar</title>
	<link rel="stylesheet" type="text/css" href="slide navbar styleLogin.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>



</head>
<body>




	<div class="main">  	
		<input type="checkbox" id="chk" aria-hidden="true">

			<div class="signup">
                
				<form>
					<label for="chk" aria-hidden="true">Sign up</label>
					<input type="text" name="txt" id="txtUserName" placeholder="First Name" >
					<input type="email" name="email" id="txtEmail" placeholder="Email" required="">
					<input type="password" name="pswd" id="txtPassword" placeholder="Password" required="">
					<button onclick="save_User();">Sign up</button>
                    <div class="row " style="margin: 0; margin-top: 10px;">
                            <div id="divMsg"></div>
                        </div>
				</form>
			</div>

			<div class="login">
				<form>
					<label for="chk" aria-hidden="true">Login</label>
					<input type="email" name="email" id="txtlogun" placeholder="Email" required="">
					<input type="password" name="pswd" id="txtpw" placeholder="Password" required="">
					<button onclick="get_User();" type="button">
         Login</button>
				</form>
                
			</div>
	</div>
</body>

	
	<script>



      function save_User(btnType) {
            var F_NAME = document.getElementById("txtUserName").value;
            var USERNAME = document.getElementById("txtEmail").value;
            var PASSWORD = document.getElementById("txtPassword").value;

            //var SLMCNO = $("#skillTypeId").val();
            
            $("#divMsg").empty();
            $("#divMsg").show();

           
            $.ajax({
                type: "POST",
                 url: "Login.aspx/SaveUser", //URL should be fully qualified
                 data: "{'F_NAME':'" + F_NAME + "','USERNAME':'" + USERNAME + "','PASSWORD':'" + PASSWORD + "'}",
                 dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var returnMsg = data.d;
                    if (returnMsg == "OK") {
                    

                     $("#divMsg").append('<div class="alert alert-success" style ="margin-bottom: 0"><strong>Success! </strong>Employee Successfully saved.</div>');
                     $("#divMsg").delay(3000).fadeOut(2000);
                     
                 }
                 else if (returnMsg == "Duplicate") {
                     $("#divMsg").append('<div class="alert alert-danger" style ="margin-bottom: 0"><strong>Duplicate! </strong>Employee type already exits.</div>');
                     $("#divMsg").delay(3000).fadeOut(2000);
                 }
                 else {
                     $("#divMsg").append('<div class="alert alert-danger" style ="margin-bottom: 0"><strong>Error! </strong>' + returnMsg + '.</div>');
                     $("#divMsg").delay(3000).fadeOut(2000);
                 }
             },
             error: function (a) { alert(a.responseText); }
         });
        }



        function get_User() {
            var txtlogun = document.getElementById("txtlogun").value;
            var txtpw = document.getElementById("txtpw").value;
            $.ajax({
                type: "POST",
                url: "Login.aspx/get_User",
                data: "{'txtlogun':'" + txtlogun + "','txtpw':'" + txtpw + "'}",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var returnMsg = data.d;
                    if (returnMsg == "OK") {
                        window.location.replace("../home/index.html");
                    } else {
                        alert('username or password incorrect!');

                    }
                },
                error: function (a) { alert(a.responseText); }
            });
        }


    </script>





</html>
