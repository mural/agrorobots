<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Pantalla_Login.aspx.vb" Inherits="Agorobots.Principal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Agrorobots E-Learning</title>
    <link rel="stylesheet" type="text/css" href="Styles/Login.css" media="all"/>
    <script type="text/javascript">
        function validar() {
            if (TBX_Clave.toString() == "") {
                alert("No puede ser vacia la clave");
            }
            return false;
        }
    </script>
</head>
<body>
    <div id="wrapper">
        <div id="login" class="animate form">
            <form id="loginform" runat="server">
                <h1>Login</h1> 
                <p> 
                    <label for="username" class="uname" data-icon="u" > Usuario </label>
                    <asp:TextBox ID="username" runat="server" placeholder="miusuario" required="required"></asp:TextBox>
                </p>
                <p> 
                    <label for="password" class="youpasswd" data-icon="p"> Clave </label>
                    <asp:TextBox ID="password" runat="server" TextMode="Password" placeholder="cL4v3_!" required="required"></asp:TextBox>
                </p>
                <p class="keeplogin" style="display: none"> 
				    <input type="checkbox" name="loginkeeping" id="loginkeeping" value="loginkeeping" /> 
				    <label for="loginkeeping">Keep me logged in</label>
			    </p>
                <p class="login button"> 
                    <asp:Button ID="Submit" runat="server" Text="Ingresar" />
			    </p>
                <p class="change_link">
			        <asp:LinkButton ID="OlvidoClave" runat="server" CssClass="to_register">Olvido su clave ?</asp:LinkButton>
			    </p>
            </form>
        </div>
        <asp:Label ID="Resultado" runat="server"></asp:Label>
    </div>
        
    <p align="center" style="display: none">
        <asp:Label ID="Datos" runat="server"></asp:Label>
    </p>
</body>
</html>
