<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="RevisionCarrera.aspx.vb" Inherits="Agorobots.RevisionCarrera" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Revision de Carrera</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Revision de carrera
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Carrera 1 - Profesor: Horacio Martinez</h2>
    <br />
    <div class="main">
        <div class="detalle">
            <b>Temas:</b> Temas de la carrera...
        </div>
        <div class="detalle">
            <b>Duración:</b> 2 años.
        </div>
        <div class="detalle">
            <b>Materias:</b> materia 1 - materia 2 - materia 3 - materia 4
        </div>
        <div class="detalle">
            <b>Criterios de aprobación:</b> Finalizar las materias con 2 optativas...
        </div>
        <div class="detalle">
            <b>Estado:</b> con contenido
        </div>
        <div class="detalle">
            <b>Fecha inicio:</b>
            <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
        </div>
        <div class="detalle">
            <b>Vacantes:</b>
            <br />
            <asp:TextBox ID="TextBox1" runat="server" CssClass="completar"></asp:TextBox>
        </div>
        <asp:Button ID="iniciar" runat="server" Text="Iniciar" CssClass="margenIzq400 botonAccion"/>
        <br />
        <br />
        <div class="detalle">
            <b>Comentarios:</b>
            <br />
            <asp:TextBox ID="TextBox2" runat="server" CssClass="completar"></asp:TextBox>
        </div>
        <asp:Button ID="revisar" runat="server" Text="Revisar" CssClass="margenIzq400 botonAccion"/>
        <br />
        <br />
        <div class="detalle"><b>Mensajes:</b> presione "Iniciar" para abrir la carrera o "Revisar" para solicitar una revisión.</div>
    </div>

</asp:Content>

