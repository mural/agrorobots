<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="DetalleExamen.aspx.vb" Inherits="TP_LibreriaOnline.DetalleExamen" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Examen</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Examen
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Examen para Materia 1 - dd/mm/aaaa - 88 minutos restantes</h2>
    <br />
    <div class="main">
        <div class="detalle"><b>Profesor:</b> Horacio Martinez</div>
        <br />
        <div class="detalle">
            <b>Pregunta 1:</b> ¿De que color era el caballo blanco de... ?
            <br />
            <asp:TextBox ID="TextBox1" runat="server" CssClass="respuesta"></asp:TextBox>
            <br />
        </div>
        <div class="detalle">
            <b>Pregunta 2:</b> ¿Cuantos elementos tiene...?
            <br />
            <br />
            <asp:RadioButton ID="RadioButton1" runat="server" Text="15" />
            <asp:RadioButton ID="RadioButton2" runat="server" Text="25" />
            <asp:RadioButton ID="RadioButton3" runat="server" Text="35" />
            <br />
        </div>
        <asp:Button ID="finalizar" runat="server" OnClick="finalizarExamen" Text="Finalizar" CssClass="margenIzq400"/>
        <br />
        <br />
        <br />
        <div class="detalle"><b>Mensajes:</b> presione "Finalizar" para entregar el examen.</div>
    </div>

</asp:Content>
