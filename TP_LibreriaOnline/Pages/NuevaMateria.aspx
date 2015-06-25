<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"  CodeBehind="NuevaMateria.aspx.vb" Inherits="TP_LibreriaOnline.NuevaMateria" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <title>Nueva materia</title>
    </asp:Content>
<asp:Content ID="TitleContent" runat="server" ContentPlaceHolderID="TitleContent">
     - Nueva materia
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Crear materia</h2>
    <br />
    <div class="main">
        <br />
        <div class="detalle">
            <b>Nombre:</b>
            <br />
            <asp:TextBox ID="TextBox1" runat="server" CssClass="completar"></asp:TextBox>
        </div>
        <div class="detalle">
            <b>Profesor:</b>
            <br />
            
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>Horacio Martinez</asp:ListItem>
                <asp:ListItem>Diego Solis</asp:ListItem>
            </asp:DropDownList>
            
            <br />
        </div>
        <br />
        <asp:Button ID="revision" runat="server" Text="Crear" CssClass="margenIzq400"/>
        <br />
        <br />
        <div class="detalle"><b>Mensajes:</b> presione "Crear" para efectuar el proceso.</div>
    </div>

</asp:Content>

