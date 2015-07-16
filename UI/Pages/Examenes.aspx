<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Examenes.aspx.vb" Inherits="Agorobots.Examenes" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Examenes</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Examenes
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Listado de examenes
        </h2>
    <br />
    <div class="main">
        <div class="linkTitle">
            <a href="ExamenResultado.aspx">
                Examen 1 <asp:Label ID="alumno1" runat="server" Text=""></asp:Label><img alt="go" src="../Imagenes/arrow.png"/>
            </a>
        </div>
        <div class="linkTitle">
            <a href="ExamenResultado.aspx">
                Examen 2 <asp:Label ID="alumno2" runat="server" Text=""></asp:Label><img alt="go" src="../Imagenes/arrow.png"/>
             </a>
        </div>
        <br />
        <br />
    </div>

</asp:Content>
