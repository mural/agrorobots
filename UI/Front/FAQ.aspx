<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NavegacionBase.master" CodeBehind="FAQ.aspx.vb" Inherits="Agorobots.FAQ" %>

<asp:Content ID="Nav" ContentPlaceHolderID="NavegacionContenido" runat="server">
    <li>»</li>
    <li>
        <a href="#">
            <asp:Label ID="nvafaq_49" runat="server" Text="faq"></asp:Label>
        </a>
    </li>
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="BodyNavegacionContenido" runat="server">
    <div class="wrapper col4">
        <div id="container">
            <h1>
                <asp:Label ID="titlefaq_49" runat="server" Text="faq">
                </asp:Label>
            </h1>

            <p>
                <img src="/Imagenes/faq.jpg" class="fl_left imagenSeparada" alt="faq" />
            </p>

            <asp:Label ID="faqDetalle_99004" runat="server" Text="faq detalle"></asp:Label>

            <div class="clear" />
        </div>
    </div>
</asp:Content>
