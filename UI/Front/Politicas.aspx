<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Politicas.aspx.vb" Inherits="Agorobots.Politicas" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navPoliticas_152" runat="server" Text="politicas"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="politicas_152" runat="server" Text="politicas"></asp:Label>
            </h1>
            <asp:Label ID="politicasDetalle_650" runat="server" Text="politicas detalle"></asp:Label>
        </div>
    </div>
</asp:Content>
