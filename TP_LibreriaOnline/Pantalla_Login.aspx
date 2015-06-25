<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Pantalla_Login.aspx.vb" Inherits="TP_LibreriaOnline.Principal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Libreria La Mesa Redonda</title>
    <link rel="stylesheet" type="text/css" href="Styles/Login.css" media="all"/>
    <script type="text/javascript">
        function btnSubmitClick() {
            if (TBX_NombreUsuario.toString() == "") {
                alert("Error");
            } else {
                alert("Ok");
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
        <p class="text">Contraseña</p>
        <asp:TextBox ID="TBX_Contraseña" runat="server" TextMode="Password" Width="397px"></asp:TextBox>
    </fieldset>&nbsp;
    <fieldset id="actions">
        <asp:Button ID="Submit" runat="server" Text="Ingresar" OnClientClick="javascript:validar();" Height="37px" Width="290px" />
        <br />
        <asp:Label ID="Resultado" runat="server"></asp:Label>
    </fieldset></div>
    <p align="center">
        <asp:Button ID="OlvidoClave" runat="server" Text="Olvido su clave ?" CssClass="text" />
    </p>
    </form>
</body>
</html>
