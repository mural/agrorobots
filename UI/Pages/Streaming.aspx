<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="Streaming.aspx.vb" Inherits="Agorobots.Streaming" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual_182" runat="server" Text="Streaming"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_182" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <asp:Label ID="fechaStreaming" runat="server" Text=" "></asp:Label>
    <br />
    <br />
    <iframe id="iStreaming" width="640" height="360" frameborder="0" allowfullscreen runat="server" ></iframe>
    <br />
    <br />
</asp:Content>
