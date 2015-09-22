<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Cuenta/Cuenta.Master" CodeBehind="Pantalla_Login.aspx.vb" Inherits="Agorobots.Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <a class="hiddenanchor" id="toregister"></a>
    <a class="hiddenanchor" id="tologin"></a>

    <div id="wrapper">
        <div id="login" class="animate form">
            <h1>Login</h1>
            <p>
                <label for="username" class="uname" data-icon="u"></label>
                <asp:Label ID="lblUsername_23" runat="server" Text="apellido"></asp:Label>
                <asp:TextBox ID="username" runat="server" placeholder="miusuario"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vldUser_23" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="username" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
            </p>
            <p>
                <label for="password" class="youpasswd" data-icon="p"></label>
                <asp:Label ID="lblPassword_27" runat="server" Text="pass"></asp:Label>
                <asp:TextBox ID="password" runat="server" TextMode="Password" placeholder="cL4v3_!"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vldUser_27" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="password" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
            </p>
            <p class="keeplogin" style="display: none">
                <input type="checkbox" name="loginkeeping" id="loginkeeping" value="loginkeeping" />
                <label for="loginkeeping">Keep me logged in</label>
            </p>
            <p class="login button">
                <asp:Button ID="Submit_500" runat="server" Text="ingresar" />
            </p>
            <p class="change_link">
                <%--<asp:LinkButton ID="OlvidoClave" runat="server" CssClass="to_register">Olvido su clave ?</asp:LinkButton>--%>
                <a href="Cuenta/RecuperarClave.aspx" class="to_register">
                    <asp:Label ID="olvidoclave_72" runat="server" Text="olvido su clave?"></asp:Label>
                </a>
                <a href="Cuenta/Registracion.aspx" class="to_register">
                    <asp:Label ID="registrar_480" runat="server" Text="registearse"></asp:Label>
                </a>
            </p>
        </div>
    </div>
</asp:Content>
