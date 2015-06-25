<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="CarrerasMaterias.aspx.vb" Inherits="TP_LibreriaOnline.CarrerasMaterias" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Alumnos</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - alumnos
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Listado de carreras y materias para Pablo Perez
        </h2>
    <br />
    <div class="main">
        <div class="linkTitle">
            <a href="Pago.aspx">
                Carrera 1<img alt="go" src="../Imagenes/arrow.png"/>
            </a>
        </div>
        <div class="linkTitle">
            <a href="Pago.aspx">
                Materia 1<img alt="go" src="../Imagenes/arrow.png"/>
             </a>
        </div>
        <div class="linkTitle">
            <a href="Pago.aspx">
                Materia 2<img alt="go" src="../Imagenes/arrow.png"/>
             </a>
        </div>
        <br />
        <br />
    </div>

</asp:Content>
