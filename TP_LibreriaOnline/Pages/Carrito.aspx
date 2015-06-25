<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Carrito.aspx.vb" Inherits="TP_LibreriaOnline.Carrito" MasterPageFile="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <h2>Compras</h2>
<p >
    <asp:Literal ID="ltlTabla" runat="server"></asp:Literal>
</p>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Comprar" />
</p>
        <p style="font-family:Tahoma; font-size:xx-large">
            <asp:Label ID="Label2" runat="server" Text="Label" Visible="False"></asp:Label>
        </p>
</asp:Content>