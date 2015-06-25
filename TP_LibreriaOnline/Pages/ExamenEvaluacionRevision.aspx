<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ExamenEvaluacionRevision.aspx.vb" Inherits="TP_LibreriaOnline.ExamenEvaluacionRevision" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Examen</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Evaluación de revisión de Examen
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Examen para Materia 1 - dd/mm/aaaa</h2>
    <h2>Profesor: Horacio Martinez - Alumno: Pablo Perez</h2>
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
            <b>Estado: </b>Revisado
            <br />
        </div>
        <div class="detalle">
            <b>Motivo de la revisión solicitada por el alumno:</b> La pregunta 1 del examen...
        </div>
        <div class="detalle">
            <b>Nota:</b> 3
        </div>
        <div class="detalle">
            <b>Comentario:</b> El caballo en realidad es...
        </div>
        <div class="detalle">
            <b>Condiciones de aprobación:</b> Completar un 70% correcto. Las preguntas...
        </div>
        <br /> 
        <div class="detalle">
            <b>Evaluación:</b> <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>Revision Aprobada</asp:ListItem>
                <asp:ListItem Value="2">Revision Rechazada</asp:ListItem>
            </asp:DropDownList>
            <br />
            <b>Detalle de la evaluación de revisión</b>
            <br />
            <asp:TextBox ID="TextBox2" runat="server" CssClass="respuesta"></asp:TextBox>
            <br />
        </div>
        <div class="detalle">
            <b>Sancionar alumno:</b>&nbsp;
            <asp:CheckBox ID="CheckBox1" runat="server" Text="Si" />
        </div>
        <br />
        <asp:Button ID="corregir" runat="server" Text="Enviar evaluación" CssClass="margenIzq400"/>
        <br />
        <br /> 
        <div class="detalle"><b>Mensajes:</b> presione "Enviar evaluación" para finalizar.</div>
    </div>

</asp:Content>
