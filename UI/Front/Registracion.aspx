<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Registracion.aspx.vb" Inherits="Agorobots.Registracion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Registracion Agrorobots E-Learning</title>
    <link rel="stylesheet" type="text/css" href="../Styles/Login.css" media="all" />
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
    <a class="hiddenanchor" id="toregister"></a>
    <a class="hiddenanchor" id="tologin"></a>
    <form id="loginform" runat="server">
        <div id="wrapper" style="min-height: 970px">
            <div id="login" class="animate form">
                <h1>Registro</h1>
                <p>
                    <label for="nombreNuevo" class="uname" data-icon="u"></label>
                    <asp:Label ID="nombreNuevo_22" runat="server" Text="apellido"></asp:Label>
                    <asp:TextBox ID="nombreNuevo" runat="server" placeholder="apellido" required="required"></asp:TextBox>
                </p>
                <p>
                    <label for="apellidoNuevo" class="uname" data-icon="u"></label>
                    <asp:Label ID="apellidoNuevo_21" runat="server" Text="nombre"></asp:Label>
                    <asp:TextBox ID="apellidoNuevo" runat="server" placeholder="nombre" required="required"></asp:TextBox>
                </p>
                <p>
                    <label for="usuarioNuevo" class="uname" data-icon="u"></label>
                    <asp:Label ID="lblUsername_23" runat="server" Text="apellido"></asp:Label>
                    <asp:TextBox ID="usuarioNuevo" runat="server" placeholder="miusuario" required="required"></asp:TextBox>
                </p>
                <p>
                    <label for="emailNuevo" class="youmail" data-icon="e"></label>
                    <asp:Label ID="lblEmail_109" runat="server" Text="email"></asp:Label>
                    <asp:TextBox ID="emailNuevo" runat="server" placeholder="email@proveedor.com" required="required"></asp:TextBox>
                </p>
                <p>
                    <label for="passwordNuevo" class="youpasswd" data-icon="p"></label>
                    <asp:Label ID="lblPassword_27" runat="server" Text="pass"></asp:Label>
                    <asp:TextBox ID="passwordNuevo" runat="server" TextMode="Password" placeholder="cL4v3_!" required="required"></asp:TextBox>
                </p>
                <p>
                    <label for="passwordRepetidoNuevo" class="youpasswd" data-icon="p"></label>
                    <asp:Label ID="lblConfirmPassword_28" runat="server" Text="pass"></asp:Label>
                    <asp:TextBox ID="passwordRepetidoNuevo" runat="server" TextMode="Password" placeholder="cL4v3_!" required="required"></asp:TextBox>
                </p>
                <p class="signin button">
                    <asp:Button ID="btnRegistrar_480" runat="server" Text="registarse" />
                </p>
                <p class="change_link">
                    <asp:LinkButton ID="testEmail" runat="server" CssClass="to_register">Reenviar Email</asp:LinkButton>
                    Ya es usuario ?
									<a href="../Pantalla_Login.aspx" class="to_register">Ingresar</a>
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
