<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="Notas1.aspx.vb" Inherits="Agorobots.Notas1" %>

<asp:Content ID="Head" ContentPlaceHolderID="HeadNavegacionContenido" runat="server">
    <script type="text/javascript">
    </script>
</asp:Content>
<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="navetapas_91" runat="server" Text="nota"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="etapas_91" runat="server" Text="nota"></asp:Label>
            </h1>
            <p>
                <img src="/Imagenes/home_1_200x140.jpg" class="fl_left imagenSeparada" />
            </p>
            <asp:Label ID="n1_99007" runat="server" Text="detalle"></asp:Label>
            <br />
        </div>
    </div>
</asp:Content>