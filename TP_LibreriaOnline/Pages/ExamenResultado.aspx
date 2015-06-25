<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ExamenResultado.aspx.vb" Inherits="TP_LibreriaOnline.ExamenResultado" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Examen</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Examen
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Examen para Materia 1 - dd/mm/aaaa - Profesor: Horacio Martinez</h2>
    <br />
    <div class="main">
        <div class="detalle">
            <b>Pregunta 1:</b> ¿De que color era el caballo blanco de... ?
            <br />
            <b>Respuesta 1:</b> Azul
            <br />
        </div>
        <div class="detalle">
            <b>Pregunta 2:</b> ¿Cuantos elementos tiene...?
            <br />
            <b>Respuesta 2:</b> 25
            <br />
        </div>
        <br />
        <div class="detalle">
            <b>Nota:</b> 6
            <br />
            <b>Comentarios:</b> La pregunta 1 estaba incompleta.
            <br />
        </div>
        <br />
        <div class="detalle">
            <b>Motivo de la revisión:</b>
            <br />
            <asp:TextBox ID="TextBox1" runat="server" CssClass="respuesta"></asp:TextBox>
            <br />
        </div>
        <asp:Button ID="revision" runat="server" Text="Pedir revisión" CssClass="margenIzq400"/>
        <br />
        <br />
        <br />
        <div class="detalle"><b>Mensajes:</b> presione "Pedir revisión" para solicitar una revisión.</div>
    </div>

</asp:Content>
