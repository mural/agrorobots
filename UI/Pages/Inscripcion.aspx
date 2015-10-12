<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="Inscripcion.aspx.vb" Inherits="Agorobots.Inscripcion" %>

<%@ Import Namespace="Agorobots" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
    <script>
        tinymce.init({
            plugins: "code",
            menubar: false,
            toolbar: "cut copy paste | searchreplace | bullist numlist | bold italic underline strikethrough | code",
            selector: 'textarea.editable'
        });
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="DetalleNavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href='<%= PaginasConocidas.CATALOGO%>'>
            <asp:Label ID="navCatalogo_50" runat="server" Text="catalogo"></asp:Label>
        </a>
    </li>
    <li>»</li>
    <li>
        <a id="nav_curso_link" href="#" runat="server">
            <asp:Label ID="nav_curso" runat="server" Text="..."></asp:Label>
        </a>
    </li>
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="nav_57" runat="server" Text="inscribir"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyMenuContenido" runat="server">
    <h2>
        <asp:Label ID="lblTitulo_57" runat="server" Text="titulo"></asp:Label>
    </h2>
    <br />
    <div class='w3-card-4'>
        <header class='w3-container w3-blue'>
            <h2 class="w3-blue">
                <asp:Label ID="lblTitulo" runat="server" Text=""></asp:Label>
            </h2>
        </header>
        <div class='w3-container'>
            <img class="imagenMediana imagenMasSeparada fl_right w3-circle" src="/Imagenes/curso_generico.jpg" />
            <br />
            <asp:Label ID="contenido_705" runat="server" Text="nombre" CssClass="w3-text-blue w3-large"></asp:Label>
            <asp:Label ID="lblNombre" runat="server" Text="nombre"></asp:Label>
            <br />
            <br />
            <asp:Label ID="precio_41" runat="server" Text="precio" CssClass="w3-text-blue w3-large"></asp:Label>
            $&nbsp;<asp:Label ID="lblPrecio" runat="server" Text="precio"></asp:Label>
            <br />
            <br />
            <asp:Label ID="formadePago_121" runat="server" Text="forma de pago" CssClass="w3-text-blue w3-large"></asp:Label>
            &nbsp;
            <br />
            <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                <asp:ListItem Selected="True">Efectivo</asp:ListItem>
                <asp:ListItem>Tarjeta</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            <br />
            <asp:Button ID="inscribirse_118" runat="server" Text="confirmar" CssClass="w3-btn w3-blue" />
            <br />
            <br />
        </div>
    </div>
    <br />
    <asp:Label ID="lblMensajes" runat="server" Text="" CssClass="formError"></asp:Label>
    <br />
    <br />
</asp:Content>
