<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="SitiosAfiliados.aspx.vb" Inherits="Agorobots.SitiosAfiliados" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadNavegacionContenido" runat="server">
    <script type="text/javascript">
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navsitiosa_189" runat="server" Text="sitios afiliados"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="sitiosa_189" runat="server" Text="sitios afiliados"></asp:Label>
            </h1>
            <p>
                <img src="/Imagenes/afiliados.jpg" class="fl_left imagenSeparada" />
            </p>
            <asp:Label ID="sa_99005" runat="server" Text="detalle"></asp:Label>
            <br />
            <br />
            <br />
            <br />
        </div>
    </div>
</asp:Content>
