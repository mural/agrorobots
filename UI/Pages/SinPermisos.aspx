<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="SinPermisos.aspx.vb" Inherits="Agorobots.SinPermisos" %>

<asp:Content ID="Navegacion" runat="server" ContentPlaceHolderID="NavegacionContenido">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navError_10001" runat="server" Text="titulo"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h2>
                <asp:Label ID="lblTitulo_10001" runat="server" Text="titulo"></asp:Label>
            </h2>
            <p>
                <asp:Label ID="msgError_90050" runat="server" Text="titulo"></asp:Label>
            </p>
        </div>
    </div>
</asp:Content>
