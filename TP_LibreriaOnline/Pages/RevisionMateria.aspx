<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"  CodeBehind="RevisionMateria.aspx.vb" Inherits="TP_LibreriaOnline.RevisionMateria" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Revision de Materia</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Revision de materia
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Materia 1 - Profesor: Horacio Martinez</h2>
    <br />
    <div class="main">
        <div class="detalle">
            <b>Temas:</b> Temas de la materia...
        </div>
        <div class="detalle">
            <b>Duración:</b> 3 meses.
        </div>
        <div class="detalle">
            <b>Criterios de aprobación:</b> Aprobar con una nota de ...
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
        <asp:Button ID="iniciar" runat="server" Text="Aceptar" CssClass="margenIzq400 botonAccion"/>
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
        <div class="detalle"><b>Mensajes:</b> presione &quot;Aceptar&quot; para agregar o "Revisar" para solicitar una revisión.</div>
    </div>

</asp:Content>


