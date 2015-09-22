<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Pantalla_Login.aspx.vb" Inherits="Agorobots.Principal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Agrorobots E-Learning</title>
    <link rel="stylesheet" type="text/css" href="Styles/Login.css" media="all" />
</head>
<body>
    <a class="hiddenanchor" id="toregister"></a>
    <a class="hiddenanchor" id="tologin"></a>
    <form id="loginform" runat="server">
        <div id="wrapper">
            <div id="login" class="animate form">
                <h1>Login</h1>
                <p>
                    <label for="username" class="uname" data-icon="u"> </label>
                    <asp:Label ID="lblUsername_23" runat="server" Text="apellido"></asp:Label>
                    <asp:TextBox ID="username" runat="server" placeholder="miusuario" required="required"></asp:TextBox>
                </p>
                <p>
                    <label for="password" class="youpasswd" data-icon="p"></label>
                    <asp:Label ID="lblPassword_27" runat="server" Text="pass"></asp:Label>
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
                    <%--<asp:LinkButton ID="OlvidoClave" runat="server" CssClass="to_register">Olvido su clave ?</asp:LinkButton>--%>
                    <a href="Front/RecuperarClave.aspx" class="to_register">
                        <asp:Label ID="olvidoclave_72" runat="server" Text="olvido su clave?"></asp:Label>
                    </a>
                    <a href="Front/Registracion.aspx" class="to_register">
                        <asp:Label ID="registrar_480" runat="server" Text="registearse"></asp:Label>
                    </a>
                </p>
            </div>
            <asp:Label ID="Resultado" runat="server"></asp:Label>
        </div>
    </form>

    <p align="center" style="display: none">
        <asp:Label ID="Datos" runat="server"></asp:Label>
    </p>
</body>
</html>
