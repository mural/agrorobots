<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="CarrerasDetalle.aspx.vb" Inherits="Agorobots.CarrerasDetalle" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Carreras</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Carreras
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2><asp:Label ID="lblTitulo" runat="server" Text=""></asp:Label></h2>
    <br />
    <div class="main">
        <div class="detalle"><b>Descripción:</b> Esta carrera consiste en algo muy interesante.</div>
        <div class="detalle"><b>Fecha inicio:</b> 12/07/2015</div>
        <div class="detalle"><b>Duración:</b> 3 años</div>
        <br />
        <br />
        <asp:Button ID="inscribirse" runat="server" Text="Inscribirse" CssClass="margenIzq400"/>
        <br />
        <br />
        <div class="detalle"><b>Mensajes:</b> presione "Inscribirse" para comenzar el proceso.</div>
    </div>

</asp:Content>
