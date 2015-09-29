<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.Master" CodeBehind="RecuperarClave.aspx.vb" Inherits="Agorobots.RecuperarClave" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navRecuperarclave_491" runat="server" Text="recuperar clave"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="recuperarclave_491" runat="server" Text="recuperar clave"></asp:Label></h1>
            <p>
                <label for="usuarioRecuperar" class="uname" data-icon="u"></label>
                <asp:Label ID="lblUsername_23" runat="server" Text="apellido"></asp:Label>
                <asp:TextBox ID="usuarioRecuperar" runat="server" placeholder="miusuario"
                    onkeypress="return alfanumerico1(event)"
                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="vldUser_23" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="usuarioRecuperar" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
            </p>
            <p>
                <label for="emailRecuperar" class="youmail" data-icon="e"></label>
                <asp:Label ID="lblEmail_109" runat="server" Text="email"></asp:Label>
                <asp:TextBox ID="emailRecuperar" runat="server" placeholder="email@proveedor.com"
                    onkeypress="return alfanumerico1(event)"
                    onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                    onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="vldEmail_109" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="emailRecuperar" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
                &nbsp;<asp:RegularExpressionValidator ID="regVldEmail" runat="server" ControlToValidate="emailRecuperar" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[_a-z0-9-]+(.[a-z0-9-]+)@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$" CssClass="formError" Display="Dynamic" EnableClientScript="False"></asp:RegularExpressionValidator>
            </p>
            <p class="signin button">
                <asp:Button ID="btnRecuperar_490" runat="server" Text="recuperar" />
            </p>
            <p class="change_link">
                <asp:Label ID="yaesusuario_61" runat="server" Text="ya es usuario?"></asp:Label>
                <a href="../Pantalla_Login.aspx" class="to_register">
                    <asp:Label ID="login_500" runat="server" Text="login"></asp:Label>
                </a>
            </p>
            <p class="resultadoCuenta">
                <asp:Label ID="Resultado" runat="server" ></asp:Label>
            </p>
        </div>
    </div>
</asp:Content>
