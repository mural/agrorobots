<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Alumnos.aspx.vb" Inherits="TP_LibreriaOnline.Alumnos" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Alumnos</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - alumnos
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Listado de alumnos
        </h2>
    <br />
    <div class="main">
        <div class="linkTitle">
            <a href="CarrerasMaterias.aspx">
                Pablo Perez<img alt="go" src="../Imagenes/arrow.png"/>
            </a>
        </div>
        <div class="linkTitle">
            <a href="CarrerasMaterias.aspx">
                Manuel Garcia<img alt="go" src="../Imagenes/arrow.png"/>
             </a>
        </div>
        <br />
        <br />
    </div>

</asp:Content>