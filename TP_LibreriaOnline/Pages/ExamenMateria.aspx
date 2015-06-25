<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ExamenMateria.aspx.vb" Inherits="TP_LibreriaOnline.ExamenMateria" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Examen</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Examen
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Detalle Examen para Materia 1</h2>
    <br />
    <div class="main">
        <div class="detalle"><b>Procedimiento del examen:</b> Consiste en preguntas a completar, donde debe...</div>
        <div class="detalle"><b>Tiempo limite de examen:</b> 120 minutos</div>
        <div class="detalle"><b>Profesor:</b> Horacio Martinez</div>
        <br />
        <br />
        <asp:Button ID="rendir" runat="server" OnClick="rendirExamen" Text="Rendir examen" CssClass="margenIzq400"/>
        <br />
        <br />
        <div class="detalle"><b>Mensajes:</b> presione "Rendir examen" para comenzar.</div>
    </div>

</asp:Content>