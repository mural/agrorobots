<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.Master" CodeBehind="Registracion.aspx.vb" Inherits="Agorobots.Registracion" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navRegistro_60" runat="server" Text="registro"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <%--<% Response.Write("Your current culture: " + System.Globalization.CultureInfo.CurrentCulture.DisplayName)%>--%>
    <div class="wrapper col4">
        <div id="container">
            <asp:Label ID="Resultado" runat="server" CssClass="resultadoCuenta"></asp:Label>
            <h1>
                <asp:Label ID="registro_60" runat="server" Text="registro"></asp:Label></h1>
            <p>
                <label for="nombreNuevo" class="uname" data-icon="u"></label>
                <asp:Label ID="nombreNuevo_22" runat="server" Text="apellido"></asp:Label>
                <asp:TextBox ID="nombreNuevo" runat="server" placeholder="apellido"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vldNombre_22" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="nombreNuevo" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
            </p>
            <p>
                <label for="apellidoNuevo" class="uname" data-icon="u"></label>
                <asp:Label ID="apellidoNuevo_21" runat="server" Text="nombre"></asp:Label>
                <asp:TextBox ID="apellidoNuevo" runat="server" placeholder="nombre"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vldApellido_21" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="apellidoNuevo" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
            </p>
            <p>
                <label for="usuarioNuevo" class="uname" data-icon="u"></label>
                <asp:Label ID="lblUsername_23" runat="server" Text="apellido"></asp:Label>
                <asp:TextBox ID="usuarioNuevo" runat="server" placeholder="miusuario"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vldUsername_23" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="usuarioNuevo" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
                &nbsp;<asp:CustomValidator ID="cvldUser_23" runat="server" ControlToValidate="usuarioNuevo" CssClass="formError" ErrorMessage="CustomValidator" EnableClientScript="False"></asp:CustomValidator>
            </p>
            <p>
                <label for="emailNuevo" class="youmail" data-icon="e"></label>
                <asp:Label ID="lblEmail_109" runat="server" Text="email"></asp:Label>
                <asp:TextBox ID="emailNuevo" runat="server" placeholder="email@proveedor.com"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vldEmail_109" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="emailNuevo" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>

            </p>
            <p>
                <label for="passwordNuevo" class="youpasswd" data-icon="p"></label>
                <asp:Label ID="lblPassword_27" runat="server" Text="pass"></asp:Label>
                <asp:TextBox ID="passwordNuevo" runat="server" TextMode="Password" placeholder="cL4v3_!"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vldPass_27" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="passwordNuevo" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
                &nbsp;<asp:CustomValidator ID="cvldPass_27" runat="server" ControlToValidate="passwordNuevo" CssClass="formError" ErrorMessage="CustomValidator" EnableClientScript="False"></asp:CustomValidator>
            </p>
            <p>
                <label for="passwordRepetidoNuevo" class="youpasswd" data-icon="p"></label>
                <asp:Label ID="lblConfirmPassword_28" runat="server" Text="pass"></asp:Label>
                <asp:TextBox ID="passwordRepetidoNuevo" runat="server" TextMode="Password" placeholder="cL4v3_!"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vldConfirmPass_28" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="passwordRepetidoNuevo" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
                &nbsp;<asp:CompareValidator ID="vldPasswordMatch" runat="server" ControlToCompare="passwordNuevo" ControlToValidate="passwordRepetidoNuevo" ErrorMessage="CompareValidator" CssClass="formError" EnableClientScript="False"></asp:CompareValidator>
            </p>
            <p class="signin button">
                <asp:Button ID="btnRegistrar_480" runat="server" Text="registarse" />
            </p>
            <p class="change_link">
                <asp:Label ID="yaesusuario_61" runat="server" Text="ya es usuario?"></asp:Label>
                <a href="../Pantalla_Login.aspx" class="to_register">
                    <asp:Label ID="login_500" runat="server" Text="login"></asp:Label>
                </a>
            </p>
        </div>
    </div>
</asp:Content>
