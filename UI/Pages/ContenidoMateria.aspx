<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"  CodeBehind="ContenidoMateria.aspx.vb" Inherits="Agorobots.ContenidoMateria" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Contenido de Materia</title>
</asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Contenido de materia
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Materia 1</h2>
    <br />
    <div class="main">
        <div class="detalle">
            <b>Temas:</b>             
            <br />
            <asp:TextBox ID="TextBox3" runat="server" CssClass="completar"></asp:TextBox>
        </div>
        <div class="detalle">
            <b>Duración:</b> 
            <br />
            <asp:TextBox ID="TextBox4" runat="server" CssClass="completar"></asp:TextBox>
        </div>
        <div class="detalle linkTitle" >
            <b>Materias correlativas:</b> <a href="SeleccionMaterias.aspx">editar... <img alt="go" src="../Imagenes/arrow.png"/></a>
        </div>
        <div class="detalle">
            <b>Material de cursada:</b> 
            <br />
            <asp:TextBox ID="TextBox1" runat="server" CssClass="completar"></asp:TextBox>
        </div>
        <div class="detalle">
            <b>Criterios de aprobación:</b> 
            <br />
            <asp:TextBox ID="TextBox5" runat="server" CssClass="completar"></asp:TextBox>
        </div>
        <div class="detalle">
            <b>Estado:</b> sin contenido
        </div>
        <asp:Button ID="revisar" runat="server" Text="Finalizar" CssClass="margenIzq400 botonAccion"/>
        <br />
        <br />
        <div class="detalle"><b>Mensajes:</b> presione "Finalizar" para enviar el contenido.</div>
    </div>

</asp:Content>
