<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Carreras.aspx.vb" Inherits="TP_LibreriaOnline.Carreras" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Carreras</title>
    <style type="text/css">
        .auto-style1 {
            width: 22px;
            height: 16px;
        }
    </style>
</asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Carreras
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Listado de carreras
        </h2>
    <br />
    <div class="main">
        <div class="linkTitle"><a href="CarrerasDetalle.aspx">Carrera 1 <img alt="go" src="../Imagenes/arrow.png"/></a></div>
        <div class="linkTitle"><a href="CarrerasDetalle.aspx">Carrera 2 <img alt="go" src="../Imagenes/arrow.png"/></a></div>
        <div class="linkTitle"><a href="CarrerasDetalle.aspx">Carrera 3 <img alt="go" src="../Imagenes/arrow.png"/></a></div>
    </div>

</asp:Content>
