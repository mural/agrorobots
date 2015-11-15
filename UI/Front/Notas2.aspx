<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Notas2.aspx.vb" Inherits="Agorobots.Notas2" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadNavegacionContenido" runat="server">
    <script type="text/javascript">
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navaprenda_92" runat="server" Text="nota"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="aprenda_92" runat="server" Text="nota"></asp:Label>
            </h1>
            <p>
                <img src="/Imagenes/home_2_200x140.png" class="fl_left imagenSeparada" />
            </p>
            <asp:Label ID="n2_99008" runat="server" Text="detalle"></asp:Label>
            <br />
        </div>
    </div>
</asp:Content>