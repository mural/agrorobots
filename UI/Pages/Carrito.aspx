<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Carrito.aspx.vb" Inherits="Agorobots.Carrito" %>


<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navCarrito" runat="server" Text="carrito"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="carrito" runat="server" Text="carrito"></asp:Label>
            </h1>
            _detalle de todos los items... (dejo eliminar) 
            <br />
            si esta todo bien mando >>>> a INSCRIPCION (donde solo valida el pago)
            <br />
            <br />
            (validar materias q no se superpongan, DIAS de cursada con HORARIOS)  
            <br />
            <br />ver webcam max.
        </div>
    </div>
</asp:Content>