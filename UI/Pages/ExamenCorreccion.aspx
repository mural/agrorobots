<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ExamenCorreccion.aspx.vb" Inherits="Agorobots.ExamenCorreccion" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Examen</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Correccion de Examen
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Examen para Materia 1 - dd/mm/aaaa - Alumno: Pablo Perez</h2>
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
            <b>Estado: </b>Corrección
            <br />
        </div>
        <div class="detalle">
            <b>Motivo de la revisión solicitada por el alumno:</b> -
        </div>
        <div class="detalle">
            <b>Evaluación de revisión por el director:</b> -
        </div>
        <div class="detalle">
            <b>Condiciones de aprobación:</b> Completar un 70% correcto. Las preguntas...
        </div>
        <br /> 
        <div class="detalle">
            <b>Nota:</b> <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
                <asp:ListItem Selected="True">6</asp:ListItem>
                <asp:ListItem>7</asp:ListItem>
                <asp:ListItem>8</asp:ListItem>
                <asp:ListItem>9</asp:ListItem>
                <asp:ListItem>10</asp:ListItem>
            </asp:DropDownList>
            <br />
            <b>Comentarios</b>
            <br />
            <asp:TextBox ID="TextBox2" runat="server" CssClass="respuesta"></asp:TextBox>
            <br />
        </div>
        <br />
        <asp:Button ID="corregir" runat="server" Text="Corregir" CssClass="margenIzq400"/>
        <br />
        <br />
        <div class="detalle"><b>Mensajes:</b> presione "Corregir" para finalizar.</div>
    </div>

</asp:Content>