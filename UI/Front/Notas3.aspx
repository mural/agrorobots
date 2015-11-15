<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Notas3.aspx.vb" Inherits="Agorobots.Notas3" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadNavegacionContenido" runat="server">
    <script type="text/javascript">
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navventajas_94" runat="server" Text="nota"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="ventajas_94" runat="server" Text="nota"></asp:Label>
            </h1>
            <p>
                <img src="/Imagenes/home_4_200x140.jpg" class="fl_left imagenSeparada" />
            </p>
            <asp:Label ID="n3_99009" runat="server" Text="detalle"></asp:Label>
            <br />
            <p>
                <img src="/Imagenes/ventajas.jpg" />
            </p>
            <br />
        </div>
    </div>
</asp:Content>
