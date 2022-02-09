<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="IT2163_ASSIGNMENT_203417D.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <script src="https://www.google.com/recaptcha/api.js?render=6Lf_EF8eAAAAAOUcrJjobwfA6AtMa9KKvSQvnsF3"></script>
</head>
<body>
    <br /><br />
    <form runat="server">
    <fieldset>
        <legend>Login</legend>
        <p>Email: <asp:TextBox ID="login_email" runat="server" Height="25px" Width="137px" /></p><br />
        <p>Password: <asp:TextBox ID="login_password" TextMode="Password" runat="server" Height="24px" Width="137px"/></p><br />
        <p><asp:Button ID="login_btnSubmit" runat="server" Text="Login" OnClick="LoginMe" Height="27px" Width="133px" /></p>
        <br /><br />
        <asp:Label ID="errormsg" runat="server" EnableViewState="False"></asp:Label>
        <input type ="hidden" id="g-recaptcha-response" name="g-recaptcha-response" />

    </fieldset>
        </form>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6Lf_EF8eAAAAAOUcrJjobwfA6AtMa9KKvSQvnsF3', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</body>
</html>
