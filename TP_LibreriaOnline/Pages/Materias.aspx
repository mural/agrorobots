<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Materias.aspx.vb" Inherits="TP_LibreriaOnline.Carreras" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Materias</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Materias
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Listado de materias
        </h2>
    <br />
    <div class="main">
        <div class="linkTitle"><a href="MateriasDetalle.aspx">Materia 1 <img alt="go" src="../Imagenes/arrow.png"/></a></div>
        <div class="linkTitle"><a href="MateriasDetalle.aspx">Materia 2 <img alt="go" src="../Imagenes/arrow.png"/></a></div>
        <div class="linkTitle"><a href="MateriasDetalle.aspx">Materia 3 <img alt="go" src="../Imagenes/arrow.png"/></a></div>
        <br />
        <br />
    </div>

</asp:Content>
