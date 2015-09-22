<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Cuenta/Cuenta.Master" CodeBehind="RecuperarClave.aspx.vb" Inherits="Agorobots.RecuperarClave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <div id="wrapper">
            <div id="login" class="animate form">
                <h1><asp:Label ID="recuperarclave_491" runat="server" Text="recuperar clave"></asp:Label></h1>
                <p>
                    <label for="usuarioRecuperar" class="uname" data-icon="u"></label>
                    <asp:Label ID="lblUsername_23" runat="server" Text="apellido"></asp:Label>
                    <asp:TextBox ID="usuarioRecuperar" runat="server" placeholder="miusuario" required="required"></asp:TextBox>
                </p>
                <p>
                    <label for="emailRecuperar" class="youmail" data-icon="e"></label>
                    <asp:Label ID="lblEmail_109" runat="server" Text="email"></asp:Label>
                    <asp:TextBox ID="emailRecuperar" runat="server" placeholder="email@proveedor.com" required="required"></asp:TextBox>
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
            </div>
        </div>

    <p align="center" style="display: none">
        <asp:Label ID="Datos" runat="server"></asp:Label>
    </p>
</asp:Content>
