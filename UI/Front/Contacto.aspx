<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Contacto.aspx.vb" Inherits="Agorobots.Contacto" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navcontacto_3006" runat="server" Text="contacto"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="contacto_3006" runat="server" Text="contacto"></asp:Label>
            </h1>
            <br />
            <asp:Label ID="lblEmail_109" runat="server" Text="email"></asp:Label>
            <asp:TextBox ID="email" runat="server" placeholder="email@proveedor.com"
                onkeypress="return alfanumerico1(event)"
                onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
            </asp:TextBox>
            <asp:RequiredFieldValidator ID="vldEmail_109" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="email" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
            &nbsp;<asp:RegularExpressionValidator ID="regVldEmail_158" runat="server" ControlToValidate="email" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[_a-z0-9-]+(.[a-z0-9-]+)@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$" CssClass="formError" Display="Dynamic" EnableClientScript="False"></asp:RegularExpressionValidator>
            <br />
            <br />
            <asp:Label ID="mensajeEnviar_700" runat="server" Text="mensajeEnviar"></asp:Label>
            <br />
            <asp:TextBox ID="txtMensaje_701" runat="server" Rows="3" MaxLength="50" CssClass="entradaTexto"
                onkeypress="return alfanumerico1(event)"
                onCopy="return false" onDrag="return false" onDrop="return false" onPaste="return false"
                onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
            </asp:TextBox>
            <asp:RequiredFieldValidator ID="vldMensaje_701" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtMensaje_701" CssClass="formError" EnableClientScript="False"></asp:RequiredFieldValidator>
            *&nbsp;
            <asp:Button ID="btnEnviar_135" runat="server" Text="enviar" CssClass="w3-btn w3-khaki" />
            <br />
            <br />
            <asp:Label ID="lblMensajes" runat="server" CssClass="formError" Text=""></asp:Label>
        </div>
    </div>
</asp:Content>
