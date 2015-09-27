<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="SinPermisos.aspx.vb" Inherits="Agorobots.SinPermisos" %>

<asp:Content ID="Navegacion" runat="server" ContentPlaceHolderID="DetalleNavegacionContenido">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navError_10001" runat="server" Text="titulo"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
     <h2>
        <asp:Label ID="lblTitulo_10001" runat="server" Text="titulo"></asp:Label>
    </h2>
    <p>
        <asp:Label ID="msgError_90050" runat="server" Text="titulo"></asp:Label>
    </p>
</asp:Content>
