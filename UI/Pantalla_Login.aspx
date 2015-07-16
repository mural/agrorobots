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
    <form id="login" runat="server">
    <h1>Login</h1>
    <div>
    <fieldset id="inputs">
        <p class="text">Usuario</p>
        <asp:TextBox ID="TBX_NombreUsuario" runat="server" Width="397px"></asp:TextBox>
        <p class="text">Clave</p>
        <asp:TextBox ID="TBX_Clave" runat="server" TextMode="Password" Width="397px"></asp:TextBox>
    </fieldset>&nbsp;
    <fieldset id="actions">
        <asp:Button ID="Submit" runat="server" Text="Ingresar" Height="37px" Width="290px" />
        <br />
        <asp:Label ID="Resultado" runat="server"></asp:Label>
    </fieldset></div>
    <asp:Label ID="Datos" runat="server" Visible="false"></asp:Label>
    <p align="center">
        <asp:Button ID="OlvidoClave" runat="server" Text="Olvido su clave ?" CssClass="text" />
    </p>
    </form>
</body>
</html>
