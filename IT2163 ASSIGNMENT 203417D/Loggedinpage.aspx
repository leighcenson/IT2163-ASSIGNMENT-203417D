<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Loggedinpage.aspx.cs" Inherits="IT2163_ASSIGNMENT_203417D.Loggedinpage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="refresh" content="61" />

</head>
<body>
<form id="forni" runat="server">
<div>
<fieldset>
<legend>Logged in page</legend>
<br>
<asp:Label ID="lblMessage" runat="server" EnableViewState="false" />
<br />
<br />
<asp:Button ID="btnLogout" runat="server" Text="Logout" onclick="LogoutMe" Visible="false" />
<p/>
</fieldset>
</div>
</form>
</body>
</html>
