<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeginningPage.aspx.cs" Inherits="IT2163_ASSIGNMENT_203417D.BeginningPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <style>
        body {
            text-align: center;
        }
    </style>
<head runat="server">
    <title>Home</title>
</head>
<body>
    <br />
    <h1>203417D IT2163 Assignment</h1>
    <br /><br /><br />
   <button id="myButton" class="float-left submit-button" >Register</button><br /><br />
     <button id="myButton2" class="float-left submit-button" >Login</button>

<script type="text/javascript">
    document.getElementById("myButton").onclick = function () {
        location.href = "/Registration.aspx";
    };

    document.getElementById("myButton2").onclick = function () {
        location.href = "/Login.aspx";
    };
</script>


</body>
</html>
