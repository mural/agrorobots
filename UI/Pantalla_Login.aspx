<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.Master" CodeBehind="Pantalla_Login.aspx.vb" Inherits="Agorobots.Principal" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="login" runat="server" Text="Login"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>Login</h1>
            <asp:Panel ID="panel" runat="server" DefaultButton="Submit_500">
                <p>
                    <label for="login_username" class="uname" data-icon="u"></label>
                    <asp:Label ID="lblUsername_23" runat="server" Text="apellido"></asp:Label>
                    <asp:TextBox ID="login_username" runat="server" placeholder="miusuario" TabIndex="5" Text="admin" MaxLength="50" CssClass="entradaTexto"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="vldUser_23" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="login_username" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
                </p>
                <p>
                    <label for="login_password" class="youpasswd" data-icon="p"></label>
                    <asp:Label ID="lblPassword_27" runat="server" Text="pass"></asp:Label>
                    <asp:TextBox ID="login_password" runat="server" TextMode="Password" placeholder="cL4v3_!" TabIndex="6" MaxLength="50" CssClass="entradaTexto"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="vldUser_27" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="login_password" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
                </p>
                <p class="keeplogin" style="display: none">
                    <input type="checkbox" name="loginkeeping" id="loginkeeping" value="loginkeeping" />
                    <label for="loginkeeping">Keep me logged in</label>
                </p>
                <p class="login button">
                    <asp:Button ID="Submit_500" runat="server" Text="ingresar" TabIndex="1" CssClass="w3-btn w3-khaki"/>
                </p>
            </asp:Panel>
            <p class="change_link">
                <%--<asp:LinkButton ID="OlvidoClave" runat="server" CssClass="to_register">Olvido su clave ?</asp:LinkButton>--%>
                <a href="Cuenta/RecuperarClave.aspx" class="to_register">
                    <asp:Label ID="olvidoclave_72" runat="server" Text="olvido su clave?"></asp:Label>
                </a>
                &nbsp; ||| &nbsp;
                <a href="Cuenta/Registracion.aspx" class="to_register">
                    <asp:Label ID="registrar_480" runat="server" Text="registearse"></asp:Label>
                </a>
            </p>
            <p class="resultadoCuenta">
                <asp:Label ID="Resultado" runat="server"></asp:Label>
            </p>
        </div>
    </div>
</asp:Content>
