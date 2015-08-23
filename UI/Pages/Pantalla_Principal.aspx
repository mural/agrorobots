<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Pantalla_Principal.aspx.vb" MasterPageFile="~/Site.Master" Inherits="Agorobots.Pantalla_Principal" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Agrorobots E-Learning</title>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h3>Bienvenido
            <asp:Label ID="userName" runat="server" Text=""></asp:Label>
    </h3>
    <br />
    <asp:Label ID="inconsistencias" runat="server" Text="Label"></asp:Label>
    <br />
    <br />
    <asp:Button ID="Button1" runat="server" Text="Recalcular Digitos"
        Visible="False" />
    <br />

</asp:Content>
