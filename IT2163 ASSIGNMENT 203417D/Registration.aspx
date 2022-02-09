<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="IT2163_ASSIGNMENT_203417D.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <style>
        body {
            text-align: center;
        }
    </style>
<head runat="server">
    <title>My Registration</title>
    <script type="text/javascript">
        function validate() {
			var str = document.getElementById('<%=tb_password.ClientID %>').value;
            var format = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/;

            if (str.length < 12) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password Length must be at Least 12 Characters.";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("too_short");
            }
            else if (str.search(/[0-9]/) == -1) {
				document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least one number";
				document.getElementById("lbl_pwdchecker").style.color = "Red";
				return ("no_number");
            }
			else if (str.search(/[!@#$%^&*()_+=-`~]/) == -1) {
				document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least one special character";
				document.getElementById("lbl_pwdchecker").style.color = "Red";
				return ("no_blah")
            }
			else if (str.search(/[A-Z]/) == -1) {
				document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least one upper case";
				document.getElementById("lbl_pwdchecker").style.color = "Red";
				return ("no_blergh")
            }
			else if (str.search(/[a-z]/) == -1) {
				document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least one lower case";
				document.getElementById("lbl_pwdchecker").style.color = "Red";
				return ("no_blurgh")
			}

            document.getElementById("lbl_pwdchecker").innerHTML = "Excellent！";
            document.getElementById("lbl_pwdchecker").style.color = "Blue";
            

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            &nbsp;Registration<br />
			<br />
			<br />
            First name&nbsp;&nbsp; <br />
            <asp:TextBox ID="fname" runat="server" ></asp:TextBox>			<br /><br />


            Last name&nbsp;&nbsp; <br />
           <asp:TextBox ID="lname" runat="server" ></asp:TextBox>			<br /><br />

            Email&nbsp;&nbsp; <br />
           <asp:TextBox ID="email" runat="server" ></asp:TextBox>			<br /><br />

            Credit Card Number&nbsp;&nbsp; <br />
            <asp:TextBox ID="cc_number" runat="server" ></asp:TextBox>			<br /><br />


            Credit Card Expiration Date&nbsp;&nbsp; <br />
            <asp:TextBox ID="cc_exp" runat="server" ></asp:TextBox>			<br /><br />


            Credit Card CVV&nbsp;&nbsp; <br />
            <asp:TextBox ID="cc_cvv" runat="server" ></asp:TextBox>			<br /><br />


			Password&nbsp;&nbsp; <asp:Label ID="lbl_pwdchecker" runat="server" Text="(pwdchecker)"></asp:Label>	<br />
            <asp:TextBox ID="tb_password" runat="server" onkeyup="javascript:validate()" TextMode="Password"></asp:TextBox>
            		<br /><br />


            Date of Birth&nbsp;&nbsp; <br />
            <asp:TextBox ID="dob" runat="server" ></asp:TextBox>			<br /><br />


            Photo&nbsp;&nbsp; <br />
            <asp:TextBox ID="photo" runat="server" ></asp:TextBox>			<br /><br />


			<br /><br /><asp:Button ID="button" runat="server" Text="Check password" OnClick="btn_checkPassword_Click" /> 
            <br /><asp:Button ID="button2" runat="server" Text="Submit" OnClick="btn_Submit_Click" />
            <br /> <asp:Label ID="lb_error1" runat="server" Text=""></asp:Label>

        </div>
    </form>
</body>
</html>
