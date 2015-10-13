<%@ Page Language="vb" ValidateRequest="False" AutoEventWireup="false" MasterPageFile="~/MenuBase.Master" CodeBehind="Inscripcion.aspx.vb" Inherits="Agorobots.Inscripcion" %>

<%@ Import Namespace="Agorobots" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadBaseContenido" runat="server">
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
    <h2></h2>
    <br />
    <div class='w3-card-4'>
        <header class='w3-container w3-blue'>
            <h2 class="w3-blue">
                <asp:Label ID="lblTitulo_124" runat="server" Text=""></asp:Label>
            </h2>
        </header>
        <div class='w3-container'>
            <img class="imagenMediana imagenMasSeparada fl_right w3-circle" src="/Imagenes/curso_generico.jpg" />
            <br />
            <asp:Label ID="nombre_11" runat="server" Text="nombre" CssClass="w3-text-blue w3-large"></asp:Label>
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
            <asp:RadioButtonList ID="formaDePagoList" runat="server" AutoPostBack="True">
                <asp:ListItem Selected="True">Efectivo</asp:ListItem>
                <asp:ListItem>Tarjeta</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            <asp:Panel ID="panelTarjeta" runat="server" Visible="False">
                <asp:Label ID="numeroTarjeta_126" runat="server" Text="numero" CssClass="w3-text-blue w3-large"></asp:Label>
                &nbsp;<asp:TextBox ID="numeroTarjeta" runat="server" Text="" MaxLength="22"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="nombreTarjeta_127" runat="server" Text="nombre" CssClass="w3-text-blue w3-large"></asp:Label>
                &nbsp;<asp:TextBox ID="nombreTarjeta" runat="server" Text="" MaxLength="50"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="fechaVtoTarjeta_128" runat="server" Text="fecha vto" CssClass="w3-text-blue w3-large"></asp:Label>
                &nbsp;<asp:TextBox ID="fechaVtoTarjeta" runat="server" Text="" Placeholder="mm/YY" MaxLength="5"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="codigoTarjeta_129" runat="server" Text="cod." CssClass="w3-text-blue w3-large"></asp:Label>
                &nbsp;<asp:TextBox ID="codigoTarjeta" runat="server" Text="" MaxLength="4"></asp:TextBox>
                <br />
            </asp:Panel>
            <div class="card-wrapper"></div>
            <input type="text" name="number">
            <input type="text" name="name" />
            <input type="text" name="expiry" />
            <input type="text" name="cvc" />
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
    <!-- at the end of BODY -->
    <script src="https://rawgit.com/jessepollak/card/master/lib/js/card.js?v=beta1"></script>
    <script type="text/javascript" >
        var card = new Card({
            // a selector or DOM element for the form where users will
            // be entering their information
            form: 'formBase', // *required*
            // a selector or DOM element for the container
            // where you want the card to appear
            container: '.card-wrapper', // *required*
            debug: true // optional - default false
        });
    </script>
</asp:Content>
