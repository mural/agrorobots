<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="MateriasDetalle.aspx.vb" Inherits="Agorobots.Carreras" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Carreras</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Materias
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Detalle Materia 1</h2>
    <br />
    <div class="main">
        <div class="detalle"><b>Descripción:</b> Esta materia consiste en algo muy interesante.</div>
        <div class="detalle"><b>Profesor:</b> Horacio Martinez</div>
        <div class="detalle"><b>Fecha inicio:</b> 14/07/2015</div>
        <div class="detalle"><b>Fecha fin</b> 12/12/2015</div>
        <div class="detalle"><b>Materias correlativas:</b> materia 1 - materia 2</div>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Anotarse" CssClass="margenIzq400"/>
        <br />
        <br />
        <div class="detalle"><b>Mensajes:</b> presione "Anotarse" para comenzar el proceso.</div>
    </div>

</asp:Content>
