<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Terminos.aspx.vb" Inherits="Agorobots.Terminos" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navTerminos_154" runat="server" Text="terminos"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="titleTerminos_154" runat="server" Text="terminos">
                </asp:Label>
            </h1>
            <img src="/Imagenes/terminos.png" alt="terminos">

            <asp:Label ID="terminosDetalle_99001" runat="server" Text="terminos detalle"></asp:Label>
        </div>
    </div>
</asp:Content>
