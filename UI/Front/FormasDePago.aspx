<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="FormasDePago.aspx.vb" Inherits="Agorobots.FormasDePago" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadNavegacionContenido" runat="server">
    <script type="text/javascript">
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navformaspago_59" runat="server" Text="formas de pago"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="formaspago_59" runat="server" Text="formas de pago"></asp:Label>
            </h1>
            <p>
                <img src="/Imagenes/pagos.jpg" class="fl_left imagenSeparada" />
            </p>
            <asp:Label ID="fp_99006" runat="server" Text="detalle"></asp:Label>
            <br />
        </div>
    </div>
</asp:Content>


