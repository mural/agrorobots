<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="SeleccionMaterias.aspx.vb" Inherits="Agorobots.SeleccionMaterias" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Seleccion de Materias</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Seleccion de Materias
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Listado de materias
        </h2>
    <br />
    <div class="main">
        <div class="linkTitle">Materia 1 <asp:CheckBox ID="checkbox" runat="server"  Text=" " /></div>
        <div class="linkTitle">Materia 2 <asp:CheckBox ID="checkbox1" runat="server"  Text=" " /></div>
        <div class="linkTitle">Materia 3 <asp:CheckBox ID="checkbox2" runat="server"  Text=" " /></div>
        <br />
        <br />
        <asp:Button ID="revisar" runat="server" Text="Confirmar" CssClass="margenIzq400 botonAccion"/>
        <br />
    </div>

</asp:Content>
