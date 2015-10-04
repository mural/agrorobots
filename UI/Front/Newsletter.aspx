<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Newsletter.aspx.vb" Inherits="Agorobots.Newsletter" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navNewsletter_42" runat="server" Text="newsletter"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="newsletter_42" runat="server" Text="newsletter"></asp:Label>
            </h1>
            <asp:Label ID="lblEmail_109" runat="server" Text="email"></asp:Label>
            <asp:TextBox ID="email" runat="server" placeholder="email@proveedor.com"
                onkeypress="return alfanumerico1(event)"
                onkeydown="alfanumerico2(this)" onkeyup="alfanumerico2(this)">
            </asp:TextBox>
            <asp:RequiredFieldValidator ID="vldEmail_109" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="email" CssClass="formError" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
            &nbsp;<asp:RegularExpressionValidator ID="regVldEmail_158" runat="server" ControlToValidate="email" ErrorMessage="RegularExpressionValidator" ValidationExpression="^[_a-z0-9-]+(.[a-z0-9-]+)@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$" CssClass="formError" Display="Dynamic" EnableClientScript="False"></asp:RegularExpressionValidator>
            <br />
            <br />
            <asp:Label ID="seleccionTemas_45" runat="server" Text="selecciones los temas de interes"></asp:Label>
            <br />
            <asp:ListBox ID="lstbTemas" runat="server" Rows="4" SelectionMode="Multiple"></asp:ListBox>
            <br />
            <br />
            <asp:Button ID="btnSuscribirse_43" runat="server" Text="suscribirse" CssClass="w3-btn w3-khaki" />
            &nbsp;
            <asp:Button ID="btnSuscribirse_44" runat="server" Text="des-suscribirse" CssClass="w3-btn w3-khaki" />
            <br />
            <br />
            <asp:Label ID="lblMensajes" runat="server" CssClass="formError" Text=""></asp:Label>
        </div>
    </div>
</asp:Content>

