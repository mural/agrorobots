<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Pago.aspx.vb" Inherits="TP_LibreriaOnline.Pago" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Pago</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Pago</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>carrera o materia - Alumno: Pablo Perez
        </h2>
    <br />
    <div class="main">
        <div class="detalle"><b>Estado del alumno:</b> Espera de pago</div>
        <br />
        <asp:Button ID="confirmar" runat="server" Text="Confirmar pago" CssClass="margenIzq400"/>
        <br />
        <br />
        <div class="detalle"><b>Mensajes:</b> presione "Confirmar pago" para efectuar el proceso.</div>
    </div>

</asp:Content>