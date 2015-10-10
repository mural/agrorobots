<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.Master" CodeBehind="CarrerasDetalle.aspx.vb" Inherits="Agorobots.CarrerasDetalle" %>

<%@ Import Namespace="Agorobots" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href='<%= PaginasConocidas.CATALOGO%>'>
            <asp:Label ID="navCatalogo_50" runat="server" Text="catalogo"></asp:Label>
        </a>
    </li>
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navActual" runat="server" Text="..."></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="BodyNavegacionContenido">
    <div class="wrapper col4">
        <div id="container">
            <h2>
                <asp:Label ID="lblTitulo" runat="server" Text=""></asp:Label>

            </h2>
            <div class="detalle"><b>Descripción:</b> Esta carrera consiste en algo muy interesante.</div>
            <div class="detalle"><b>Fecha inicio:</b> 12/07/2015</div>
            <div class="detalle"><b>Duración:</b> 3 años</div>
            <br />
            <br />
            <asp:Button ID="inscribirse" runat="server" Text="Inscribirse" CssClass="margenIzq400" />
            <br />
            <br />
            <div class="detalle"><b>Mensajes:</b> presione "Inscribirse" para comenzar el proceso.</div>
        </div>
    </div>

</asp:Content>
