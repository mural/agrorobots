<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="InscriptoCalificacion.aspx.vb" Inherits="Agorobots.InscriptoCalificacion" %>

<%@ Import Namespace="Agorobots" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href='<%= PaginasConocidas.CATALOGO%>'>
            <asp:Label ID="navCatalogo_50" runat="server" Text="catalogo"></asp:Label>
        </a>
    </li>
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="nav_101" runat="server" Text="gracias por su compra"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_101" runat="server" Text="gracias"></asp:Label></h2>
    <br />
    <div class='w3-card-4'>
        <header class='w3-container w3-blue'>
            <h2 class="w3-blue">
                <asp:Label ID="lblEncuesta_137" runat="server" Text="denos su opinion"></asp:Label>
            </h2>
        </header>
        <div class='w3-container'>
            <img class="imagenMediana imagenMasSeparada fl_right w3-circle" src="/Imagenes/curso_generico.jpg" />
            <br />
            <br />
            <asp:Panel ID="encuestaInicio" runat="server" Text="inicio"></asp:Panel>
            <br />
            <br />
            <asp:Panel ID="encuestaCierre" runat="server" Text="cierre"></asp:Panel>
            <br />
            <br />
        </div>
    </div>
    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
    <br />
</asp:Content>
