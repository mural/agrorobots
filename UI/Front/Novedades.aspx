<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Novedades.aspx.vb" Inherits="Agorobots.Novedades" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navNovedades_3004" runat="server" Text="novedades"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="novedades_3004" runat="server" Text="novedades"></asp:Label>
            </h1>
            <p>
                <asp:DropDownList ID="comboTipos" runat="server" AutoPostBack="True"></asp:DropDownList>
            </p>
            <asp:Literal ID="contenidoNovedades" runat="server"></asp:Literal>
            
        </div>
    </div>
</asp:Content>
